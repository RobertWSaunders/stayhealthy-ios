//
//  SHDataUtilities.m
//  StayHealthy
//
//  Created by Robert Saunders on 2016-01-15.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "SHDataUtilities.h"

@implementation SHDataUtilities

/***************************************/
#pragma mark - Exercise Utility Methods
/***************************************/

//Converts a managed exercise object and converts it to a SHExercise.
+ (SHExercise*)convertExerciseToSHExercise:(Exercise*)managedExercise {
    //Create a new SHExercise.
    SHExercise *exercise = [[SHExercise alloc] init];
    
    //Put the exercise identifier in a array.
    NSMutableArray *exerciseIdentifiers = [[NSMutableArray alloc] initWithObjects:managedExercise.exerciseIdentifier, nil];
    
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
    
    //Return the exercise.
    return exercise;
}

//Takes a SHExercise and adds the users data to the exercise.
+ (SHExercise*)addUserDataToSHExercise:(SHExercise *)exercise managedExercise:(Exercise *)managedExercise {

    if (managedExercise.exerciseName != nil) {
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

    return exercise;
}


//Checks to see if a exercise with the given identifier has been saved in the persistent store.
+ (BOOL)exerciseHasBeenSaved:(NSString *)exerciseIdentifier exerciseType:(NSString*)exerciseType {
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    Exercise *exercise = [dataHandler fetchManagedExerciseRecordByIdentifierAndExerciseType:exerciseIdentifier exerciseType:exerciseType];
    if (exercise != nil)
        return YES;
    return NO;
}

/**************************************/
#pragma mark - Workout Utility Methods
/**************************************/

//Converts a managed workout object and converts it to a SHWorkout.
+ (SHWorkout *)convertWorkoutToSHWorkout:(Workout*)managedWorkout {
    
    //Create a new SHWorkout.
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
    
    //Return the workout.
    return workout;
}

//Takes a SHWorkout and adds the users data to the workout.
+ (SHWorkout*)addUserDataToSHWorkout:(SHWorkout *)workout managedWorkout:(Workout *)managedWorkout {

    return workout;
}

//Checks to see if a workout with the given identifier has been saved in the persistent store.
+ (BOOL)workoutHasBeenSaved:(NSString *)workoutIdentifier {
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    Workout *workout = [dataHandler fetchManagedWorkoutRecordByIdentifier:workoutIdentifier];
    if (workout != nil)
        return YES;
    return NO;
}

/********************************************/
#pragma mark - Custom Workout Utility Methods
/********************************************/

//Converts a managed custom workout object and converts it to a SHCustomWorkout.
+ (SHCustomWorkout *)convertCustomWorkoutToSHCustomWorkout:(CustomWorkout*)workout {
    SHCustomWorkout *shWorkout = [[SHCustomWorkout alloc] init];
    
    [shWorkout bind:workout];
    
    return shWorkout;
}

//Checks to see if the user can add a exercise to the given custom workout.
+ (BOOL)canAddExerciseToWorkout:(SHCustomWorkout *)customWorkout exercise:(SHExercise *)exercise {
    NSMutableArray *workoutExerciseIDs = [[customWorkout.workoutExerciseIDs componentsSeparatedByString:@","] mutableCopy];
    NSMutableArray *workoutExerciseTypes = [[customWorkout.exerciseTypes componentsSeparatedByString:@","]     mutableCopy];
    
    if ([workoutExerciseIDs containsObject:exercise.exerciseIdentifier] && [workoutExerciseTypes containsObject:exercise.exerciseType]) {
        return NO;
    }
    else {
        return YES;
    }
    
    
}

//Checks to see if a custom workout with the given identifier has been saved in the persistent store.
+ (BOOL)customWorkoutHasBeenSaved:(NSString *)customWorkoutIdentifier {
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    CustomWorkout *customWorkout = [dataHandler fetchManagedCustomWorkoutRecordByIdentifier:customWorkoutIdentifier];
    if (customWorkout != nil)
        return YES;
    return NO;
}

/*-(BOOL)checkColumnExists
{
    BOOL columnExists = NO;
    
    sqlite3_stmt *selectStmt;
    
    const char *sqlStatement = "select yourcolumnname from yourtable";
    if(sqlite3_prepare_v2(yourDbHandle, sqlStatement, -1, &selectStmt, NULL) == SQLITE_OK)
        columnExists = YES;
    
    return columnExists;
}*/

@end
