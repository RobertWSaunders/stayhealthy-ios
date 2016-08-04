//
//  SHDataUtilities.m
//  StayHealthy
//
//  Created by Robert Saunders on 2016-01-15.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "SHDataUtilities.h"

@implementation SHDataUtilities

/*************************************/
#pragma mark - Query Building Methods
/*************************************/

//Creates a exercise query given the exercise type and the muscles.
+ (NSString *)createExerciseQuery:(exerciseType)exerciseType muscles:(NSArray *)muscleArray {
    NSString *table;
    NSString *query = @"";
    if (exerciseType == 0) {
        table = STRENGTH_DB_TABLENAME;
    }
    else if (exerciseType == 1){
        table = STRETCHING_DB_TABLENAME;
    }
    else {
        table = WARMUP_DB_TABLENAME;
    }
    
    int i = 0;
    if (muscleArray == nil) {
        query = [NSString stringWithFormat:@"SELECT * FROM %@",table];
    }
    else {
        
        for (NSString *muscle in muscleArray) {
            NSString *mucleInArray = muscle;
            mucleInArray = [CommonUtilities convertMuscleNameToDatabaseStandard:muscle];
            if (mucleInArray != nil) {
                if (i == 0) {
                    query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE exercisePrimaryMuscle LIKE '%@'",table,mucleInArray];
                }
                else {
                    query = [query stringByAppendingString:[NSString stringWithFormat:@" UNION ALL SELECT * FROM %@ WHERE exercisePrimaryMuscle LIKE '%@'",table,mucleInArray]];
                }
                
            }
            i++;
        }
    }
    
    query = [query stringByAppendingString:@" ORDER BY exerciseName COLLATE NOCASE"];
    NSLog(@"%@",query);
    
    return query;
}

//Creates a exercise query given the exercise identifiers and exercise type.
+ (NSString *)createExerciseQueryFromExerciseIdentifiers:(exerciseType)exerciseType exerciseIdentifiers:(NSMutableArray *)exerciseIdentifiers {
    
/*    NSString *exerciseIdentifiers = [exerciseIDs componentsJoinedByString:@","];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE exerciseIdentifier IN (%@)",table,exerciseIdentifiers];
    */
    return nil;
}

//Creates a workout query given the workout identifiers.
+ (NSString *)createWorkoutQueryFromWorkoutIdentifiers:(NSMutableArray *)workoutIdentifiers {
    /*
    NSString *workoutIdentifiers = [workoutIDs componentsJoinedByString:@","];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE workoutIdentifier IN (%@)",table,workoutIdentifiers];
    */
    return nil;
}

/***************************************/
#pragma mark - Exercise Utility Methods
/***************************************/

/*---------------------------*/
#pragma mark - Shared Methods
/*---------------------------*/

//Converts a managed exercise object to a business object.
+ (id)convertExerciseToBusinessExercise:(id)managedExercise {
    //Create a new SHExercise.
    SHExercise *exercise = [[SHExercise alloc] init];
    
    //Put the exercise identifier in a array.
  /*  NSMutableArray *exerciseIdentifiers = [[NSMutableArray alloc] initWithObjects:managedExercise.exerciseIdentifier, nil];
    
    //Create a reference to the database table.
    NSString *table;
    
    //Set the correct value for the table.
    if ([managedExercise.exerciseType isEqualToString:@"strength"]) {
        table = STRENGTH_DB_TABLENAME;
    }
    else if ([managedExercise.exerciseType isEqualToString:@"stretching"]) {
        table = STRETCHING_DB_TABLENAME;
    }
    else {
        table = WARMUP_DB_TABLENAME;
    }
    
    //Get the exercise.
    NSArray *shExerciseData = [[SHDataHandler getInstance] performExerciseStatement:[CommonUtilities createExerciseQueryFromExerciseIds:exerciseIdentifiers table:table] addUserData:YES];

    //Set the exercise to be the first from the array.
    if (shExerciseData.count > 0) {
        exercise = [shExerciseData objectAtIndex:0];
    }
    else {
        return nil;
    }
    */
    //Return the exercise.
    return exercise;
}

