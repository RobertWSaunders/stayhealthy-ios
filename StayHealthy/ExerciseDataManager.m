//
//  ExerciseDataManager.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-15.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "ExerciseDataManager.h"

@implementation ExerciseDataManager 

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
            Exercise *managedExercise = [NSEntityDescription insertNewObjectForEntityForName:[self returnEntityName] inManagedObjectContext:self.appContext];
            
            //Get the passed SHExercise.
            SHExercise *exercise = (SHExercise *)object;
    
            //Map the SHExercise to the managed exercise.
            [exercise map:managedExercise];
            
            NSError *error = nil;
                
            if (![managedExercise.managedObjectContext save:&error]) {
                LogDataError(@"Exercise could not be saved. --> saveItem @ ExerciseDataManager");
            }
            else {
                LogDataSuccess(@"Exercise was saved successfully with the identifier: %@ and the exercise type of: %@. --> saveItem @ ExerciseDataManager",exercise.exerciseIdentifier,exercise.exerciseType);
                //Post a notification to tell the app that a exercise has been saved.
                [[NSNotificationCenter defaultCenter] postNotificationName:EXERCISE_SAVE_NOTIFICATION object:nil];
            }
        }
    }
}

//Updates an existing object in the persistent store.
- (void)updateItem:(id)object {
    //Make a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    //Get the passed SHExercise.
    SHExercise *exercise = (SHExercise *)object;
    
    NSError *requestError = nil;
    
    if (exercise != nil)
    {
        //Set the fetch request.
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K == %@", @"exerciseIdentifier", exercise.exerciseIdentifier,@"exerciseType",exercise.exerciseType];
        
        [fetchRequest setPredicate:predicate];
        
        //Returned array of fetched exercises.
        NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        for (Exercise *managedExercise in exercises) {
            
            [exercise map:managedExercise];
            
            NSError *error = nil;
                    
            if (![managedExercise.managedObjectContext save:&error]) {
                LogDataError(@"Exercise could not be updated. --> updateItem @ ExerciseDataManager");
            }
            else {
                LogDataSuccess(@"Exercise has been updated successfully. --> updateItem @ ExerciseDataManager");
                //Post notification to tell the rest of the app that a exercise has been updated.
                [[NSNotificationCenter defaultCenter] postNotificationName:EXERCISE_UPDATE_NOTIFICATION object:nil];
            }
        }
    }
}

//Deletes an existing object in the persistent store.
- (void)deleteItem:(id)object {
    //Create a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    //Get the passed SHExercise.
    SHExercise *exercise = (SHExercise *)object;
    
    NSError *requestError = nil;
    
    //Set the fetch request.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K == %@", @"exerciseIdentifier", exercise.exerciseIdentifier,@"exerciseType",exercise.exerciseType];
    
    [fetchRequest setPredicate:predicate];
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    for (Exercise *managedExercise in exercises) {
        
        [exercise map:managedExercise];
        
        [_appContext deleteObject:managedExercise];
        
        NSError *savingError = nil;
        
        if ([_appContext save:&savingError]) {
            LogDataSuccess(@"Exercise has been deleted successfully. --> deleteItem @ ExerciseDataManager");
        }
        else {
            LogDataError(@"Exercise could not be deleted. --> deleteItem @ ExerciseDataManager");
        }
    }
}

//Deletes an existing object with a passed object identifier and exercise type in the persistent store.
- (void)deleteItemByIdentifierAndExerciseType:(NSString *)objectIdentifier exerciseType:(NSString*)exerciseType {
    //Create a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    NSError *requestError = nil;
    
    //Set the fetch request.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K == %@", @"exerciseIdentifier", objectIdentifier,@"exerciseType",exerciseType];
    
    [fetchRequest setPredicate:predicate];
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    for (Exercise *managedExercise in exercises) {
        [_appContext deleteObject:managedExercise];
        
        NSError *savingError = nil;
        
        if ([_appContext save:&savingError]) {
            LogDataSuccess(@"Exercise with the identifier \"%@\" has been deleted successfully. --> deleteItemByIdentifier @ ExerciseDataManager",objectIdentifier);
        }
        else {
            LogDataError(@"Exercise with the identifier \"%@\" could not be deleted. --> deleteItemByIdentifier @ ExerciseDataManager",objectIdentifier);
        }
    }
}

