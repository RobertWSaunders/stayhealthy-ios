//
//  SHDataUtilities.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-01-15.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHDataUtilities : NSObject

/***************************************/
#pragma mark - Exercise Utility Methods
/***************************************/

//Converts a managed exercise object and converts it to a SHExercise.
+ (SHExercise*)convertExerciseToSHExercise:(Exercise *)managedExercise;

//Takes a SHExercise and adds the users data to the exercise.
+ (SHExercise*)addUserDataToSHExercise:(SHExercise *)exercise managedExercise:(Exercise *)managedExercise;

//Checks to see if a exercise with the given identifier has been saved in the persistent store.
+ (BOOL)exerciseHasBeenSaved:(NSString *)exerciseIdentifier exerciseType:(NSString*)exerciseType;

/*********************************************/
#pragma mark - Custom Exercise Utility Methods
/*********************************************/

/*******************************************/
#pragma mark - Exercise Log Utility Methods
/*******************************************/

/**************************************/
#pragma mark - Workout Utility Methods
/**************************************/

//Converts a managed workout object and converts it to a SHWorkout.
+ (SHWorkout*)convertWorkoutToSHWorkout:(Workout *)workout;

//Takes a SHWorkout and adds the users data to the workout.
+ (SHWorkout*)addUserDataToSHWorkout:(SHWorkout *)workout managedWorkout:(Workout *)managedWorkout;

//Checks to see if a workout with the given identifier has been saved in the persistent store.
+ (BOOL)workoutHasBeenSaved:(NSString *)workoutIdentifier;

/********************************************/
#pragma mark - Custom Workout Utility Methods
/********************************************/

//Converts a managed custom workout object and converts it to a SHCustomWorkout.
+ (SHCustomWorkout*)convertCustomWorkoutToSHCustomWorkout:(CustomWorkout*)workout;

//Checks to see if the user can add a exercise to the given custom workout.
+ (BOOL)canAddExerciseToWorkout:(SHCustomWorkout *)customWorkout exercise:(SHExercise *)exercise;

//Checks to see if a custom workout with the given identifier has been saved in the persistent store.
+ (BOOL)customWorkoutHasBeenSaved:(NSString *)customWorkoutIdentifier;

/*****************************************/
#pragma mark - Workout Log Utility Methods
/*****************************************/

@end
