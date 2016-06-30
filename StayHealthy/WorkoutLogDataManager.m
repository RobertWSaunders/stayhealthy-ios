//
//  WorkoutLogDataManager.m
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-29.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "WorkoutLogDataManager.h"

@implementation WorkoutLogDataManager

//Initialize the data manager.
- (id)init {
    if (self)
    {
        //Set the app delegate to the global declaration for reference.
        AppDelegate *appDelegate = APPDELEGATE;
        //Set the context defined in the header for reference.
        self.appContext = appDelegate.managedObjectContext;
    }
    return self;
}

/***********************************/
#pragma mark - Data Manager Protocol
/***********************************/

//------------------------
#define General Operations
//------------------------

//Saves a object to the persistent store.
- (void)saveItem:(id)object {
    @synchronized(self.appContext) {
        if (object != nil) {
            //Create a new record in the persistent store.
            WorkoutLog *managedWorkoutLog = [NSEntityDescription insertNewObjectForEntityForName:[self returnEntityName] inManagedObjectContext:self.appContext];
            
            //Get the passed SHExerciseLog.
            SHWorkoutLog *workoutLog = (SHWorkoutLog *)object;
            
            //Map the SHExercise to the managed exercise.
            [workoutLog map:managedWorkoutLog];
            
            NSError *error = nil;
            
            if (![managedWorkoutLog.managedObjectContext save:&error]) {
                LogDataError(@"Workout log could not be saved. --> saveItem @ WorkoutLogDataManager");
            }
            else {
                LogDataSuccess(@"Workout log was saved successfully saved. --> saveItem @ WorkoutLogDataManager");
                //Post a notification to tell the app that a exercise has been saved.
                [[NSNotificationCenter defaultCenter] postNotificationName:WORKOUT_LOG_SAVE_NOTIFICATION object:nil];
            }
        }
    }
}

//Updates an existing object in the persistent store.
- (void)updateItem:(id)object {
    //Make a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    //Get the passed SHWorkoutLog.
    SHWorkoutLog *workoutLog = (SHWorkoutLog *)object;
    
    NSError *requestError = nil;
    
    if (workoutLog != nil)
    {
        //Set the fetch request.
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"workoutLogIdentifier",workoutLog.workoutLogIdentifier];
        
        [fetchRequest setPredicate:predicate];
        
        //Returned array of fetched logs.
        NSArray *logs = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        for (WorkoutLog *managedWorkoutLog in logs) {
            
            [workoutLog map:managedWorkoutLog];
            
            NSError *error = nil;
            
            if (![managedWorkoutLog.managedObjectContext save:&error]) {
                LogDataError(@"Workout log could not be updated. --> updateItem @ WorkoutLogDataManager");
            }
            else {
                LogDataSuccess(@"Workout log has been updated successfully. --> updateItem @ WorkoutLogDataManager");
                //Post notification to tell the rest of the app that a exercise has been updated.
                [[NSNotificationCenter defaultCenter] postNotificationName:WORKOUT_LOG_UPDATE_NOTIFICATION object:nil];
            }
        }
    }
}

//Deletes an existing object in the persistent store.
- (void)deleteItem:(id)object {
    //Create a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    //Get the passed SHWorkoutLog.
    SHWorkoutLog *workoutLog = (SHWorkoutLog *)object;
    
    NSError *requestError = nil;
    
    //Set the fetch request.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ ", @"workoutLogIdentifier", workoutLog.workoutLogIdentifier];
    
    [fetchRequest setPredicate:predicate];
    
    NSArray *workoutLogs = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    for (WorkoutLog *managedWorkoutLog in workoutLogs) {
        
        [workoutLog map:managedWorkoutLog];
        
        [_appContext deleteObject:managedWorkoutLog];
        
        NSError *savingError = nil;
        
        if ([_appContext save:&savingError]) {
            LogDataSuccess(@"Workout log has been deleted successfully. --> deleteItem @ WorkoutLogDataManager");
            [[NSNotificationCenter defaultCenter] postNotificationName:WORKOUT_LOG_DELETE_NOTIFICATION object:nil];
        }
        else {
            LogDataError(@"Workout log could not be deleted. --> deleteItem @ WorkoutLogDataManager");
        }
    }
}

