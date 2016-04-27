//
//  SHDataHandler.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-15.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "SHDataHandler.h"

@implementation SHDataHandler

//Initialize the data handler.
- (id)init {
    if (self = [super init]) {
        exerciseDataManager = [[ExerciseDataManager alloc] init];
        workoutDataManager = [[WorkoutDataManager alloc] init];
        customWorkoutDataManager = [[CustomWorkoutDataManager alloc] init];
    }
    return self;
}

/*********************************/
#pragma mark - Singleton Instance
/*********************************/

//Get instance of the singleton. Only allow for one instance of the data handler at a time.
+ (id)getInstance {
    static SHDataHandler *_instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

/******************************************/
#pragma mark - StayHealthy Database Methods
/******************************************/

//Performs a passed query in the StayHealthy database, does not return anything.
- (void)performQuery:(NSString*)query {
    @try {
        if(!(sqlite3_open([[CommonUtilities returnDatabasePath:STAYHEALTHY_DATABASE_NAME] UTF8String], &database) == SQLITE_OK))
            NSLog(@"An error has occured: %s", sqlite3_errmsg(database));
        const char *sql = [query cStringUsingEncoding:NSASCIIStringEncoding];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(database, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
            NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(database));
        if (sqlite3_step(sqlStatement) == SQLITE_DONE)
            NSLog(@"Statement Complete.");
        else
            NSLog(@"Failed to perform statement.");
        sqlite3_finalize(sqlStatement);
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(database));
    }
    @finally {
        sqlite3_close(database);
    }
}

//Performs a passed exercise query and returns SHExercises.
- (NSMutableArray*)performExerciseStatement:(NSString*)query addUserData:(BOOL)userData {
    NSMutableArray *exerciseData = [[NSMutableArray alloc] init];
    @try {
        if(!(sqlite3_open([[CommonUtilities returnDatabasePath:STAYHEALTHY_DATABASE_NAME] UTF8String], &database) == SQLITE_OK))
            LogDataError(@"An error has occured while fetching SHExercises from StayHealthy database: %s", sqlite3_errmsg(database));
        const char *sql = [query cStringUsingEncoding:NSASCIIStringEncoding];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(database, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
            LogDataError(@"Could not load SHExercises from StayHealthy database, problem with prepare statement:  %s", sqlite3_errmsg(database));
        else{
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                SHExercise * exercise = [[SHExercise alloc] init];
                exercise.exerciseIdentifier = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)];
                exercise.exerciseName = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
                exercise.exerciseShortName = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,2)];
                exercise.exerciseInstructions = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
                exercise.exerciseImageFile= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 4)];
                exercise.exerciseSets= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 5)];
                exercise.exerciseReps= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 6)];
                exercise.exerciseEquipment= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 7)];
                exercise.exercisePrimaryMuscle= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 8)];
                exercise.exerciseSecondaryMuscle= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 9)];
                exercise.exerciseDifficulty= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 10)];
                exercise.exerciseType= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 11)];
                 exercise.exerciseMechanicsType = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 12)];
                 exercise.exerciseForceType = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 13)];
                 exercise.exerciseDifferentVariationsExerciseIdentifiers = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 14)];
                [exerciseData addObject:exercise];
            }
        }
        sqlite3_finalize(sqlStatement);
    }
    @catch (NSException *exception) {
        LogDataError(@"Could not load SHExercises from StayHealthy database, problem with prepare statement:  %s", sqlite3_errmsg(database));
    }
    @finally {
        sqlite3_close(database);
        //If the methods calls for returning user data as well then we do it here.
        if (userData) {
            //Now based off of the fetched exercises create new array with same exercises but with the user data included.
            NSMutableArray *userExerciseData = [[NSMutableArray alloc] init];
            for (SHExercise *exercise in exerciseData) {
                if ([SHDataUtilities exerciseHasBeenSaved:exercise.exerciseIdentifier exerciseType:exercise.exerciseType]) {
                     SHExercise *userExercise = [SHDataUtilities addUserDataToSHExercise:exercise managedExercise:[self fetchManagedExerciseRecordByIdentifierAndExerciseType:exercise.exerciseIdentifier exerciseType:exercise.exerciseType]];
                    [userExerciseData addObject:userExercise];
                }
                else {
                    [userExerciseData addObject:exercise];
                }
            }
            //Return the user exercise data.
            return userExerciseData;
        }
        else {
            return exerciseData;
        }
        
    }
}

