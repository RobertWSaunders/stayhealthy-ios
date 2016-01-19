//
//  SHDataHandler.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-15.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExerciseDataManager.h"
#import "WorkoutDataManager.h"
#import "CustomWorkoutDataManager.h"
#import "SHDataUtilities.h"

@interface SHDataHandler : NSObject {
    //Create a sqlite database reference for StayHealthy database operations.
    sqlite3 *database;
    //Create reference to the exercise data manager.
    ExerciseDataManager *exerciseDataManager;
    //Create reference to the workout data manager.
    WorkoutDataManager *workoutDataManager;
    //Create reference to the custom workout data manager.
    CustomWorkoutDataManager *customWorkoutDataManager;
}

//Get instance of the singleton.
+ (id)getInstance;

/******************************************/
#pragma mark - StayHealthy Database Methods
/******************************************/

//Performs a passed query in the StayHealthy database, does not return anything.
- (void)performQuery:(NSString*)query;

//Performs a passed exercise query and returns SHExercises.
- (NSMutableArray *)performExerciseStatement:(NSString*)query addUserData:(BOOL)userData;

//Performs a passed workout query and returns SHWorkouts.
- (NSMutableArray *)performWorkoutStatement:(NSString*)query addUserData:(BOOL)userData;

/********************************************/
#pragma mark -  Exercise Data Manager Methods
/********************************************/

//------------------------
#define General Operations
//------------------------

//Saves a exercise record in the persistent store.
- (void)saveExerciseRecord:(SHExercise *)exercise;

//Updates a exercise record in the persistent store.
- (void)updateExerciseRecord:(SHExercise *)exercise;

//Deletes a exercise record in the persistent store.
- (void)deleteExerciseRecord:(SHExercise *)exercise;

//Deletes a exercise record given the identifier in the persistent store.
- (void)deleteExerciseRecordByIdentifier:(NSString *)exerciseIdentifier;

//Deletes a exercise record given the identifier and exercise type in the persistent store.
- (void)deleteExerciseRecordByIdentifierAndExerciseType:(NSString *)exerciseIdentifier exerciseType:(NSString*)exerciseType;

//Deletes all of the exercise records in the persistent store.
- (void)deleteAllExerciseRecords;

//-------------------------
#define Fetching Operations
//-------------------------

//Fetches the managed exercise record from the persistent store given the exercise identifier and exercise type rather then returning a SHExercise.
- (Exercise*)fetchManagedExerciseRecordByIdentifierAndExerciseType:(NSString *)exerciseIdentifier exerciseType:(NSString*)exerciseType;

//Fetches a exercise record given the identifier and exercise type in the persistent store and returns a SHExercise.
- (SHExercise*)fetchExerciseByIdentifierAndExerciseType:(NSString *)exerciseIdentifier exerciseType:(NSString*)exerciseType;

//Fetches the managed exercise record from the persistent store rather then returning a SHExercise.
- (Exercise*)fetchManagedExerciseRecordByIdentifier:(NSString *)exerciseIdentifier;

//Fetches a exercise record given the identifier in the persistent store and returns a SHExercise.
- (SHExercise*)fetchExerciseByIdentifier:(NSString *)exerciseIdentifier;

//Fetches all of the recently viewed exercise records in the persistent store and returns a mutable array of SHExercises.
- (NSMutableArray *)fetchRecentlyViewedExercises;

//Fetches all of the liked exercise records in the persistent store and returns a mutable array of SHExercises.
- (NSMutableArray *)fetchAllLikedExercises;

//Fetches all of the liked strength exercise records in the persistent store and returns a mutable array of SHExercises.
- (NSMutableArray *)fetchStrengthLikedExercises;

//Fetches all of the liked stretching exercise records in the persistent store and returns a mutable array of SHExercises.
- (NSMutableArray *)fetchStretchLikedExercises;

//Fetches all of the liked warmup exercise records in the persistent store and returns a mutable array of SHExercises.
- (NSMutableArray *)fetchWarmupLikedExercises;

