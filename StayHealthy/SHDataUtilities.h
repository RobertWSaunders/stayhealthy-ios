//
//  SHDataUtilities.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-01-15.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHDataUtilities : NSObject

/*************************************/
#pragma mark - Query Building Methods
/*************************************/

//Creates a exercise query given the exercise type and the muscles.
+ (NSString *)createExerciseQuery:(exerciseType)exerciseType muscles:(NSArray *)muscleArray;

//Creates a exercise query given the exercise identifiers and exercise type.
+ (NSString *)createExerciseQueryFromExerciseIdentifiers:(exerciseType)exerciseType exerciseIdentifiers:(NSMutableArray *)exerciseIdentifiers;

//Creates a workout query given the workout identifiers.
+ (NSString *)createWorkoutQueryFromWorkoutIdentifiers:(NSMutableArray *)workoutIdentifiers;

/***************************************/
#pragma mark - Exercises Utility Methods
/***************************************/

/*---------------------------*/
#pragma mark - Shared Methods
/*---------------------------*/

//Converts a managed exercise object to a business object.
+ (id)convertExerciseToBusinessExercise:(id)managedExercise;

//Takes an exercise and adds user data to it.
+ (id)addUserDataToBusinessExercise:(id)exercise managedExercise:(id)managedExercise;

//Checks to see if the passed exercise has been saved to core data before.
+ (BOOL)exerciseHasBeenSaved:(id)exercise;

//Called when a user views an exercise, does the appropriate data sequence.
+ (void)exerciseBeingViewed;

/**************************************/
#pragma mark - Workouts Utility Methods
/**************************************/

/*---------------------------*/
#pragma mark - Shared Methods
/*---------------------------*/

//Converts a managed workout object and converts it to a SHWorkout.
+ (id)convertWorkoutToBusinessWorkout:(id)workout;

//Takes a SHWorkout and adds the users data to the workout.
+ (id)addUserDataToBusinessWorkout:(id)workout managedWorkout:(id)managedWorkout;

//Checks to see if a workout with the given identifier has been saved in the persistent store.
+ (BOOL)workoutHasBeenSaved:(id)workout;

//Checks to see if the user can add an exercise to a workout.
+ (BOOL)canAddExerciseToWorkout:(id)workout exercise:(id)exercise;

//Returns array of exercises in a workout.
+ (NSMutableArray*)getWorkoutExercises:(id)workout;

//Called when a user views a workout, does the appropriate data sequence.
+ (void)workoutBeingViewed;

//Adds a exercise to a workout.
+ (void)addExerciseToWorkout:(id)workout exercise:(id)exercise;

/**************************************/
#pragma mark - Logging Utility Methods
/**************************************/



@end
