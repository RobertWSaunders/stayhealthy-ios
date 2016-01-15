//
//  CustomWorkoutDataManager.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "CustomWorkoutDataManager.h"

@implementation CustomWorkoutDataManager

//Initialize the data manager.
- (id)init {
    if (self)
    {
        AppDelegate *appDelegate = APPDELEGATE;
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
            CustomWorkout *managedCustomWorkout = [NSEntityDescription insertNewObjectForEntityForName:[self returnEntityName] inManagedObjectContext:self.appContext];
            
            //Get the passed SHExercise.
            SHCustomWorkout *customWorkout = (SHCustomWorkout *)object;
            
            //Map the SHExercise to the managed exercise.
            [customWorkout map:managedCustomWorkout];
            
            NSError *error = nil;
            
            if (![managedCustomWorkout.managedObjectContext save:&error]) {
                LogDataError(@"Custom workout could not be saved. --> saveItem @ CustomWorkoutDataManager");
            }
            else {
                LogDataSuccess(@"Custom workout was saved successfully. --> saveItem @ CustomWorkoutDataManager");
                //Post a notification to tell the app that a custom workout has been saved.
                [[NSNotificationCenter defaultCenter] postNotificationName:CUSTOM_WORKOUT_SAVE_NOTIFICATION object:nil];
            }
        }
    }
}

//Updates an existing object in the persistent store.
- (void)updateItem:(id)object {
    //Make a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    //Get the passed SHExercise.
    SHCustomWorkout *customWorkout = (SHCustomWorkout *)object;
    
    NSError *requestError = nil;
    
    if (customWorkout != nil)
    {
        //Set the fetch request.
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat: @"workoutIdentifier = %@", customWorkout.workoutID]];
        
        //Returned array of fetched exercises.
        NSArray *customWorkouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        for (CustomWorkout *manageCustomWorkout in customWorkouts) {
            
            [customWorkout map:manageCustomWorkout];
            
            NSError *error = nil;
            
            if (![manageCustomWorkout.managedObjectContext save:&error]) {
                LogDataError(@"Custom workout could not be updated. --> updateItem @ CustomWorkoutDataManager");
            }
            else {
                LogDataSuccess(@"Custom workout has been updated successfully. --> updateItem @ CustomWorkoutDataManager");
                //Post notification to tell the rest of the app that a custom workout has been updated.
                [[NSNotificationCenter defaultCenter] postNotificationName:CUSTOM_WORKOUT_UPDATE_NOTIFICATION object:nil];
            }
        }
    }
}

//Deletes an existing object in the persistent store.
- (void)deleteItem:(id)object {
    //Create a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    //Get the passed SHExercise.
    SHCustomWorkout *customWorkout = (SHCustomWorkout *)object;
    
    NSError *requestError = nil;
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"workoutIdentifier = %@", customWorkout.workoutID]];
    
    NSArray *customWorkouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    for (CustomWorkout *managedCustomWorkout in customWorkouts) {
        
        [customWorkout map:managedCustomWorkout];
        
        [_appContext deleteObject:managedCustomWorkout];
        
        NSError *savingError = nil;
        
        if ([_appContext save:&savingError]) {
            LogDataSuccess(@"Custom workout has been deleted successfully. --> deleteItem @ CustomWorkoutDataManager");
            //Post notification to tell the rest of the app that a custom workout has been deleted.
            [[NSNotificationCenter defaultCenter] postNotificationName:CUSTOM_WORKOUT_DELETE_NOTIFICATION object:nil];
        }
        else {
            LogDataError(@"Custom workout could not be deleted. --> deleteItem @ CustomWorkoutDataManager");
        }
    }
}

//Deletes an existing object with a passed object identifier in the persistent store.
- (void)deleteItemByIdentifier:(NSString *)objectIdentifier {
    //Create a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    NSError *requestError = nil;
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"workoutIdentifier = %@", objectIdentifier]];
    
    NSArray *customWorkouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    for (CustomWorkout *managedCustomWorkout in customWorkouts) {
        [_appContext deleteObject:managedCustomWorkout];
        
        NSError *savingError = nil;
        
        if ([_appContext save:&savingError]) {
            LogDataSuccess(@"Custom workout with the identifier \"%@\" has been deleted successfully. --> CustomWorkoutDataManager @ ExerciseDataManager",objectIdentifier);
            //Post notification to tell the rest of the app that a custom workout has been deleted.
            [[NSNotificationCenter defaultCenter] postNotificationName:CUSTOM_WORKOUT_DELETE_NOTIFICATION object:nil];
        }
        else {
            LogDataError(@"Custom workout with the identifier \"%@\" could not be deleted. --> deleteItemByIdentifier @ CustomWorkoutDataManager",objectIdentifier);
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
        for (CustomWorkout *managedCustomWorkout in itemsToDelete) {
            
            [_appContext deleteObject:managedCustomWorkout];
            NSError *savingError = nil;
            
            if ([_appContext save:&savingError]) {
                LogDataSuccess(@"Successfully deleted all core data custom workout records. --> deleteAllItems @ CustomWorkoutDataManager");
                //Post notification to tell the rest of the app that a custom workout has been deleted.
                [[NSNotificationCenter defaultCenter] postNotificationName:CUSTOM_WORKOUT_DELETE_NOTIFICATION object:nil];
            }
            else {
                LogDataError(@"Could not delete all core data custom workout records. --> deleteAllItems @ CustomWorkoutDataManager");
            }
        }
    }
    else {
        LogDataError(@"Could not find any custom workout records in core data. --> deleteAllItems @ CustomWorkoutDataManager.");
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
        
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"workoutIdentifier = %@", objectIdentifier]];
        
        //Exercises returned from the fetch.
        NSArray *customWorkouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        if (customWorkouts.count > 0) {
            LogDataSuccess(@"Successfully found a custom workout with the identifier: %@ --> fetchItemByIdentifier @ CustomWorkoutDataManager", objectIdentifier);
            return [customWorkouts objectAtIndex:0];
        }
        else {
            LogDataError(@"Could not fetch any custom workouts with the identifier: %@ --> fetchItemByIdentifier @ ExerciseDataManager", objectIdentifier);
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
    NSArray *customWorkouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (customWorkouts.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the custom workout records. --> fetchAllItems @ CustomWorkoutDataManager");
    }
    else {
        LogDataError(@"Could not fetch any custom workout records. --> fetchAllItems @ CustomWorkoutDataManager");
    }
    return customWorkouts;
}

//------------------
#define Useful Tools
//------------------

//Returns the entity name for the data manager.
- (NSString *)returnEntityName {
    //Return the defined entity name.
    return CUSTOM_WORKOUT_ENTITY_NAME;
}

/*********************************************************/
#pragma mark - Custom Workout Data Manager Specfic Methods
/*********************************************************/

//-------------------------
#define Fetching Operations
//-------------------------

//Fetches all of the liked custom workout records.
- (id)fetchAllLikedCustomWorkouts {
    
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

//-----------------------------
#define Fetch Requests Creation
//-----------------------------

//Returns the liked fetch request.
- (NSFetchRequest*)getLikedFetchRequest {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"liked", [NSNumber numberWithBool:YES]];
    [fetchRequest setPredicate:predicate];
    
    return fetchRequest;
}


@end
