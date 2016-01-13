//
//  CustomWorkoutDataManager.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "CustomWorkoutDataManager.h"

@implementation CustomWorkoutDataManager

- (id)init {
    if (self)
    {
        AppDelegate *appDelegate = APPDELEGATE;
        self.appContext = appDelegate.managedObjectContext;
    }
    return self;
}

#pragma mark - Data Manager Protocol Methods

- (void)saveItem:(id)object {
    @synchronized(self.appContext) {
        if (object != nil) {
            
            CustomWorkout *customWorkout = [NSEntityDescription insertNewObjectForEntityForName:[self returnEntityName] inManagedObjectContext:self.appContext];
            
            SHCustomWorkout *SHcustomWorkout = (SHCustomWorkout *)object;
            
            [SHcustomWorkout map:customWorkout];
            
            NSError *error = nil;
            
            if (![customWorkout.managedObjectContext save:&error]) {
                LogDataError(@"Unable to save custom workout to managed object context. --> saveItem @ CustomWorkoutDataManager");
                LogDataError(@"%@, %@", error, error.localizedDescription);
            }
            else {
                [[NSNotificationCenter defaultCenter] postNotificationName:CUSTOM_WORKOUT_SAVE_NOTIFICATION object:nil];
                LogDataSuccess(@"Custom workout was saved successfully. --> addItem @ CustomWorkoutDataManager");
            }
        }
    }
}

- (void)updateItem:(id)object {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    SHCustomWorkout *SHcustomWorkout = (SHCustomWorkout *)object;
    
    NSError *requestError = nil;
    
    if (SHcustomWorkout != nil)
    {
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat: @"workoutID = %@", SHcustomWorkout.workoutID]];
        
        NSArray *customWorkouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        for (CustomWorkout *customWorkout in customWorkouts) {
            
            [SHcustomWorkout map:customWorkout];
            
            NSError *error = nil;
            
            if (![customWorkout.managedObjectContext save:&error]) {
                
                LogDataError(@"Unable to update custom workout to managed object context. --> updateItem @ CustomWorkoutDataManager");
                LogDataError(@"%@, %@", error, error.localizedDescription);
            }
            else {
                [[NSNotificationCenter defaultCenter] postNotificationName:CUSTOM_WORKOUT_UPDATE_NOTIFICATION object:nil];
                LogDataSuccess(@"Custom workout has been updated successfully. --> updateItem @ CustomWorkoutDataManager");
            }
        }
    }
}

- (void)deleteItemById:(NSString *)objectIdentifier {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    NSError *requestError = nil;
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"workoutID = %@", objectIdentifier]];
    
    NSArray *customWorkouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if ([customWorkouts count] > 0) {
        [_appContext deleteObject:[customWorkouts objectAtIndex:0]];
        [[NSNotificationCenter defaultCenter] postNotificationName:CUSTOM_WORKOUT_DELETE_NOTIFICATION object:nil];
         LogDataSuccess(@"A custom workout has been deleted in the database with the identifier: %@ --> deleteItemById @ CustomWorkoutDataManager", objectIdentifier);
    }
    
}

- (id)fetchItemByIdentifier:(NSString *)objectIdentifier {
    if (objectIdentifier != nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
        
        NSError *requestError = nil;
        
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"workoutID = %@", objectIdentifier]];
        
        NSArray *customWorkouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        if ([customWorkouts count] > 0)
            LogDataSuccess(@"A custom workout has been found in the database with the identifier: %@ --> fetchItemByIdentifier @ CustomWorkoutDataManager", objectIdentifier);
        return [customWorkouts objectAtIndex:0];
    }
    LogDataError(@"Could not find any custom workout with the identifier: %@ --> fetchItemByIdentifier @ CustomWorkoutDataManager", objectIdentifier);
    return nil;
}

- (id)fetchAllRecords {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    NSError *requestError = nil;
    
    NSArray *customWorkouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    NSMutableArray *customSHWorkouts = [[NSMutableArray alloc] init];
    
    for (CustomWorkout *customWorkout in customWorkouts) {
        SHCustomWorkout *shcustomWorkout  = [[SHCustomWorkout alloc] init];
        [shcustomWorkout bind:customWorkout];
        [customSHWorkouts addObject:shcustomWorkout];
    }
    
    return customSHWorkouts;
}

- (NSString *)returnEntityName {
    return CUSTOM_WORKOUT_ENTITY_NAME;
}

- (id) fetchAllLikedWorkouts {
    
    NSFetchRequest *fetchRequest = [self getLikedFetchRequest:nil];
    
    NSError *requestError = nil;
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    NSMutableArray *shCustomWorkouts = [[NSMutableArray alloc] init];
    
    for (CustomWorkout *customWorkout in exercises) {
        SHCustomWorkout *customWorkout1 = [[SHCustomWorkout alloc] init];
        [customWorkout1 bind:customWorkout];
        [shCustomWorkouts addObject:customWorkout1];
     }
    
    return shCustomWorkouts;
    
}

- (NSFetchRequest *) getLikedFetchRequest:(NSString*)type {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"liked", [NSNumber numberWithBool:YES]];
    [fetchRequest setPredicate:predicate];
    
    return fetchRequest;
}


@end