//Deletes an existing object with a passed object identifier in the persistent store.
- (void)deleteItemByIdentifier:(NSString *)objectIdentifier {
    //Create a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    NSError *requestError = nil;
    
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"exerciseIdentifier = %@", objectIdentifier]];
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    for (Exercise *managedExercise in exercises) {
        [_appContext deleteObject:managedExercise];
        
        NSError *savingError = nil;
        
        if ([_appContext save:&savingError]) {
            LogDataSuccess(@"Exercise with the identifier \"%@\" has been deleted successfully. --> deleteItemByIdentifier @ ExerciseDataManager",objectIdentifier);
        }
        else {
            LogDataError(@"Exercise with the identifier \"%@\" could not be deleted. --> deleteItemByIdentifier @ ExerciseDataManager",objectIdentifier);
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
        for (Exercise *managedExercise in itemsToDelete) {
            
            [_appContext deleteObject:managedExercise];
            NSError *savingError = nil;
            
            if ([_appContext save:&savingError]) {
                LogDataSuccess(@"Successfully deleted all core data exercise records. --> deleteAllItems @ ExerciseDataManager");
            }
            else {
                LogDataError(@"Could not delete all core data exercise records. --> deleteAllItems @ ExerciseDataManager");
            }
        }
    }
    else {
        LogDataError(@"Could not find any exercise records in core data. --> deleteAllItems @ ExerciseDataManager.");
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
        
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"exerciseIdentifier = %@", objectIdentifier]];
        
        //Exercises returned from the fetch.
        NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        if (exercises.count > 0) {
            LogDataSuccess(@"Successfully found a exercise with the identifier: %@ --> fetchItemByIdentifier @ ExerciseDataManager", objectIdentifier);
            return [exercises objectAtIndex:0];
        }
        else {
            LogDataError(@"Could not fetch any exercise with the identifier: %@ --> fetchItemByIdentifier @ ExerciseDataManager", objectIdentifier);
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
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (exercises.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the exercise records. --> fetchAllItems @ ExerciseDataManager");
    }
    else {
        LogDataError(@"Could not fetch any exercise records. --> fetchAllItems @ ExerciseDataManager");
    }
    return exercises;
}

//------------------
#define Useful Tools
//------------------

//Returns the entity name for the data manager.
- (NSString *)returnEntityName {
    //Return the defined entity name.
    return EXERCISE_ENTITY_NAME;
}

/***************************************************/
#pragma mark - Exercise Data Manager Specfic Methods
/***************************************************/

//-------------------------
#define Fetching Operations
//-------------------------

//Fetches the recently viewed exercise records from persistent store.
- (id)fetchRecentlyViewedExercises {
    
    //Get the fetch request.
    NSFetchRequest *fetchRequest = [self getRecentlyViewedFetchRequest];
    
    NSError *requestError = nil;
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (exercises.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the recently viewed exercise records. --> fetchRecentlyViewedExercises @ ExerciseDataManager");
    }
    else {
        LogDataError(@"Could not fetch any recently viewed exercise records. --> fetchRecentlyViewedExercises @ ExerciseDataManager");
    }
    
    return exercises;
}

//Fetches all of the liked exercise records.
- (id)fetchAllLikedExercises {
    
    NSFetchRequest *fetchRequest = [self getLikedFetchRequest:nil];
    
    NSError *requestError = nil;
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (exercises.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the liked exercise records. --> fetchAllLikedExercises @ ExerciseDataManager");
    }
    else {
        LogDataError(@"Could not fetch any liked exercise records. --> fetchAllLikedExercises @ ExerciseDataManager");
    }
    
    return exercises;
    
}