//Fetches all of the exercise records in the persistent store.
- (NSMutableArray *)fetchAllExerciseRecords;

/********************************************/
#pragma mark -  Workout Data Manager Methods
/********************************************/

//------------------------
#define General Operations
//------------------------

//Saves a workout record in the persistent store.
- (void)saveWorkoutRecord:(SHWorkout *)workout;

//Updates a workout record in the persistent store.
- (void)updateWorkoutRecord:(SHWorkout *)workout;

//Deletes a workout record in the persistent store.
- (void)deleteWorkoutRecord:(SHWorkout *)workout;

//Deletes a workout record given the identifier in the persistent store.
- (void)deleteWorkoutRecordByIdentifier:(NSString *)workoutIdentifier;

//Deletes all of the workout records in the persistent store.
- (void)deleteAllWorkoutRecords;

//-------------------------
#define Fetching Operations
//-------------------------

//Fetches a workout record given the identifier in the persistent store and returns a SHWorkout.
- (Workout*)fetchManagedWorkoutRecordByIdentifier:(NSString *)workoutIdentifier;

//Fetches a workout record given the identifier in the persistent store and returns a SHWorkouts.
- (SHWorkout*)fetchWorkoutByIdentifier:(NSString *)workoutIdentifier;

//Fetches all of the recently viewed workout records in the persistent store and returns a mutable array of SHWorkouts.
- (NSMutableArray *)fetchRecentlyViewedWorkouts;

//Fetches all of the liked workout records in the persistent store and returns a mutable array of SHWorkouts.
- (NSMutableArray *)fetchAllLikedWorkouts;

//Fetches all of the workout records in the persistent store.
- (NSMutableArray *)fetchAllWorkoutRecords;

/**************************************************/
#pragma mark -  Custom Workout Data Manager Methods
/**************************************************/

//------------------------
#define General Operations
//------------------------

//Saves a custom workout record in the persistent store.
- (void)saveCustomWorkoutRecord:(SHCustomWorkout *)customWorkout;

//Updates a custom workout record in the persistent store.
- (void)updateCustomWorkoutRecord:(SHCustomWorkout *)customWorkout;

//Deletes a custom workout record in the persistent store.
- (void)deleteCustomWorkoutRecord:(SHCustomWorkout *)customWorkout;

//Deletes a custom workout record given the identifier in the persistent store.
- (void)deleteCustomWorkoutRecordByIdentifier:(NSString *)customWorkoutIdentifier;

//Deletes all of the custom workout records in the persistent store.
- (void)deleteAllCustomWorkoutRecords;

//-------------------------
#define Fetching Operations
//-------------------------

- (CustomWorkout*)fetchManagedCustomWorkoutRecordByIdentifier:(NSString *)customWorkoutIdentifier;

//Fetches a custom workout record given the identifier in the persistent store and returns a SHCustomWorkout.
- (SHCustomWorkout*)fetchCustomWorkoutByIdentifier:(NSString *)customWorkoutIdentifier;

//Fetches all of the liked custom workout records in the persistent store and returns a mutable array of SHCustomWorkouts.
- (NSMutableArray *)fetchAllLikedCustomWorkouts;

//Fetches all of the custom workout records in the persistent store.
- (NSMutableArray *)fetchAllCustomWorkoutRecords;

//---------------------
#define Misc Operations
//---------------------

//Adds a SHExercise to a SHCustomWorkout
- (void)addSHExerciseToCustomWorkout:(SHCustomWorkout *)customWorkout exercise:(SHExercise *)exercise;

/*******************************************/
#pragma mark -  Auto Database Update Methods
/*******************************************/

//Checks to see if the user wants auto database updates then compares current installed database to online database and installs if nescessary.
- (void)performDatabaseUpdate;

//Checks if there is a update that can be made to the database.
- (BOOL)isDatabaseUpdate;

//Returns the database version that is store on the web.
- (NSString *)onlineDatabaseVersion;

@end