//Deletes an existing object with a passed object identifier in the persistent store.
- (void)deleteItemByIdentifier:(NSString *)objectIdentifier {
    //Create a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    NSError *requestError = nil;
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"logIdentifier = %@", objectIdentifier]];
    
    NSArray *workoutLogs = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    for (WorkoutLog *managedWorkoutLog in workoutLogs) {
        [_appContext deleteObject:managedWorkoutLog];
        
        NSError *savingError = nil;
        
        if ([_appContext save:&savingError]) {
            LogDataSuccess(@"Workout log with the identifier \"%@\" has been deleted successfully. --> deleteItemByIdentifier @ WorkoutLogDataManager",objectIdentifier);
            [[NSNotificationCenter defaultCenter] postNotificationName:WORKOUT_LOG_DELETE_NOTIFICATION object:nil];
        }
        else {
            LogDataError(@"Workout log with the identifier \"%@\" could not be deleted. --> deleteItemByIdentifier @ WorkoutLogDataManager",objectIdentifier);
        }
    }
}

//Deletes all of the objects in the persistent store for the entity.
- (void)deleteAllItems {
    //Set the fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    //Set the fetch request batch size, to reduce memory burden.
    [fetchRequest setFetchBatchSize:20];
    
    NSError *requestError = nil;
    //Get items to delete.
    NSArray *itemsToDelete = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if ([itemsToDelete count] > 0) {
        for (WorkoutLog *managedWorkout in itemsToDelete) {
            
            [_appContext deleteObject:managedWorkout];
            NSError *savingError = nil;
            
            if ([_appContext save:&savingError]) {
                LogDataSuccess(@"Successfully deleted all core data workout log records. --> deleteAllItems @ WorkoutLogDataManager");
                [[NSNotificationCenter defaultCenter] postNotificationName:WORKOUT_LOG_DELETE_NOTIFICATION object:nil];
            }
            else {
                LogDataError(@"Could not delete all core data workout log records. --> deleteAllItems @ WorkoutLogDataManager");
            }
        }
    }
    else {
        LogDataError(@"Could not find any workout log records in core data. --> deleteAllItems @ WorkoutLogDataManager.");
    }
}

//-------------------------
#define Fetching Operations
//-------------------------

//Fetches an existing object with a passed object identifier in the persistent store.
- (id)fetchItemByIdentifier:(NSString *)objectIdentifier {
    //Check if object identifier is nil.
    if (objectIdentifier != nil) {
        //Set the fetch request.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
        
        NSError *requestError = nil;
        
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"workoutLogIdentifier = %@", objectIdentifier]];
        
        //Exercises returned from the fetch.
        NSArray *workoutLogs = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        if (workoutLogs.count > 0) {
            LogDataSuccess(@"Successfully found a workout log with the identifier: %@ --> fetchItemByIdentifier @ WorkoutLogDataManager", objectIdentifier);
            return [workoutLogs objectAtIndex:0];
        }
        else {
            LogDataError(@"Could not fetch any workout logs with the identifier: %@ --> fetchItemByIdentifier @ WorkoutLogDataManager", objectIdentifier);
            return nil;
        }
    }
    return nil;
}

//Fetches all of the items in the persistent store for the entity.
- (NSArray *)fetchAllItems {
    //Set the fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    //Set the fetch batch size to reduce memory burden.
    [fetchRequest setFetchBatchSize:20];
    
    NSError *requestError = nil;
    
    //Exercises returned from the fetch.
    NSArray *workoutLogs = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (workoutLogs.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the workout log records. --> fetchAllItems @ WorkoutLogDataManager");
    }
    else {
        LogDataError(@"Could not fetch any workout log records. --> fetchAllItems @ WorkoutLogDataManager");
    }
    return workoutLogs;
}

//------------------
#define Useful Tools
//------------------

//Returns the entity name for the data manager.
- (NSString *)returnEntityName {
    //Return the defined entity name.
    return WORKOUT_LOG_ENTITY_NAME;
}

/***************************************************/
#pragma mark - Workout Data Manager Specfic Methods
/***************************************************/

//-------------------------
#define Fetching Operations
//-------------------------


@end