//Takes an exercise and adds user data to it.
+ (id)addUserDataToBusinessExercise:(id)exercise managedExercise:(id)managedExercise {

 /*   if (managedExercise.exerciseName != nil) {
        exercise.exerciseName = managedExercise.exerciseName;
    }
    if (managedExercise.exerciseInstructions != nil) {
        exercise.exerciseInstructions = managedExercise.exerciseInstructions;
    }
    if (managedExercise.exerciseSets != nil) {
        exercise.exerciseSets = managedExercise.exerciseSets;
    }
    if (managedExercise.exerciseReps != nil) {
        exercise.exerciseReps = managedExercise.exerciseReps;
    }
    if (managedExercise.exerciseEquipment != nil) {
        exercise.exerciseEquipment = managedExercise.exerciseEquipment;
    }
    if (managedExercise.exercisePrimaryMuscle != nil) {
        exercise.exercisePrimaryMuscle = managedExercise.exercisePrimaryMuscle;
    }
    if (managedExercise.exerciseSecondaryMuscle != nil) {
        exercise.exerciseSecondaryMuscle = managedExercise.exerciseSecondaryMuscle;
    }
    if (managedExercise.exerciseDifficulty != nil) {
        exercise.exerciseDifficulty = managedExercise.exerciseDifficulty;
    }
    if (managedExercise.exerciseMechanicsType != nil) {
        exercise.exerciseMechanicsType = managedExercise.exerciseMechanicsType;
    }
    if (managedExercise.exerciseForceType != nil) {
        exercise.exerciseForceType = managedExercise.exerciseForceType;
    }
    if (managedExercise.exerciseDifferentVariationsExerciseIdentifiers != nil) {
        exercise.exerciseDifferentVariationsExerciseIdentifiers = managedExercise.exerciseDifferentVariationsExerciseIdentifiers;
    }
    
    exercise.exerciseType = managedExercise.exerciseType;
    exercise.exerciseLiked = managedExercise.exerciseLiked;
    exercise.exerciseLastViewed = managedExercise.exerciseLastViewed;
    exercise.exerciseEditedDate = managedExercise.exerciseEditedDate;
    exercise.exerciseTimesViewed = managedExercise.exerciseTimesViewed;
    exercise.exerciseIsEdited = managedExercise.exerciseIsEdited;
*/
    return exercise;
}

//Checks to see if the passed exercise has been saved to core data before.
+ (BOOL)exerciseHasBeenSaved:(id)exercise {
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
 /*   Exercise *exercise = [dataHandler fetchManagedExerciseRecordByIdentifierAndExerciseType:exerciseIdentifier exerciseType:exerciseType];
    if (exercise != nil)
        return YES;
  */
    return NO;
}

//Called when a user views an exercise, does the appropriate data sequence.
+ (void)exerciseBeingViewed {
    
}

/**************************************/
#pragma mark - Workout Utility Methods
/**************************************/

/*---------------------------*/
#pragma mark - Shared Methods
/*---------------------------*/

//Converts a managed workout object and converts it to a SHWorkout.
+ (id)convertWorkoutToBusinessWorkout:(id)workout {
    
    SHCustomWorkout *shWorkout = [[SHCustomWorkout alloc] init];
    
    [shWorkout bind:workout];
    
    return shWorkout;

    
/*    //Create a new SHWorkout.
    SHWorkout *workout = [[SHWorkout alloc] init];
    
    NSMutableArray *workoutID = [[NSMutableArray alloc] initWithObjects:workout.workoutIdentifier, nil];
    
    //Get the workout.
    NSArray *shWorkoutData = [[SHDataHandler getInstance] performWorkoutStatement:[CommonUtilities createWorkoutQueryFromWorkoutIds:workoutID table:WORKOUTS_DB_TABLENAME] addUserData:NO];
    
    NSMutableArray *userWorkoutData = [[NSMutableArray alloc] init];
    
    for (SHWorkout *workoutInArray in shWorkoutData) {
        SHWorkout *userWorkout = [self addUserDataToSHWorkout:workoutInArray managedWorkout:managedWorkout];
        [userWorkoutData addObject:userWorkout];
    }
    
    //Set the exercise to be the first from the array.
    if (userWorkoutData.count > 0) {
        workout = [userWorkoutData objectAtIndex:0];
    }
    else {
        return nil;
    }
    */
    //Return the workout.
    return workout;
}

//Takes a SHWorkout and adds the users data to the workout.
+ (id)addUserDataToBusinessWorkout:(id)workout managedWorkout:(id)managedWorkout {

    return workout;
}

//Checks to see if a workout with the given identifier has been saved in the persistent store.
+ (BOOL)workoutHasBeenSaved:(id)workout {
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
  /*  Workout *workout = [dataHandler fetchManagedWorkoutRecordByIdentifier:workoutIdentifier];
    if (workout != nil)
        return YES;
    return NO;
    
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    CustomWorkout *customWorkout = [dataHandler fetchManagedCustomWorkoutRecordByIdentifier:customWorkoutIdentifier];
    if (customWorkout != nil)
        return YES;
   */
    return NO;
}

//Checks to see if the user can add an exercise to a workout.
+ (BOOL)canAddExerciseToWorkout:(id)workout exercise:(id)exercise {
  /*  NSMutableArray *workoutExerciseIDs = [[customWorkout.workoutExerciseIDs componentsSeparatedByString:@","] mutableCopy];
    NSMutableArray *workoutExerciseTypes = [[customWorkout.exerciseTypes componentsSeparatedByString:@","]     mutableCopy];
    
    if ([workoutExerciseIDs containsObject:exercise.exerciseIdentifier] && [workoutExerciseTypes containsObject:exercise.exerciseType]) {
        return NO;
    }
    else {
        return YES;
    }
    */
    return nil;
}