//Performs a passed workout query and returns SHWorkouts.
- (NSMutableArray*)performWorkoutStatement:(NSString*)query addUserData:(BOOL)userData {
    NSMutableArray *workoutData = [[NSMutableArray alloc] init];
    @try {
        if(!(sqlite3_open([[CommonUtilities returnDatabasePath:STAYHEALTHY_DATABASE_NAME] UTF8String], &database) == SQLITE_OK))
            NSLog(@"An error has occured: %s", sqlite3_errmsg(database));
        const char *sql = [query cStringUsingEncoding:NSASCIIStringEncoding];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(database, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
            NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(database));
        else{
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                SHWorkout *workout = [[SHWorkout alloc] init];
                workout.workoutIdentifier = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)];
                workout.workoutName = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
                workout.workoutSummary = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,2)];
                workout.workoutTargetMuscles = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
                workout.workoutTargetSports = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 4)];
                workout.workoutExerciseIdentifiers = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 5)];
                workout.workoutExerciseTypes = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 6)];
                workout.workoutType = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 7)];
                workout.workoutDifficulty= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 8)];
                workout.workoutEquipment= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 9)];
                [workoutData  addObject:workout];
            }
        }
        sqlite3_finalize(sqlStatement);
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(database));
    }
    @finally {
        sqlite3_close(database);
        if (userData) {
            //Now based off of the fetched workout create new array with same workouts but with the user data included.
            NSMutableArray *userWorkoutData = [[NSMutableArray alloc] init];
            for (SHWorkout *workout in workoutData) {
                if ([SHDataUtilities workoutHasBeenSaved:workout.workoutIdentifier]) {
                    SHWorkout *userWorkout = [SHDataUtilities addUserDataToSHWorkout:workout managedWorkout:[self fetchManagedWorkoutRecordByIdentifier:workout.workoutIdentifier]];
                    [userWorkoutData addObject:userWorkout];
                }
                else {
                    [userWorkoutData addObject:workout];
                }
            }
            //Return the user workout data.
            return userWorkoutData;
        }
        else {
            return workoutData;
        }
    }
}

/********************************************/
#pragma mark -  Exercise Data Manager Methods
/********************************************/

//------------------------
#define General Operations
//------------------------

//Saves a exercise record in the persistent store.
- (void)saveExerciseRecord:(SHExercise *)exercise {
    //Call the data manager method.
    [exerciseDataManager saveItem:exercise];
}

//Updates a exercise record in the persistent store.
- (void)updateExerciseRecord:(SHExercise *)exercise {
    //Call the data manager method.
    [exerciseDataManager updateItem:exercise];
}

//Deletes a exercise record in the persistent store.
- (void)deleteExerciseRecord:(SHExercise *)exercise {
    //Call the data manager method.
    [exerciseDataManager deleteItem:exercise];
}

//Deletes a exercise record given the identifier in the persistent store.
- (void)deleteExerciseRecordByIdentifier:(NSString *)exerciseIdentifier {
    //Call the data manager method.
    [exerciseDataManager deleteItemByIdentifier:exerciseIdentifier];
}

//Deletes a exercise record given the identifier and exercise type in the persistent store.
- (void)deleteExerciseRecordByIdentifierAndExerciseType:(NSString *)exerciseIdentifier exerciseType:(NSString*)exerciseType {
    //Call the data manager method.
    [exerciseDataManager deleteItemByIdentifierAndExerciseType:exerciseIdentifier exerciseType:exerciseType];
}

//Deletes all of the exercise records in the persistent store.
- (void)deleteAllExerciseRecords {
    //Call the data manager method.
    [exerciseDataManager deleteAllItems];
}

//-------------------------
#define Fetching Operations
//-------------------------

//Fetches the managed exercise record from the persistent store rather then returning a SHExercise.
- (Exercise*)fetchManagedExerciseRecordByIdentifier:(NSString *)exerciseIdentifier {
        return [exerciseDataManager fetchItemByIdentifier:exerciseIdentifier];;
}

