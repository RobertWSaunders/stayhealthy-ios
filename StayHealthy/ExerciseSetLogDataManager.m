//
//  ExerciseSetLogDataManager.m
//  StayHealthy
//
//  Created by Robert Saunders on 2016-06-25.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "ExerciseSetLogDataManager.h"

@implementation ExerciseSetLogDataManager

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
            ExerciseSetLog *managedExercise = [NSEntityDescription insertNewObjectForEntityForName:[self returnEntityName] inManagedObjectContext:self.appContext];
            
            //Get the passed SHExerciseLog.
            SHExerciseSetLog *exerciseSetLog = (SHExerciseSetLog *)object;
            
            //Map the SHExercise to the managed exercise.
            [exerciseSetLog map:managedExercise];
            
            NSError *error = nil;
            
            if (![managedExercise.managedObjectContext save:&error]) {
                LogDataError(@"Exercise set log could not be saved. --> saveItem @ ExerciseSetLogDataManager");
            }
            else {
                LogDataSuccess(@"Exercise set log was saved successfully saved. --> saveItem @ ExerciseSetLogDataManager");
                //Post a notification to tell the app that a exercise set log has been saved.
                [[NSNotificationCenter defaultCenter] postNotificationName:EXERCISE_SET_LOG_SAVE_NOTIFICATION object:nil];
            }
        }
    }
}

//Updates an existing object in the persistent store.
- (void)updateItem:(id)object {
    //Make a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    //Get the passed SHExerciseLog.
    SHExerciseSetLog *exerciseSetLog = (SHExerciseSetLog *)object;
    
    NSError *requestError = nil;
    
    if (exerciseSetLog != nil)
    {
        //Set the fetch request.
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"exerciseSetIdentifier",exerciseSetLog.exerciseSetIdentifier];
        
        [fetchRequest setPredicate:predicate];
        
        //Returned array of fetched logs.
        NSArray *logs = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        for (ExerciseSetLog *managedExercise in logs) {
            
            [exerciseSetLog map:managedExercise];
            
            NSError *error = nil;
            
            if (![managedExercise.managedObjectContext save:&error]) {
                LogDataError(@"Exercise set log could not be updated. --> updateItem @ ExerciseSetLogDataManager");
            }
            else {
                LogDataSuccess(@"Exercise set log has been updated successfully. --> updateItem @ ExerciseSetLogDataManager");
                //Post notification to tell the rest of the app that an exercise set has been updated.
                [[NSNotificationCenter defaultCenter] postNotificationName:EXERCISE_SET_LOG_UPDATE_NOTIFICATION object:nil];
            }
        }
    }
}

//Deletes an existing object in the persistent store.
- (void)deleteItem:(id)object {
    //Create a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    //Get the passed SHExerciseLog.
    SHExerciseSetLog *exerciseSetLog = (SHExerciseSetLog *)object;
    
    NSError *requestError = nil;
    
    //Set the fetch request.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ ", @"exerciseSetIdentifier", exerciseSetLog.exerciseSetIdentifier];
    
    [fetchRequest setPredicate:predicate];
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    for (ExerciseSetLog *managedExercise in exercises) {
        
        [exerciseSetLog map:managedExercise];
        
        [_appContext deleteObject:managedExercise];
        
        NSError *savingError = nil;
        
        if ([_appContext save:&savingError]) {
            LogDataSuccess(@"Exercise set log has been deleted successfully. --> deleteItem @ ExerciseSetLogDataManager");
            [[NSNotificationCenter defaultCenter] postNotificationName:EXERCISE_SET_LOG_DELETE_NOTIFICATION object:nil];
        }
        else {
            LogDataError(@"Exercise set log could not be deleted. --> deleteItem @ ExerciseSetLogDataManager");
        }
    }
}

//Deletes an existing object with a passed object identifier in the persistent store.
- (void)deleteItemByIdentifier:(NSString *)objectIdentifier {
    //Create a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    NSError *requestError = nil;
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"exerciseSetIdentifier = %@", objectIdentifier]];
    
    NSArray *exerciseLogs = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    for (ExerciseSetLog *managedExercise in exerciseLogs) {
        [_appContext deleteObject:managedExercise];
        
        NSError *savingError = nil;
        
        if ([_appContext save:&savingError]) {
            LogDataSuccess(@"Exercise set log with the identifier \"%@\" has been deleted successfully. --> deleteItemByIdentifier @ ExerciseSetLogDataManager",objectIdentifier);
            [[NSNotificationCenter defaultCenter] postNotificationName:EXERCISE_SET_LOG_DELETE_NOTIFICATION object:nil];
        }
        else {
            LogDataError(@"Exercise set log with the identifier \"%@\" could not be deleted. --> deleteItemByIdentifier @ ExerciseSetLogDataManager",objectIdentifier);
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
        for (ExerciseSetLog *managedExercise in itemsToDelete) {
            
            [_appContext deleteObject:managedExercise];
            NSError *savingError = nil;
            
            if ([_appContext save:&savingError]) {
                LogDataSuccess(@"Successfully deleted all core data exercise set log records. --> deleteAllItems @ ExerciseSetLogDataManager");
                [[NSNotificationCenter defaultCenter] postNotificationName:EXERCISE_SET_LOG_DELETE_NOTIFICATION object:nil];
            }
            else {
                LogDataError(@"Could not delete all core data exercise set log records. --> deleteAllItems @ ExerciseSetLogDataManager");
            }
        }
    }
    else {
        LogDataError(@"Could not find any exercise set log records in core data. --> deleteAllItems @ ExerciseSetLogDataManager.");
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
        
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"exerciseSetIdentifier = %@", objectIdentifier]];
        
        //Exercises returned from the fetch.
        NSArray *exerciseLogs = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        if (exerciseLogs.count > 0) {
            LogDataSuccess(@"Successfully found a exercise set log with the identifier: %@ --> fetchItemByIdentifier @ ExerciseSetLogDataManager", objectIdentifier);
            return [exerciseLogs objectAtIndex:0];
        }
        else {
            LogDataError(@"Could not fetch any exercise set log with the identifier: %@ --> fetchItemByIdentifier @ ExerciseSetLogDataManager", objectIdentifier);
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
    NSArray *exerciseLogs = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (exerciseLogs.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the exercise set log records. --> fetchAllItems @ ExerciseLogDataManager");
    }
    else {
        LogDataError(@"Could not fetch any exercise set log records. --> fetchAllItems @ ExerciseLogDataManager");
    }
    return exerciseLogs;
}

//------------------
#define Useful Tools
//------------------

//Returns the entity name for the data manager.
- (NSString *)returnEntityName {
    //Return the defined entity name.
    return EXERCISE_SET_LOG_ENTITY_NAME;
}

/***********************************************************/
#pragma mark - Exercise Set Log Data Manager Specfic Methods
/***********************************************************/

//-------------------------
#define Fetching Operations
//-------------------------


@end