//Fetches all of the liked strength exercise records.
- (id)fetchLikedStrengthExercises {
    NSFetchRequest *fetchRequest = [self getLikedFetchRequest:@"strength"];
    
    NSError *requestError = nil;
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (exercises.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the liked strength exercise records. --> fetchLikedStrengthExercises @ ExerciseDataManager");
    }
    else {
        LogDataError(@"Could not fetch any liked strength exercise records. --> fetchLikedStrengthExercises @ ExerciseDataManager");
    }
    
    return exercises;
}

//Fetches all of the liked stretching exercise records.
- (id)fetchLikedStretchingExercises {
    NSFetchRequest *fetchRequest = [self getLikedFetchRequest:@"stretching"];
    
    NSError *requestError = nil;
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (exercises.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the liked stretching exercise records. --> fetchLikedStretchingExercises @ ExerciseDataManager");
    }
    else {
        LogDataError(@"Could not fetch any liked stretching exercise records. --> fetchLikedStretchingExercises @ ExerciseDataManager");
    }
    
    return exercises;
}

//Fetches all of the liked warmup exercise records.
- (id)fetchLikedWarmupExercises {
    NSFetchRequest *fetchRequest = [self getLikedFetchRequest:@"warmup"];
    
    NSError *requestError = nil;
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (exercises.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the liked warmup exercise records. --> fetchLikedWarmupExercises @ ExerciseDataManager");
    }
    else {
        LogDataError(@"Could not fetch any liked warmup exercise records. --> fetchLikedWarmupExercises @ ExerciseDataManager");
    }
    
    return exercises;
}

//Fetches a exercise record given the objects identifier and the exercise type.
- (id)fetchItemByIdentifierAndExerciseType:(NSString *)objectIdentifier exerciseType:(NSString*)exerciseType {
    //Check if object identifier is nil.
    if (objectIdentifier != nil) {
        //Set the fetch request.
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
        
        NSError *requestError = nil;
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K == %@", @"exerciseIdentifier", objectIdentifier,@"exerciseType",exerciseType];
        
        [fetchRequest setPredicate:predicate];
        
        //Exercises returned from the fetch.
        NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        if (exercises.count > 0) {
            LogDataSuccess(@"Successfully found a exercise with the identifier: %@  and the exercise type: %@ --> fetchItemByIdentifier @ ExerciseDataManager", objectIdentifier, exerciseType);
            return [exercises objectAtIndex:0];
        }
        else {
            LogDataError(@"Could not fetch any exercise with the identifier: %@  and the exercise type: %@ --> fetchItemByIdentifier @ ExerciseDataManager", objectIdentifier, exerciseType);
            return nil;
        }
    }
    return nil;
}

//-----------------------------
#define Fetch Requests Creation
//-----------------------------

//Returns the recently viewed fetch request.
- (NSFetchRequest*)getRecentlyViewedFetchRequest {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    NSSortDescriptor *sortByRecentlyViewed = [NSSortDescriptor sortDescriptorWithKey:@"exerciseLastViewed" ascending:NO];
    fetchRequest.sortDescriptors = [[NSArray alloc] initWithObjects:sortByRecentlyViewed, nil];
    return fetchRequest;
}

//Returns the liked fetch request, pass a exercise type for specific liked exercise records fetch request.
- (NSFetchRequest*)getLikedFetchRequest:(NSString*)type {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    if (type == nil) {
         NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@", @"exerciseLiked", [NSNumber numberWithBool:YES]];
         [fetchRequest setPredicate:predicate];
    }
    else {
         NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K == %@", @"exerciseLiked", [NSNumber numberWithBool:YES],@"exerciseType",type];
         [fetchRequest setPredicate:predicate];
    }
   
    return fetchRequest;
}



@end