//Fetches the managed exercise record from the persistent store given the exercise identifier and exercise type rather then returning a SHExercise.
- (Exercise*)fetchManagedExerciseRecordByIdentifierAndExerciseType:(NSString *)exerciseIdentifier exerciseType:(NSString*)exerciseType {
    return [exerciseDataManager fetchItemByIdentifierAndExerciseType:exerciseIdentifier exerciseType:exerciseType];
}

//Fetches a exercise record given the identifier and exercise type in the persistent store and returns a SHExercise.
- (SHExercise*)fetchExerciseByIdentifierAndExerciseType:(NSString *)exerciseIdentifier exerciseType:(NSString*)exerciseType {
    //Fetch the managed exercises from the persistent store.
    NSArray *fetchedManagedExercises = [exerciseDataManager fetchItemByIdentifierAndExerciseType:exerciseIdentifier exerciseType:exerciseType];
    
    //Create reference to a new SHExercise.
    SHExercise *exercise;
    
    //If there are exercises found.
    if (fetchedManagedExercises.count > 0 || fetchedManagedExercises != nil) {
        //Convert the managed exercise to a SHExercise.
        exercise = [SHDataUtilities convertExerciseToSHExercise:[fetchedManagedExercises firstObject]];
    }
    //Return the exercise.
    return exercise;
}

//Fetches a exercise record given the identifier in the persistent store and returns a SHExercise.
- (SHExercise*)fetchExerciseByIdentifier:(NSString *)exerciseIdentifier {
    //Fetch the managed exercises from the persistent store.
    NSArray *fetchedManagedExercises = [exerciseDataManager fetchItemByIdentifier:exerciseIdentifier];
    
    //Create reference to a new SHExercise.
    SHExercise *exercise;
    
    //If there are exercises found.
    if (fetchedManagedExercises.count > 0 || fetchedManagedExercises != nil) {
        //Convert the managed exercise to a SHExercise.
        exercise = [SHDataUtilities convertExerciseToSHExercise:[fetchedManagedExercises firstObject]];
    }
    //Return the exercise.
    return exercise;
}

//Fetches all of the recently viewed exercise records in the persistent store and returns a mutable array of SHExercises.
- (NSMutableArray *)fetchRecentlyViewedExercises {
    //Fetch the managed exercises from the persistent store.
    NSArray *fetchedManagedExercises = [exerciseDataManager fetchRecentlyViewedExercises];
    
    //Create reference to a new SHExercise.
    SHExercise *exercise;
    
    NSMutableArray *recentlyViewedSHExercises = [[NSMutableArray alloc] init];
    
    for (Exercise *managedExercise in fetchedManagedExercises) {
        exercise = [SHDataUtilities convertExerciseToSHExercise:managedExercise];
        [recentlyViewedSHExercises addObject:exercise];
    }
        
    return recentlyViewedSHExercises;
}

//Fetches all of the liked exercise records in the persistent store and returns a mutable array of SHExercises.
- (NSMutableArray *)fetchAllLikedExercises {
    //Fetch the managed exercises from the persistent store.
    NSArray *fetchedManagedExercises = [exerciseDataManager fetchAllLikedExercises];
    
    //Create reference to a new SHExercise.
    SHExercise *exercise;
    
    NSMutableArray *likedSHExercises = [[NSMutableArray alloc] init];
    
    for (Exercise *managedExercise in fetchedManagedExercises) {
        exercise = [SHDataUtilities convertExerciseToSHExercise:managedExercise];
        [likedSHExercises addObject:exercise];
    }
    return likedSHExercises;
}

//Fetches all of the liked strength exercise records in the persistent store and returns a mutable array of SHExercises.
- (NSMutableArray *)fetchStrengthLikedExercises {
    //Fetch the managed exercises from the persistent store.
    NSArray *fetchedManagedExercises = [exerciseDataManager fetchLikedStrengthExercises];
    
    //Create reference to a new SHExercise.
    SHExercise *exercise;
    
    NSMutableArray *likedStrengthSHExercises = [[NSMutableArray alloc] init];
    
    for (Exercise *managedExercise in fetchedManagedExercises) {
        exercise = [SHDataUtilities convertExerciseToSHExercise:managedExercise];
        [likedStrengthSHExercises addObject:exercise];
    }
    return likedStrengthSHExercises;
}

