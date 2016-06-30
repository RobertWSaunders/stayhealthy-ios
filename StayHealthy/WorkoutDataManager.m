//
//  WorkoutDataManager.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "WorkoutDataManager.h"

@implementation WorkoutDataManager

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
            Workout *managedWorkout = [NSEntityDescription insertNewObjectForEntityForName:[self returnEntityName] inManagedObjectContext:self.appContext];
            
            //Get the passed SHExercise.
            SHWorkout *workout = (SHWorkout *)object;
            
            //Map the SHExercise to the managed exercise.
            [workout map:managedWorkout];
            
            NSError *error = nil;
            
            if (![managedWorkout.managedObjectContext save:&error]) {
                LogDataError(@"Workout could not be saved. --> saveItem @ WorkoutDataManager");
            }
            else {
                LogDataSuccess(@"Workout was saved successfully. --> saveItem @ WorkoutDataManager");
                //Post a notification to tell the app that a workout has been saved.
                [[NSNotificationCenter defaultCenter] postNotificationName:WORKOUT_SAVE_NOTIFICATION object:nil];
            }
        }
    }
}

//Updates an existing object in the persistent store.
- (void)updateItem:(id)object {
    //Make a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    //Get the passed SHExercise.
    SHWorkout *workout = (SHWorkout *)object;
    
    NSError *requestError = nil;
    
    if (workout != nil)
    {
        //Set the fetch request.
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat: @"workoutIdentifier = %@", workout.workoutIdentifier]];
        
        //Returned array of fetched exercises.
        NSArray *workouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        for (Workout *managedWorkout in workouts) {
            
            [workout map:managedWorkout];
            
            NSError *error = nil;
            
            if (![managedWorkout.managedObjectContext save:&error]) {
                LogDataError(@"Workout could not be updated. --> updateItem @ WorkoutDataManager");
            }
            else {
                LogDataSuccess(@"Exercise has been updated successfully. --> updateItem @ WorkoutDataManager");
                //Post notification to tell the rest of the app that a exercise has been updated.
                [[NSNotificationCenter defaultCenter] postNotificationName:WORKOUT_UPDATE_NOTIFICATION object:nil];
            }
        }
    }
}

//Deletes an existing object in the persistent store.
- (void)deleteItem:(id)object {
    //Create a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    //Get the passed SHExercise.
    SHWorkout *workout = (SHWorkout *)object;
    
    NSError *requestError = nil;
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"workoutIdentifier = %@", workout.workoutIdentifier]];
    
    NSArray *workouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    for (Workout *managedWorkout in workouts) {
        
        [workout map:managedWorkout];
        
        [_appContext deleteObject:managedWorkout];
        
        NSError *savingError = nil;
        
        if ([_appContext save:&savingError]) {
            LogDataSuccess(@"Workout has been deleted successfully. --> deleteItem @ WorkoutDataManager");
        }
        else {
            LogDataError(@"Workout could not be deleted. --> deleteItem @ WorkoutDataManager");
        }
    }
}

//Deletes an existing object with a passed object identifier in the persistent store.
- (void)deleteItemByIdentifier:(NSString *)objectIdentifier {
    //Create a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    NSError *requestError = nil;
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"workoutIdentifier = %@", objectIdentifier]];
    
    NSArray *workouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    for (Workout *managedWorkout in workouts) {
        [_appContext deleteObject:managedWorkout];
        
        NSError *savingError = nil;
        
        if ([_appContext save:&savingError]) {
            LogDataSuccess(@"Workout with the identifier \"%@\" has been deleted successfully. --> deleteItemByIdentifier @ WorkoutDataManager",objectIdentifier);
        }
        else {
            LogDataError(@"Workout with the identifier \"%@\" could not be deleted. --> deleteItemByIdentifier @ WorkoutDataManager",objectIdentifier);
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
        for (Workout *managedWorkouts in itemsToDelete) {
            
            [_appContext deleteObject:managedWorkouts];
            NSError *savingError = nil;
            
            if ([_appContext save:&savingError]) {
                LogDataSuccess(@"Successfully deleted all core data workout records. --> deleteAllItems @ WorkoutDataManager");
            }
            else {
                LogDataError(@"Could not delete all core data workout records. --> deleteAllItems @ WorkoutDataManager");
            }
        }
    }
    else {
        LogDataError(@"Could not find any workout records in core data. --> deleteAllItems @ WorkoutDataManager.");
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
        NSArray *workouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        if (workouts.count > 0) {
            LogDataSuccess(@"Successfully found a workout with the identifier: %@ --> fetchItemByIdentifier @ WorkoutDataManager", objectIdentifier);
            return [workouts objectAtIndex:0];
        }
        else {
            LogDataError(@"Could not fetch any workout with the identifier: %@ --> fetchItemByIdentifier @ WorkoutDataManager", objectIdentifier);
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
    NSArray *workouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (workouts.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the workout records. --> fetchAllItems @ WorkoutDataManager");
    }
    else {
        LogDataError(@"Could not fetch any workout records. --> fetchAllItems @ WorkoutDataManager");
    }
    return workouts;
}

//------------------
#define Useful Tools
//------------------

//Returns the entity name for the data manager.
- (NSString *)returnEntityName {
    //Return the defined entity name.
    return WORKOUT_ENTITY_NAME;
}

/***************************************************/
#pragma mark - Workout Data Manager Specfic Methods
/***************************************************/

//-------------------------
#define Fetching Operations
//-------------------------

//Fetches all of the recently viewed workouts.
- (id)fetchRecentlyViewedWorkouts {
    
    NSFetchRequest *fetchRequest = [self getRecentlyViewedFetchRequest];
    
    NSError *requestError = nil;
    
    NSArray *workouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (workouts.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the recently viewed workout records. --> fetchRecentlyViewedWorkouts @ WorkoutDataManager");
    }
    else {
        LogDataError(@"Could not fetch any recently viewed workout records. --> fetchRecentlyViewedWorkouts @ WorkoutDataManager");
    }
    
    return workouts;
}

//Fetches all of the liked workouts
- (id)fetchAllLikedWorkouts {
    
    NSFetchRequest *fetchRequest = [self getLikedFetchRequest];
    
    NSError *requestError = nil;
    
    NSArray *workouts = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (workouts.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the liked exercise records. --> fetchAllLikedWorkouts @ WorkoutDataManager");
    }
    else {
        LogDataError(@"Could not fetch any liked exercise records. --> fetchAllLikedWorkouts @ WorkoutDataManager");
    }
    
    return workouts;
}

//-----------------------------
#define Fetch Requests Creation
//-----------------------------

//Returns the recently viewed fetch request.
- (NSFetchRequest*)getRecentlyViewedFetchRequest {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    NSSortDescriptor *sortByRecentlyViewed = [NSSortDescriptor sortDescriptorWithKey:@"workoutLastViewed" ascending:NO];
    fetchRequest.sortDescriptors = [[NSArray alloc] initWithObjects:sortByRecentlyViewed, nil];
    return fetchRequest;
}

//Returns the liked fetch request,
- (NSFetchRequest*)getLikedFetchRequest {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"workoutLiked", [NSNumber numberWithBool:YES]];
    [fetchRequest setPredicate:predicate];

    return fetchRequest;
}


@end
