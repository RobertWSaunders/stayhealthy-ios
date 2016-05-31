//
//  CustomExerciseDataManager.m
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-19.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "CustomExerciseDataManager.h"

@implementation CustomExerciseDataManager

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
            CustomExercise *managedExercise = [NSEntityDescription insertNewObjectForEntityForName:[self returnEntityName] inManagedObjectContext:self.appContext];
            
            //Get the passed SHCustomExercise.
            SHCustomExercise *customExercise = (SHCustomExercise *)object;
            
            //Map the SHExercise to the managed exercise.
            [customExercise map:managedExercise];
            
            NSError *error = nil;
            
            if (![managedExercise.managedObjectContext save:&error]) {
                LogDataError(@"Custom Exercise could not be saved. --> saveItem @ CustomExerciseDataManager");
            }
            else {
                LogDataSuccess(@"Custom Exercise was saved successfully with the identifier: %@ and the exercise type of: %@. --> saveItem @ CustomExerciseDataManager",customExercise.exerciseIdentifier,customExercise.exerciseType);
                //Post a notification to tell the app that a exercise has been saved.
                [[NSNotificationCenter defaultCenter] postNotificationName:CUSTOM_EXERCISE_SAVE_NOTIFICATION object:nil];
            }
        }
    }
}

//Updates an existing object in the persistent store.
- (void)updateItem:(id)object {
    //Make a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    //Get the passed SHCustomExercise.
    SHCustomExercise *customExercise = (SHCustomExercise *)object;
    
    NSError *requestError = nil;
    
    if (customExercise != nil)
    {
        //Set the fetch request.
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K == %@", @"exerciseIdentifier", customExercise.exerciseIdentifier,@"exerciseType",customExercise.exerciseType];
        
        [fetchRequest setPredicate:predicate];
        
        //Returned array of fetched exercises.
        NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
        
        for (CustomExercise *managedExercise in exercises) {
            
            [customExercise map:managedExercise];
            
            NSError *error = nil;
            
            if (![managedExercise.managedObjectContext save:&error]) {
                LogDataError(@"Custom Exercise could not be updated. --> updateItem @ CustomExerciseDataManager");
            }
            else {
                LogDataSuccess(@"Custom Exercise has been updated successfully. --> updateItem @ CustomExerciseDataManager");
                //Post notification to tell the rest of the app that a exercise has been updated.
                [[NSNotificationCenter defaultCenter] postNotificationName:CUSTOM_EXERCISE_UPDATE_NOTIFICATION object:nil];
            }
        }
    }
}