//Fetches all of the liked stretching exercise records in the persistent store and returns a mutable array of SHExercises.
- (NSMutableArray *)fetchStretchLikedExercises {
    //Fetch the managed exercises from the persistent store.
    NSArray *fetchedManagedExercises = [exerciseDataManager fetchLikedStretchingExercises];
    
    //Create reference to a new SHExercise.
    SHExercise *exercise;
    
    NSMutableArray *likedStretchingSHExercises = [[NSMutableArray alloc] init];
    
    for (Exercise *managedExercise in fetchedManagedExercises) {
        exercise = [SHDataUtilities convertExerciseToSHExercise:managedExercise];
        [likedStretchingSHExercises addObject:exercise];
    }
    return likedStretchingSHExercises;
}

//Fetches all of the liked warmup exercise records in the persistent store and returns a mutable array of SHExercises.
- (NSMutableArray *)fetchWarmupLikedExercises {
    //Fetch the managed exercises from the persistent store.
    NSArray *fetchedManagedExercises = [exerciseDataManager fetchLikedWarmupExercises];
    
    //Create reference to a new SHExercise.
    SHExercise *exercise;
    
    NSMutableArray *likedWarmupSHExercises = [[NSMutableArray alloc] init];
    
    for (Exercise *managedExercise in fetchedManagedExercises) {
        exercise = [SHDataUtilities convertExerciseToSHExercise:managedExercise];
        [likedWarmupSHExercises addObject:exercise];
    }
    return likedWarmupSHExercises;
}

//Fetches all of the exercise records in the persistent store.
- (NSMutableArray *)fetchAllExerciseRecords {
    //Fetch the managed exercises from the persistent store.
    NSArray *fetchedManagedExercises = [exerciseDataManager fetchAllItems];
    
    //Create reference to a new SHExercise.
    SHExercise *exercise;
    
    NSMutableArray *allSHExercises = [[NSMutableArray alloc] init];
    
    for (Exercise *managedExercise in fetchedManagedExercises) {
        exercise = [SHDataUtilities convertExerciseToSHExercise:managedExercise];
        [allSHExercises addObject:exercise];
    }
    return allSHExercises;
}

/********************************************/
#pragma mark -  Workout Data Manager Methods
/********************************************/

//------------------------
#define General Operations
//------------------------

//Saves a workout record in the persistent store.
- (void)saveWorkoutRecord:(SHWorkout *)workout {
    //Call the data manager method.
    [workoutDataManager saveItem:workout];
}

//Updates a workout record in the persistent store.
- (void)updateWorkoutRecord:(SHWorkout *)workout {
    //Call the data manager method.
    [workoutDataManager updateItem:workout];
}

//Deletes a workout record in the persistent store.
- (void)deleteWorkoutRecord:(SHWorkout *)workout {
    //Call the data manager method.
    [workoutDataManager deleteItem:workout];
}

//Deletes a workout record given the identifier in the persistent store.
- (void)deleteWorkoutRecordByIdentifier:(NSString *)workoutIdentifier {
    //Call the data manager method.
    [workoutDataManager deleteItemByIdentifier:workoutIdentifier];
}

//Deletes all of the workout records in the persistent store.
- (void)deleteAllWorkoutRecords {
    //Call the data manager method.
    [workoutDataManager deleteAllItems];
}

//-------------------------
#define Fetching Operations
//-------------------------

//Fetches the managed workout record from the persistent store rather then returning a SHWorkout.
- (Workout*)fetchManagedWorkoutRecordByIdentifier:(NSString *)workoutIdentifier {
    //Fetch the managed workout from the persistent store.
    NSArray *fetchedManagedWorkouts = [workoutDataManager fetchItemByIdentifier:workoutIdentifier];
    
    if (fetchedManagedWorkouts.count > 0) {
        Workout *workout = [fetchedManagedWorkouts objectAtIndex:0];
        return workout;
    }
    else {
        return nil;
    }
}

