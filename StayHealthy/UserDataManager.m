//
//  UserDataManager.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-18.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import "UserDataManager.h"

@implementation UserDataManager

- (id)init {
    if (self)
    {
        AppDelegate *appDelegate = APPDELEGATE;
        self.appContext = appDelegate.managedObjectContext;
    }
    return self;
}

-(void)saveItem:(id)object {
    @synchronized(self.appContext) {
        if (object != nil) {
            
            User *user = [NSEntityDescription insertNewObjectForEntityForName:[self returnEntityName] inManagedObjectContext:self.appContext];
            
            SHUser *SHuser = (SHUser *)object;
            
            [SHuser map:user];
            
            NSError *error = nil;
            
            if (![user.managedObjectContext save:&error]) {
                LogDataError(@"Unable to save user to managed object context. --> saveItem @ UserDataManager");
                LogDataError(@"%@, %@", error, error.localizedDescription);
            }
            else {
                LogDataSuccess(@"Exercise was saved successfully. --> saveItem @ UserDataManager");
            }
        }
    }
}

- (void)updateItem:(id)object {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    SHUser *SHuser = (SHUser *)object;
    
    NSError *requestError = nil;
    
    if (SHuser != nil)
    {
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat: @"userID = %@", SHuser.userID]];
        
        NSArray *users = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        for (User *user in users) {
            
            [SHuser map:user];
            
            NSError *error = nil;
            
            if (![user.managedObjectContext save:&error]) {
                
                LogDataError(@"Unable to update user to managed object context. --> updateItem @ UserDataManager");
                LogDataError(@"%@, %@", error, error.localizedDescription);
            }
            else {
                LogDataSuccess(@"User has been updated successfully. --> updateItem @ UserDataManager");
            }
        }
    }
}


- (NSString *)returnEntityName {
    return USER_ENTITY_NAME;
}

- (BOOL)userIsCreated {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    NSError *requestError = nil;
    
    NSArray *users = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (users.count == 0) {
        return NO;
    }
    else {
        return YES;
    }
}

- (NSString *)getUserID {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    NSError *requestError = nil;
    
    NSArray *users = [_appContext executeFetchRequest:fetchRequest error:&requestError];

    User *user = [users firstObject];
    
    SHUser *shuser = [[SHUser alloc] init];
    
    [shuser bind:user];
    
    if (users.count > 0) {
        
        return shuser.userID;
    }
   
    return nil;
}

@end
