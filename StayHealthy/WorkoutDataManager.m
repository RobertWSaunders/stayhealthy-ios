//
//  WorkoutDataManager.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import "WorkoutDataManager.h"

@implementation WorkoutDataManager

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
            
            Workout *workout = [NSEntityDescription insertNewObjectForEntityForName:[self returnEntityName] inManagedObjectContext:self.appContext];
            
            SHWorkout *SHworkout = (SHWorkout *)object;
            
            [SHworkout map:workout];
            
            NSError *error = nil;
            
            if (![workout.managedObjectContext save:&error]) {
                LogDataError(@"Unable to save workout to managed object context. --> saveItem @ WorkoutDataManager");
                LogDataError(@"%@, %@", error, error.localizedDescription);
            }
            else {
                LogDataSuccess(@"Workout was saved successfully. --> saveItem @ WorkoutDataManager");
            }
        }
    }
}

- (void)updateItem:(id)object {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    SHWorkout *SHworkout = (SHWorkout *)object;
    
    NSError *requestError = nil;
    
    if (SHworkout != nil)
    {
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat: @"workoutIdentifier = %@", SHworkout.workoutIdentifier]];
        
        NSArray *workouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        for (Workout *workout in workouts) {
            
            [SHworkout map:workout];
            
            NSError *error = nil;
            
            if (![workout.managedObjectContext save:&error]) {
                
                LogDataError(@"Unable to update workout to managed object context. --> updateItem @ WorkoutDataManager");
                LogDataError(@"%@, %@", error, error.localizedDescription);
            }
            else {
                LogDataSuccess(@"Workout has been updated successfully. --> updateItem @ WorkoutDataManager");
            }
        }
    }
}

- (id)fetchItemByIdentifier:(NSString *)objectIdentifier {
    if (objectIdentifier != nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
        
        NSError *requestError = nil;
        
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"workoutIdentifier = %@", objectIdentifier]];
        
        NSArray *workouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        if ([workouts count] > 0)
            LogDataSuccess(@"A workout has been found in the database with the identifier: %@ --> fetchItemByIdentifier @ WorkoutDataManager", objectIdentifier);
        return [workouts objectAtIndex:0];
    }
    LogDataError(@"Could not find any workouts with the identifier: %@ --> fetchItemByIdentifier @ WorkoutDataManager", objectIdentifier);
    return nil;
}

- (NSString *)returnEntityName {
    return WORKOUT_ENTITY_NAME;
}


@end
