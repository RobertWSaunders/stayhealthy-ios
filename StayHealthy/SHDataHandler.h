//
//  SHDataHandler.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-15.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExerciseDataManager.h"
#import "CustomExerciseDataManager.h"
#import "ExerciseLogDataManager.h"
#import "ExerciseSetLogDataManager.h"
#import "WorkoutLogDataManager.h"
#import "WorkoutDataManager.h"
#import "CustomWorkoutDataManager.h"
#import "SHDataUtilities.h"

@interface SHDataHandler : NSObject {
    //Create a sqlite database reference for StayHealthy database operations.
    sqlite3 *database;
    
    //Create reference to the exercise data manager.
    ExerciseDataManager *exerciseDataManager;
    //Create reference to the custom exercise data manager.
    CustomExerciseDataManager *customExerciseDataManager;
    //Create reference to the exercise log data manager.
    ExerciseLogDataManager *exerciseLogDataManager;
    //Create reference to the exercise set log data manager.
    ExerciseSetLogDataManager *exerciseSetLogDataManager;
    //Create reference to the workout log data manager.
    WorkoutLogDataManager *workoutLogDataManager;
     //Create reference to the workout data manager.
    WorkoutDataManager *workoutDataManager;
    //Create reference to the custom workout data manager.
    CustomWorkoutDataManager *customWorkoutDataManager;
    
}

//Get instance of the singleton.
+ (id)getInstance;

/******************************/
#pragma mark - General Methods
//Used as methods that should be able to satisfy all needs of class.
/******************************/

//Deletes all of the users data.
- (void)deleteAllData;
 
/****************************************/
#pragma mark - Journal General Methods
/****************************************/

//------------------
#pragma mark Logging
//------------------

//Saves an exercise log given the exercise set logs, will also create the workout log.
- (void)saveExerciseLog:(NSMutableArray*)exerciseSetLogs exerciseLog:(SHExerciseLog*)exerciseLog;

//Saves or updates a workout log based on exercise log given to it.
- (void)workoutLogHandler:(SHExerciseLog*)exerciseLog;

/*--------------------------------------*/
#pragma mark - Exercises General Methods
/*--------------------------------------*/

//Returns a complete array of sorted exercises, including BOTH custom and standard exercises.
- (NSMutableArray *)fetchExercises:(exerciseType)exerciseType muscles:(NSArray *)muscles;

//Returns array filled with all custom exercises sorted.
- (NSMutableArray *)fetchCustomExercises;

//Returns array filled with the recently viewed exercises, array count repects user preference.
- (NSMutableArray *)fetchRecentlyViewedExercises;

//Returns array filled with the liked exercises for the passed exercise type.
- (NSMutableArray *)fetchLikedExercises:(exerciseType)exerciseType;

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
#pragma mark General Operations
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
#pragma mark Fetching Operations
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
- (NSMutableArray *)fetchRecentlyViewedExerciseRecords;

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

/***************************************************/
#pragma mark -  Custom Exercise Data Manager Methods
/***************************************************/

//------------------------
#pragma mark General Operations
//------------------------

//Saves a custom exercise record in the persistent store.
- (void)saveCustomExerciseRecord:(SHCustomExercise *)customExercise;

//Updates a custom exercise record in the persistent store.
- (void)updateCustomExerciseRecord:(SHCustomExercise *)customExercise;

//Deletes a custom exercise record in the persistent store.
- (void)deleteCustomExerciseRecord:(SHCustomExercise *)customExercise;

//Deletes a custom exercise record given the identifier in the persistent store.
- (void)deleteCustomExerciseRecordByIdentifier:(NSString *)customExerciseIdentifier;

//Deletes a custom exercise record given the identifier and exercise type in the persistent store.
- (void)deleteCustomExerciseRecordByIdentifierAndExerciseType:(NSString *)exerciseIdentifier exerciseType:(NSString*)exerciseType;

//Deletes all of the custom exercise records in the persistent store.
- (void)deleteAllCustomExerciseRecords;

//-------------------------
#pragma mark Fetching Operations
//-------------------------

//Fetches the managed custom exercise record from the persistent store given the exercise identifier and exercise type rather then returning a SHCustomExercise.
- (CustomExercise*)fetchManagedCustomExerciseRecordByIdentifierAndExerciseType:(NSString *)exerciseIdentifier exerciseType:(NSString*)exerciseType;

//Fetches a custom exercise record given the identifier and exercise type in the persistent store and returns a SHCustomExercise.
- (SHCustomExercise*)fetchCustomExerciseByIdentifierAndExerciseType:(NSString *)exerciseIdentifier exerciseType:(NSString*)exerciseType;

//Fetches the managed custom exercise record from the persistent store rather then returning a SHCustomExercise.
- (CustomExercise*)fetchManagedCustomExerciseRecordByIdentifier:(NSString *)exerciseIdentifier;

//Fetches a custom exercise record given the identifier in the persistent store and returns a SHCustomExercise.
- (SHCustomExercise*)fetchCustomExerciseByIdentifier:(NSString *)exerciseIdentifier;

//Fetches all of the recently viewed custom exercise records in the persistent store and returns a mutable array of SHCustomExercises.
- (NSMutableArray *)fetchRecentlyViewedCustomExerciseRecords;

//Fetches all of the liked custom exercise records in the persistent store and returns a mutable array of SHCustomExercises.
- (NSMutableArray *)fetchAllLikedCustomExercises;