//Deletes an existing object in the persistent store.
- (void)deleteItem:(id)object {
    //Create a fetch request.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:[self returnEntityName]];
    
    //Get the passed SHCustomExercise.
    SHCustomExercise *customExercise = (SHCustomExercise *)object;
    
    NSError *requestError = nil;
    
    //Set the fetch request.
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == %@ AND %K == %@", @"exerciseIdentifier", customExercise.exerciseIdentifier,@"exerciseType",customExercise.exerciseType];
    
    [fetchRequest setPredicate:predicate];
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    for (CustomExercise *managedExercise in exercises) {
        
        [customExercise map:managedExercise];
        
        [_appContext deleteObject:managedExercise];
        
        NSError *savingError = nil;
        
        if ([_appContext save:&savingError]) {
            LogDataSuccess(@"Custom Exercise has been deleted successfully. --> deleteItem @ CustomExerciseDataManager");
            //Post notification to tell the rest of the app that a custom exercise has been deleted.
            [[NSNotificationCenter defaultCenter] postNotificationName:CUSTOM_EXERCISE_DELETE_NOTIFICATION object:nil];
        }
        else {
            LogDataError(@"Custom Exercise could not be deleted. --> deleteItem @ CustomExerciseDataManager");
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
    
    for (CustomExercise *managedExercise in exercises) {
        [_appContext deleteObject:managedExercise];
        
        NSError *savingError = nil;
        
        if ([_appContext save:&savingError]) {
            LogDataSuccess(@"Custom Exercise with the identifier \"%@\" has been deleted successfully. --> deleteItemByIdentifier @ CustomExerciseDataManager",objectIdentifier);
            //Post notification to tell the rest of the app that a custom exercise has been deleted.
            [[NSNotificationCenter defaultCenter] postNotificationName:CUSTOM_EXERCISE_DELETE_NOTIFICATION object:nil];
        }
        else {
            LogDataError(@"Custom Exercise with the identifier \"%@\" could not be deleted. --> deleteItemByIdentifier @ CustomExerciseDataManager",objectIdentifier);
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
    
    for (CustomExercise *managedExercise in exercises) {
        [_appContext deleteObject:managedExercise];
        
        NSError *savingError = nil;
        
        if ([_appContext save:&savingError]) {
            LogDataSuccess(@"Custom Exercise with the identifier \"%@\" has been deleted successfully. --> deleteItemByIdentifier @ CustomExerciseDataManager",objectIdentifier);
            //Post notification to tell the rest of the app that a custom exercise has been deleted.
            [[NSNotificationCenter defaultCenter] postNotificationName:CUSTOM_EXERCISE_DELETE_NOTIFICATION object:nil];
        }
        else {
            LogDataError(@"CustomExercise with the identifier \"%@\" could not be deleted. --> deleteItemByIdentifier @ CustomExerciseDataManager",objectIdentifier);
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
        for (CustomExercise *managedExercise in itemsToDelete) {
            
            [_appContext deleteObject:managedExercise];
            NSError *savingError = nil;
            
            if ([_appContext save:&savingError]) {
                LogDataSuccess(@"Successfully deleted all core data custom exercise records. --> deleteAllItems @ CustomExerciseDataManager");
                //Post notification to tell the rest of the app that a custom exercise has been deleted.
                [[NSNotificationCenter defaultCenter] postNotificationName:CUSTOM_EXERCISE_DELETE_NOTIFICATION object:nil];
            }
            else {
                LogDataError(@"Could not delete all core data custom exercise records. --> deleteAllItems @ CustomExerciseDataManager");
            }
        }
    }
    else {
        LogDataError(@"Could not find any custom exercise records in core data. --> deleteAllItems @ CustomExerciseDataManager.");
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
            LogDataSuccess(@"Successfully found a custom exercise with the identifier: %@ --> fetchItemByIdentifier @ CustomExerciseDataManager", objectIdentifier);
            return [exercises objectAtIndex:0];
        }
        else {
            LogDataError(@"Could not fetch any custom exercise with the identifier: %@ --> fetchItemByIdentifier @ CustomExerciseDataManager", objectIdentifier);
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
        LogDataSuccess(@"Successfully fetched all of the custom exercise records. --> fetchAllItems @ CustomExerciseDataManager");
    }
    else {
        LogDataError(@"Could not fetch any custom exercise records. --> fetchAllItems @ CustomExerciseDataManager");
    }
    return exercises;
}

//------------------
#define Useful Tools
//------------------

//Returns the entity name for the data manager.
- (NSString *)returnEntityName {
    //Return the defined entity name.
    return CUSTOM_EXERCISE_ENTITY_NAME;
}

/***************************************************/
#pragma mark - Exercise Data Manager Specfic Methods
/***************************************************/

//-------------------------
#define Fetching Operations
//-------------------------

//Fetches the recently viewed custom exercise records from persistent store.
- (id)fetchRecentlyViewedExercises {
    
    //Get the fetch request.
    NSFetchRequest *fetchRequest = [self getRecentlyViewedFetchRequest];
    
    NSError *requestError = nil;
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (exercises.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the recently viewed custom exercise records. --> fetchRecentlyViewedExercises @ CustomExerciseDataManager");
    }
    else {
        LogDataError(@"Could not fetch any recently viewed custom exercise records. --> fetchRecentlyViewedExercises @ CustomExerciseDataManager");
    }
    
    return exercises;

}

//Fetches all of the liked custom exercises records.
- (id)fetchAllLikedExercises {
    
    NSFetchRequest *fetchRequest = [self getLikedFetchRequest:nil];
    
    NSError *requestError = nil;
    
    NSArray *customExercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    return customExercises;
    
}

//Fetches all of the liked strength custom exercise records.
- (id)fetchLikedStrengthExercises {
    NSFetchRequest *fetchRequest = [self getLikedFetchRequest:@"strength"];
    
    NSError *requestError = nil;
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (exercises.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the liked strength custom exercise records. --> fetchLikedStrengthExercises @ CustomExerciseDataManager");
    }
    else {
        LogDataError(@"Could not fetch any liked strength custom exercise records. --> fetchLikedStrengthExercises @ CustomExerciseDataManager");
    }
    
    return exercises;
}

//Fetches all of the liked stretching custom exercise records.
- (id)fetchLikedStretchingExercises {
    NSFetchRequest *fetchRequest = [self getLikedFetchRequest:@"stretching"];
    
    NSError *requestError = nil;
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (exercises.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the liked stretching custom exercise records. --> fetchLikedStretchingExercises @ CustomExerciseDataManager");
    }
    else {
        LogDataError(@"Could not fetch any liked stretching custom exercise records. --> fetchLikedStrengthExercises @ CustomStretchingDataManager");
    }
    
    return exercises;
}

//Fetches all of the liked warmup custom exercise records.
- (id)fetchLikedWarmupExercises {
    NSFetchRequest *fetchRequest = [self getLikedFetchRequest:@"warmup"];
    
    NSError *requestError = nil;
    
    NSArray *exercises = [_appContext executeFetchRequest:fetchRequest error:&requestError];
    
    if (exercises.count > 0) {
        LogDataSuccess(@"Successfully fetched all of the liked warmup custom exercise records. --> fetchLikedWarmupExercises @ CustomExerciseDataManager");
    }
    else {
        LogDataError(@"Could not fetch any liked warmup custom exercise records. --> fetchLikedWarmupExercises @ CustomExerciseDataManager");
    }
    
    return exercises;
}

//Fetches a cusotm exercise record given the objects identifier and the exercise type.
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
            LogDataSuccess(@"Successfully found a custom exercise with the identifier: %@  and the exercise type: %@ --> fetchItemByIdentifier @ CustomExerciseDataManager", objectIdentifier, exerciseType);
            return [exercises objectAtIndex:0];
        }
        else {
            LogDataError(@"Could not fetch any custom exercise with the identifier: %@  and the exercise type: %@ --> fetchItemByIdentifier @ CustomExerciseDataManager", objectIdentifier, exerciseType);
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