//Returns array of exercises that are in a workout.
+ (NSMutableArray*)getWorkoutExercises:(id)workout {
    
    /* //Get the exercises in the workout identifiers.
     NSArray *exerciseIdentifiers = [workout.workoutExerciseIdentifiers componentsSeparatedByString:@","];
     
     NSString *exerciseTypesWithoutSpaces = [workout.workoutExerciseTypes stringByReplacingOccurrencesOfString:@" " withString:@""];
     
     //Get the exercises in the workouts type.
     //NSArray *exerciseTypes = [exerciseTypesWithoutSpaces componentsSeparatedByString:@","];
     
     //Reference the platform.
     //SHDataHandler *dataHandler = [SHDataHandler getInstance];
     
     //Initialize a array that will be retured.
     NSMutableArray *exercises = [[NSMutableArray alloc] init];
     
     for (int i = 0; i < exerciseIdentifiers.count; i++) {
     //Create a new exercise.
     SHExercise *exercise = [[SHExercise alloc] init];
     NSArray *tempExerciseArray = [[NSArray alloc] init];
     
     if ([[exerciseTypes objectAtIndex:i] isEqualToString:@"stretching"]) {
     tempExerciseArray = [dataHandler performExerciseStatement:[self generateWorkoutExerciseQuery:stretching exerciseIdentifier:exerciseIdentifiers[i]]];
     }
     else if ([[exerciseTypes objectAtIndex:i] isEqualToString:@"strength"]) {
     tempExerciseArray = [dataHandler performExerciseStatement:[self generateWorkoutExerciseQuery:strength exerciseIdentifier:exerciseIdentifiers[i]]];
     }
     else {
     tempExerciseArray = [dataHandler performExerciseStatement:[self generateWorkoutExerciseQuery:warmup exerciseIdentifier:exerciseIdentifiers[i]]];
     }
     
     if (tempExerciseArray.count > 0) {
     //Get the exercise from the searched statement.
     exercise = [tempExerciseArray objectAtIndex:0];
     //Add the exercises to the array.
     [exercises addObject:exercise];
     }
     }
     */
    return nil;
    
    /*
     //Get the exercises in the workout identifiers.
     NSArray *exerciseIdentifiers = [workout.workoutExerciseIDs componentsSeparatedByString:@","];
     
     NSString *exerciseTypesWithoutSpaces = [workout.exerciseTypes stringByReplacingOccurrencesOfString:@" " withString:@""];
     
     //Get the exercises in the workouts type.
     // NSArray *exerciseTypes = [exerciseTypesWithoutSpaces componentsSeparatedByString:@","];
     
     //Reference the platform.
     //SHDataHandler *dataHandler = [SHDataHandler getInstance];
     
     //Initialize a array that will be retured.
     NSMutableArray *exercises = [[NSMutableArray alloc] init];
     
     for (int i = 0; i < exerciseIdentifiers.count; i++) {
     //Create a new exercise.
     SHExercise *exercise = [[SHExercise alloc] init];
     NSArray *tempExerciseArray = [[NSArray alloc] init];
     
     if ([[exerciseTypes objectAtIndex:i] isEqualToString:@"stretching"]) {
     tempExerciseArray = [dataHandler performExerciseStatement:[self generateWorkoutExerciseQuery:stretching exerciseIdentifier:exerciseIdentifiers[i]]];
     }
     else if ([[exerciseTypes objectAtIndex:i] isEqualToString:@"strength"]) {
     tempExerciseArray = [dataHandler performExerciseStatement:[self generateWorkoutExerciseQuery:strength exerciseIdentifier:exerciseIdentifiers[i]]];
     }
     else {
     tempExerciseArray = [dataHandler performExerciseStatement:[self generateWorkoutExerciseQuery:warmup exerciseIdentifier:exerciseIdentifiers[i]]];
     }
     
     if (tempExerciseArray.count > 0) {
     //Get the exercise from the searched statement.
     exercise = [tempExerciseArray objectAtIndex:0];
     //Add the exercises to the array.
     [exercises addObject:exercise];
     }
     }
     */
    return nil;
}

//Called when a user views a workout, does the appropriate data sequence.
+ (void)workoutBeingViewed {
    
}

//Adds a exercise to a workout.
+ (void)addExerciseToWorkout:(id)workout exercise:(id)exercise {
    //if ([self canAddExerciseToWorkout:customWorkout exercise:exercise]) {
  /*  NSMutableArray *workoutExerciseIDs = [[customWorkout.workoutExerciseIDs componentsSeparatedByString:@","] mutableCopy];
    NSMutableArray *workoutExerciseTypes = [[customWorkout.exerciseTypes componentsSeparatedByString:@","]     mutableCopy];
    
    [workoutExerciseIDs addObject:exercise.exerciseIdentifier];
    [workoutExerciseTypes addObject:exercise.exerciseType];
    
    NSString *newExerciseIdentifiers = [workoutExerciseIDs componentsJoinedByString:@","];
    NSString *newExerciseTypes = [workoutExerciseTypes componentsJoinedByString:@","];
    
    customWorkout.workoutExerciseIDs = newExerciseIdentifiers;
    customWorkout.exerciseTypes = newExerciseTypes;
    
    [self updateCustomWorkoutRecord:customWorkout];
    // }
*/
}

/**************************************/
#pragma mark - Logging Utility Methods
/**************************************/

@end