//Fetches a workout record given the identifier in the persistent store and returns a SHWorkouts.
- (SHWorkout*)fetchWorkoutByIdentifier:(NSString *)workoutIdentifier {
    //Fetch the managed workouts from the persistent store.
    NSArray *fetchedManagedWorkouts = [workoutDataManager fetchItemByIdentifier:workoutIdentifier];
    
    //Create reference to a new SHWorkout.
    SHWorkout *workout;
    
    //If there are workouts found.
    if (fetchedManagedWorkouts.count > 0 || fetchedManagedWorkouts != nil) {
        //Convert the managed workout to a SHWorkout.
        workout = [SHDataUtilities convertWorkoutToSHWorkout:[fetchedManagedWorkouts firstObject]];
    }
    //Return the workout.
    return workout;
}

//Fetches all of the recently viewed workout records in the persistent store and returns a mutable array of SHWorkouts.
- (NSMutableArray *)fetchRecentlyViewedWorkouts {
    //Fetch the managed workouts from the persistent store.
    NSArray *fetchedManagedWorkouts = [workoutDataManager fetchRecentlyViewedWorkouts];
    
    //Create reference to a new SHWorkout.
    SHWorkout *workout;
    
    NSMutableArray *recentlyViewedSHWorkouts = [[NSMutableArray alloc] init];
    
    for (Workout *managedWorkout in fetchedManagedWorkouts) {
        workout = [SHDataUtilities convertWorkoutToSHWorkout:managedWorkout];
        [recentlyViewedSHWorkouts addObject:workout];
    }
    
    return recentlyViewedSHWorkouts;
}

//Fetches all of the liked workout records in the persistent store and returns a mutable array of SHWorkouts.
- (NSMutableArray *)fetchAllLikedWorkouts {
    //Fetch the managed workouts from the persistent store.
    NSArray *fetchedManagedWorkouts = [workoutDataManager fetchAllLikedWorkouts];
    
    //Create reference to a new SHWorkout.
    SHWorkout *workout;
    
    NSMutableArray *likedSHWorkouts = [[NSMutableArray alloc] init];
    
    for (Workout *managedWorkout in fetchedManagedWorkouts) {
        workout = [SHDataUtilities convertWorkoutToSHWorkout:managedWorkout];
        [likedSHWorkouts addObject:workout];
    }
    return likedSHWorkouts;
}

//Fetches all of the workout records in the persistent store.
- (NSMutableArray *)fetchAllWorkoutRecords {
    //Fetch the managed workouts from the persistent store.
    NSArray *fetchedManagedWorkouts = [workoutDataManager fetchAllItems];
    
    //Create reference to a new SHWorkout.
    SHWorkout *workout;
    
    NSMutableArray *allSHWorkouts = [[NSMutableArray alloc] init];
    
    for (Workout *managedWorkout in fetchedManagedWorkouts) {
        workout = [SHDataUtilities convertWorkoutToSHWorkout:managedWorkout];
        [allSHWorkouts addObject:workout];
    }
    
    return allSHWorkouts;
}

/**************************************************/
#pragma mark -  Custom Workout Data Manager Methods
/**************************************************/

//------------------------
#define General Operations
//------------------------

//Saves a custom workout record in the persistent store.
- (void)saveCustomWorkoutRecord:(SHCustomWorkout *)customWorkout {
    //Call the data manager method.
    [customWorkoutDataManager saveItem:customWorkout];
}

//Updates a custom workout record in the persistent store.
- (void)updateCustomWorkoutRecord:(SHCustomWorkout *)customWorkout {
    //Call the data manager method.
    [customWorkoutDataManager updateItem:customWorkout];
}

//Deletes a custom workout record in the persistent store.
- (void)deleteCustomWorkoutRecord:(SHCustomWorkout *)customWorkout {
    //Call the data manager method.
    [customWorkoutDataManager deleteItem:customWorkout];
}

//Deletes a custom workout record given the identifier in the persistent store.
- (void)deleteCustomWorkoutRecordByIdentifier:(NSString *)customWorkoutIdentifier {
    //Call the data manager method.
    [customWorkoutDataManager deleteItemByIdentifier:customWorkoutIdentifier];
}

