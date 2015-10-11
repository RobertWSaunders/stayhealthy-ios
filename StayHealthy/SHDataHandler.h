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

@interface SHDataHandler : NSObject {
    
    sqlite3 *database;
    
    ExerciseDataManager *exerciseManager;
    WorkoutDataManager *workoutManager;
    CustomWorkoutDataManager *customWorkoutManager;
}

+ (id) getInstance;

#pragma mark - StayHealthy Database Data Manager Methods

- (void)performQuery:(NSString*)SQLQuery;

- (NSMutableArray *)performWorkoutStatement:(NSString*)SQLQuery;

- (NSMutableArray *)performExerciseStatement:(NSString*)SQLQuery;

#pragma mark - Exercise Data Manager Methods

- (void)saveExerciseRecord:(SHExercise *)exercise;

- (void)updateExerciseRecord:(SHExercise *)exercise;

- (BOOL)exerciseHasBeenSaved:(NSString *)workoutIdentifier;

- (NSMutableArray *)getRecentlyViewedExercises;

#pragma mark - Workout Data Manager Methods

- (void)saveWorkoutRecord:(SHWorkout *)workout;

- (void)updateWorkoutRecord:(SHWorkout *)workout;

- (BOOL)workoutHasBeenSaved:(NSString *)exerciseIdentifier;

#pragma mark - Custom Workout Data Manager Methods

- (void)saveCustomWorkoutRecord:(SHCustomWorkout *)customWorkout;

- (void)updateCustomWorkoutRecord:(SHCustomWorkout *)customWorkout;

@end