//Fetches all of the liked strength custom exercise records in the persistent store and returns a mutable array of SHCustomExercises.
- (NSMutableArray *)fetchStrengthLikedCustomExercises;

//Fetches all of the liked stretching custom exercise records in the persistent store and returns a mutable array of SHCustomExercises.
- (NSMutableArray *)fetchStretchLikedCustomExercises;

//Fetches all of the liked warmup custom exercise records in the persistent store and returns a mutable array of SHCustomExercises.
- (NSMutableArray *)fetchWarmupLikedCustomExercises;

//Fetches all of the custom exercise records in the persistent store.
- (NSMutableArray *)fetchAllCustomExerciseRecords;

/************************************************/
#pragma mark - Exercise Log Data Manager Methods
/************************************************/

//------------------------
#pragma mark General Operations
//------------------------

//Saves a exercise log record in the persistent store.
- (void)saveExerciseLogRecord:(SHExerciseLog *)exerciseLog;

//Updates a exercise log record in the persistent store.
- (void)updateExerciseLogRecord:(SHExerciseLog *)exerciseLog;

//Deletes a exercise log record in the persistent store.
- (void)deleteExerciseLogRecord:(SHExerciseLog *)exerciseLog;

//Deletes a exercise log record given the identifier in the persistent store.
- (void)deleteExerciseLogRecordByIdentifier:(NSString *)exerciseLogIdentifier;

//Deletes all of the exercise log records in the persistent store.
- (void)deleteAllExerciseLogRecords;


//-------------------------
#pragma mark Fetching Operations
//-------------------------

//Fetches a exercise log record given the identifier in the persistent store and returns a SHExerciseLog.
- (SHExerciseLog*)fetchExerciseLogByIdentifier:(NSString *)exerciseLogIdentifier;

//Fetches all of the exercise log records in the persistent store and returns a mutable array of SHExerciseLog.
- (NSMutableArray *)fetchAllExerciseLogs;

/****************************************************/
#pragma mark - Exercise Set Log Data Manager Methods
/****************************************************/

//------------------------
#pragma mark General Operations
//------------------------

//Saves a exercise set log record in the persistent store.
- (void)saveExerciseSetLogRecord:(SHExerciseSetLog *)exerciseLog;

//Updates a exercise set log record in the persistent store.
- (void)updateExerciseSetLogRecord:(SHExerciseSetLog *)exerciseLog;

//Deletes a exercise set log record in the persistent store.
- (void)deleteExerciseSetLogRecord:(SHExerciseSetLog *)exerciseLog;

//Deletes a exercise set log record given the identifier in the persistent store.
- (void)deleteExerciseSetLogRecordByIdentifier:(NSString *)exerciseSetLogIdentifier;

//Deletes all of the exercise set log records in the persistent store.
- (void)deleteAllExerciseSetLogRecords;


//-------------------------
#pragma mark Fetching Operations
//-------------------------

//Fetches a exercise set log record given the identifier in the persistent store and returns a SHExerciseSetLog.
- (SHExerciseSetLog*)fetchExerciseSetLogByIdentifier:(NSString *)exerciseSetLogIdentifier;

//Fetches all of the exercise set log records in the persistent store and returns a mutable array of SHExerciseSetLog.
- (NSMutableArray *)fetchAllExerciseSetLogs;

/************************************************/
#pragma mark - Workout Log Data Manager Methods
/************************************************/

//------------------------
#pragma mark General Operations
//------------------------

//Saves a workout log  record in the persistent store.
- (void)saveWorkoutLogRecord:(SHWorkoutLog *)workoutLog;

//Updates a workout log  record in the persistent store.
- (void)updateWorkoutLogRecord:(SHWorkoutLog *)workoutLog;

//Deletes a workout log  record in the persistent store.
- (void)deleteWorkoutLogRecord:(SHWorkoutLog *)workoutLog;

//Deletes a workout log record given the identifier in the persistent store.
- (void)deleteWorkoutLogRecordByIdentifier:(NSString *)workoutLogIdentifier;

//Deletes all of the workout log records in the persistent store.
- (void)deleteAllWorkoutLogRecords;

//-------------------------
#pragma mark Fetching Operations
//-------------------------

//Fetches a workout log record given the identifier in the persistent store and returns a SHWorkoutLog.
- (SHWorkoutLog*)fetchWorkoutLogByIdentifier:(NSString *)workoutLogIdentifier;

//Fetches all of the workout log records in the persistent store and returns a mutable array of SHWorkoutLog.
- (NSMutableArray *)fetchAllWorkoutLogs;

/********************************************/
#pragma mark -  Workout Data Manager Methods
/********************************************/

//------------------------
#pragma mark General Operations
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
#pragma mark Fetching Operations
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
#pragma mark General Operations
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
#pragma mark Fetching Operations
//-------------------------

- (CustomWorkout*)fetchManagedCustomWorkoutRecordByIdentifier:(NSString *)customWorkoutIdentifier;

//Fetches a custom workout record given the identifier in the persistent store and returns a SHCustomWorkout.
- (SHCustomWorkout*)fetchCustomWorkoutByIdentifier:(NSString *)customWorkoutIdentifier;

//Fetches all of the liked custom workout records in the persistent store and returns a mutable array of SHCustomWorkouts.
- (NSMutableArray *)fetchAllLikedCustomWorkouts;

//Fetches all of the custom workout records in the persistent store.
- (NSMutableArray *)fetchAllCustomWorkoutRecords;

//---------------------
#pragma mark Misc Operations
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