//Deletes all of the custom workout records in the persistent store.
- (void)deleteAllCustomWorkoutRecords {
    //Call the data manager method.
    [customWorkoutDataManager deleteAllItems];
}

//-------------------------
#define Fetching Operations
//-------------------------

//Fetches the managed custom workouts records from the persistent store rather then returning a SHCustomWorkouts.
- (CustomWorkout*)fetchManagedCustomWorkoutRecordByIdentifier:(NSString *)customWorkoutIdentifier {
    //Fetch the managed exercises from the persistent store.
    NSArray *fetchedManagedCustomWorkouts = [customWorkoutDataManager fetchItemByIdentifier:customWorkoutIdentifier];
    
    if (fetchedManagedCustomWorkouts.count > 0) {
        CustomWorkout *customWorkout = [fetchedManagedCustomWorkouts objectAtIndex:0];
        return customWorkout;
    }
    else {
        return nil;
    }
}

//Fetches a custom workout record given the identifier in the persistent store and returns a SHCustomWorkout.
- (SHCustomWorkout*)fetchCustomWorkoutByIdentifier:(NSString *)customWorkoutIdentifier {
    //Fetch the managed custom workouts from the persistent store.
    NSArray *fetchedManagedCustomWorkouts = [customWorkoutDataManager fetchItemByIdentifier:customWorkoutIdentifier];
    
    //Create reference to a new SHCustomWorkout.
    SHCustomWorkout *customWorkout;
    
    //If there are custom workouts found.
    if (fetchedManagedCustomWorkouts.count > 0 || fetchedManagedCustomWorkouts != nil) {
        //Convert the managed custom workout to a SHCustomWorkout.
        customWorkout = [SHDataUtilities convertCustomWorkoutToSHCustomWorkout:[fetchedManagedCustomWorkouts firstObject]];
    }
    //Return the custom workout.
    return customWorkout;
}

//Fetches all of the liked custom workout records in the persistent store and returns a mutable array of SHCustomWorkouts.
- (NSMutableArray *)fetchAllLikedCustomWorkouts {
    //Fetch the managed custom workouts from the persistent store.
    NSArray *fetchedManagedCustomWorkouts = [customWorkoutDataManager fetchAllLikedCustomWorkouts];
    
    //Create reference to a new SHCustomWorkout.
    SHCustomWorkout *customWorkout;
    
    NSMutableArray *likedSHCustomWorkouts = [[NSMutableArray alloc] init];
    
    for (CustomWorkout *managedCustomWorkout in fetchedManagedCustomWorkouts) {
        customWorkout = [SHDataUtilities convertCustomWorkoutToSHCustomWorkout:managedCustomWorkout];
        [likedSHCustomWorkouts addObject:customWorkout];
    }
    return likedSHCustomWorkouts;
}

//Fetches all of the custom workout records in the persistent store.
- (NSMutableArray *)fetchAllCustomWorkoutRecords {
    //Fetches the managed custom workouts from the persistent store.
    NSArray *fetchedManagedCustomWorkouts = [customWorkoutDataManager fetchAllItems];
    
    //Create reference to a new SHCustomWorkout.
    SHCustomWorkout *customWorkout;
    
    NSMutableArray *allSHCustomWorkouts = [[NSMutableArray alloc] init];
    
    for (CustomWorkout *managedCustomWorkout in fetchedManagedCustomWorkouts) {
        customWorkout = [SHDataUtilities convertCustomWorkoutToSHCustomWorkout:managedCustomWorkout];
        [allSHCustomWorkouts addObject:customWorkout];
    }
    
    return allSHCustomWorkouts;
}

//---------------------
#define Misc Operations
//---------------------

