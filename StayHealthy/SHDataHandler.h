//
//  SHDataHandler.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-15.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExerciseDataManager.h"
#import "WorkoutDataManager.h"
#import "CustomWorkoutDataManager.h"
#import "UserDataManager.h"

@interface SHDataHandler : NSObject {
    
    sqlite3 *database;
    
    ExerciseDataManager *exerciseManager;
    WorkoutDataManager *workoutManager;
    CustomWorkoutDataManager *customWorkoutManager;
    UserDataManager *userDataManager;
}

+ (id) getInstance;

#pragma mark - StayHealthy Database Data Manager Methods

- (void)performQuery:(NSString*)SQLQuery;

- (NSMutableArray *)performWorkoutStatement:(NSString*)SQLQuery;

- (NSMutableArray *)performExerciseStatement:(NSString*)SQLQuery;

- (SHExercise *)convertExerciseToSHExercise:(Exercise*)exercise;

#pragma mark - Exercise Data Manager Methods

- (void)saveExerciseRecord:(SHExercise *)exercise;

- (void)updateExerciseRecord:(SHExercise *)exercise;

- (Exercise*)fetchExerciseByIdentifier:(NSString *)exerciseIdentifier;

- (BOOL)exerciseHasBeenSaved:(NSString *)workoutIdentifier;

- (NSMutableArray *)getRecentlyViewedExercises;

- (NSMutableArray *)getAllLikedExercises;

- (NSMutableArray *)getStrengthLikedExercises;
- (NSMutableArray *)getStretchLikedExercises;
- (NSMutableArray *)getWarmupLikedExercises;


#pragma mark - Workout Data Manager Methods

- (void)saveWorkoutRecord:(SHWorkout *)workout;

- (void)updateWorkoutRecord:(SHWorkout *)workout;

- (BOOL)workoutHasBeenSaved:(NSString *)exerciseIdentifier;

#pragma mark - Custom Workout Data Manager Methods

- (void)saveCustomWorkoutRecord:(SHCustomWorkout *)customWorkout;

- (void)updateCustomWorkoutRecord:(SHCustomWorkout *)customWorkout;

#pragma mark - User Data Manager Methods

- (void)saveUser:(SHUser *)user;
- (void)updateUser:(SHUser*)user;
- (NSString*)getUserIdentifier;
- (BOOL)userIsCreated;


//---------------------------------------
#pragma mark Auto Database Update Methods
//---------------------------------------

//Checks to see if the user wants auto database updates then compares current installed database to online database and installs if nescessary.
- (void)performDatabaseUpdate;

//Checks if there is a update that can be made to the database.
- (BOOL)isDatabaseUpdate;

//Returns the database version that is store on the web.
- (NSString *)onlineDatabaseVersion;

@end
