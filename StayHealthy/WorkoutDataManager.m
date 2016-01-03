//
//  WorkoutDataManager.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
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
                [[NSNotificationCenter defaultCenter] postNotificationName:WORKOUT_SAVE_NOTIFICATION object:nil];
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
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat: @"workoutID = %@", SHworkout.workoutIdentifier]];
        
        NSArray *workouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        for (Workout *workout in workouts) {
            
            [SHworkout map:workout];
            
            NSError *error = nil;
            
            if (![workout.managedObjectContext save:&error]) {
                
                LogDataError(@"Unable to update workout to managed object context. --> updateItem @ WorkoutDataManager");
                LogDataError(@"%@, %@", error, error.localizedDescription);
            }
            else {
                [[NSNotificationCenter defaultCenter] postNotificationName:WORKOUT_UPDATE_NOTIFICATION object:nil];
                LogDataSuccess(@"Workout has been updated successfully. --> updateItem @ WorkoutDataManager");
            }
        }
    }
}


- (id)fetchItemByIdentifier:(NSString *)objectIdentifier {
    
    if (objectIdentifier != nil) {
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
        
        NSError *requestError = nil;
        
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"workoutID = %@", objectIdentifier]];
        
        NSArray *workouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        
        if (workouts.count > 0) {
            LogDataSuccess(@"A workout has been found in the database with the identifier: %@ --> fetchItemByIdentifier @ WorkoutManager", objectIdentifier);
            return [workouts objectAtIndex:0];
        }
        
        else {
            LogDataError(@"Could not find any workout with the identifier: %@ --> fetchItemByIdentifier @ WorkoutManager", objectIdentifier);
            return nil;
        }
    }
    return nil;
}

- (NSString *)returnEntityName {
    return WORKOUT_ENTITY_NAME;
}

- (id) fetchRecentlyViewedWorkouts {
    
    NSFetchRequest *fetchRequest = [self getRecentlyViewedFetchRequest];
    
    NSError *requestError = nil;
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    return exercises;
}

- (id) fetchAllLikedWorkouts {
    
    NSFetchRequest *fetchRequest = [self getLikedFetchRequest:nil];
    
    NSError *requestError = nil;
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    return exercises;
    
}

#pragma mark - Helper Methods

- (NSFetchRequest *) getRecentlyViewedFetchRequest {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    NSSortDescriptor *sortByRecentlyViewed = [NSSortDescriptor sortDescriptorWithKey:@"lastViewed" ascending:NO];
    fetchRequest.sortDescriptors = [[NSArray alloc] initWithObjects:sortByRecentlyViewed, nil];
    return fetchRequest;
}

- (NSFetchRequest *) getLikedFetchRequest:(NSString*)type {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"liked", [NSNumber numberWithBool:YES]];
    [fetchRequest setPredicate:predicate];

    return fetchRequest;
}


@end