//Adds a SHExercise to a SHCustomWorkout
- (void)addSHExerciseToCustomWorkout:(SHCustomWorkout *)customWorkout exercise:(SHExercise *)exercise {
    //if ([self canAddExerciseToWorkout:customWorkout exercise:exercise]) {
    NSMutableArray *workoutExerciseIDs = [[customWorkout.workoutExerciseIDs componentsSeparatedByString:@","] mutableCopy];
    NSMutableArray *workoutExerciseTypes = [[customWorkout.exerciseTypes componentsSeparatedByString:@","]     mutableCopy];
    
    [workoutExerciseIDs addObject:exercise.exerciseIdentifier];
    [workoutExerciseTypes addObject:exercise.exerciseType];
    
    NSString *newExerciseIdentifiers = [workoutExerciseIDs componentsJoinedByString:@","];
    NSString *newExerciseTypes = [workoutExerciseTypes componentsJoinedByString:@","];
    
    customWorkout.workoutExerciseIDs = newExerciseIdentifiers;
    customWorkout.exerciseTypes = newExerciseTypes;
    
    [self updateCustomWorkoutRecord:customWorkout];
    // }
}

/*******************************************/
#pragma mark -  Auto Database Update Methods
/*******************************************/

//Checks to see if the user wants auto database updates then compares current installed database to online database and installs if nescessary.
- (void)performDatabaseUpdate {
    //Check Internet Connection
    if ([CommonUtilities isInternetConnection]) {
        if ([[NSUserDefaults standardUserDefaults] boolForKey:PREFERENCE_AUTO_DATABASE_UPDATES]) {
            //Check if a newer database is actually online to download.
            if ([self isDatabaseUpdate]) {
            
                //Reference the path to the documents directory.
                NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
                //Get the path of the database.
                NSString *filePath = [documentDir stringByAppendingPathComponent:@"StayHealthyDatabase.sqlite"];
            
                //Set the URL request to download from.
                NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:DATABASE_URL]];
            
                //Download file and overwrite the previous database version.
                [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                    if (error) {
                        //Downloading error.
                        LogDataError(@"Error downloading updated StayHealthy database: %@", error.description);
                    }
                    if (data) {
                        //Overwrite current database.
                        [data writeToFile:filePath atomically:YES];
                        //Download success.
                        LogDataSuccess(@"Successfully downloaded and replaced database. Saved to %@", filePath);
                    }
                }];
            }
        }
    }
}

- (void)updateDatabase:(BOOL)shouldUpdate {
    if (shouldUpdate) {
    //Reference the path to the documents directory.
    NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    //Get the path of the database.
    NSString *filePath = [documentDir stringByAppendingPathComponent:@"StayHealthyDatabase.sqlite"];
    
    //Set the URL request to download from.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:DATABASE_URL]];
    
    //Download file and overwrite the previous database version.
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (error) {
            //Downloading error.
            LogDataError(@"Error downloading updated StayHealthy database: %@", error.description);
        }
        if (data) {
            //Overwrite current database.
            [data writeToFile:filePath atomically:YES];
            //Download success.
            LogDataSuccess(@"Successfully downloaded and replaced database. Saved to %@", filePath);
        }
    }];
    }

}

//Checks if there is a update that can be made to the database.
- (BOOL)isDatabaseUpdate {
    //Make sure that the string from the web is not empty.
    if ([self onlineDatabaseVersion] != nil) {
        //Compare to the installed version on the phone to the version online.
        if (![[self onlineDatabaseVersion] isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:USER_INSTALLED_DATABASE_VERSION]]) {
            //If there is a update required, set the new user database version to be the online one.
            [[NSUserDefaults standardUserDefaults] setValue:[self onlineDatabaseVersion] forKey:USER_INSTALLED_DATABASE_VERSION];
            //Save the changes.
            [[NSUserDefaults standardUserDefaults] synchronize];
            return TRUE;
        }
        else {
            return FALSE;
        }
    }
    return FALSE;
}

//Returns the database version that is store on the web.
- (NSString *)onlineDatabaseVersion {
    //Set the NSURL for where the database version is stored.
    NSURL *URL = [NSURL URLWithString:DATABASE_VERSION_URL];
    
    NSError *error;
    
    //Get the string from the text file online.
    NSString *stringFromFileAtURL = [[NSString alloc]
                                     initWithContentsOfURL:URL
                                     encoding:NSUTF8StringEncoding
                                     error:&error];
    
    //If the string is nil then log the error.
    if (stringFromFileAtURL == nil) {
        LogDataError(@"Could not find database version online.");
    }
    
    //Return the string.
    return stringFromFileAtURL;
}

@end
