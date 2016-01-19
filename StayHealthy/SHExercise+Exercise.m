//
//  SHExercise+Exercise.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-15.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "SHExercise+Exercise.h"

@implementation SHExercise (Exercise)

//Creates Exercise Record from SHExercise Record
- (void)map:(Exercise *)exercise {
    SHExercise *SHexercise = self;
    [exercise setValue:SHexercise.exerciseIdentifier forKey:@"exerciseIdentifier"];
    [exercise setValue:SHexercise.exerciseName forKey:@"exerciseName"];
    [exercise setValue:SHexercise.exerciseMuscle forKey:@"exerciseMuscle"];
    [exercise setValue:SHexercise.exerciseInstructions forKey:@"exerciseInstructions"];
    [exercise setValue:SHexercise.exerciseImageFile forKey:@"exerciseImageFile"];
    [exercise setValue:SHexercise.exerciseSets forKey:@"exerciseSets"];
    [exercise setValue:SHexercise.exerciseReps forKey:@"exerciseReps"];
    [exercise setValue:SHexercise.exerciseEquipment forKey:@"exerciseEquipment"];
    [exercise setValue:SHexercise.exercisePrimaryMuscle forKey:@"exercisePrimaryMuscle"];
    [exercise setValue:SHexercise.exerciseSecondaryMuscle forKey:@"exerciseSecondaryMuscle"];
    [exercise setValue:SHexercise.exerciseDifficulty forKey:@"exerciseDifficulty"];
    [exercise setValue:SHexercise.exerciseType forKey:@"exerciseType"];
    [exercise setValue:SHexercise.exerciseLiked forKey:@"exerciseLiked"];
    [exercise setValue:SHexercise.exerciseLastViewed forKey:@"exerciseLastViewed"];
    [exercise setValue:SHexercise.exerciseEditedDate forKey:@"exerciseEditedDate"];
    [exercise setValue:SHexercise.exerciseTimesViewed forKey:@"exerciseTimesViewed"];
}

//Creates SHExercise Record from Exercise Record
- (void)bind:(Exercise *)exercise {
    SHExercise *SHexercise = self;
    SHexercise.exerciseIdentifier = exercise.exerciseIdentifier;
    SHexercise.exerciseName = exercise.exerciseName;
    SHexercise.exerciseMuscle = exercise.exerciseMuscle;
    SHexercise.exerciseInstructions = exercise.exerciseInstructions;
    SHexercise.exerciseImageFile = exercise.exerciseImageFile;
    SHexercise.exerciseSets = exercise.exerciseSets;
    SHexercise.exerciseReps = exercise.exerciseReps;
    SHexercise.exerciseEquipment = exercise.exerciseEquipment;
    SHexercise.exercisePrimaryMuscle = exercise.exercisePrimaryMuscle;
    SHexercise.exerciseSecondaryMuscle = exercise.exerciseSecondaryMuscle;
    SHexercise.exerciseDifficulty = exercise.exerciseDifficulty;
    SHexercise.exerciseType = exercise.exerciseType;
    SHexercise.exerciseLiked = exercise.exerciseLiked;
    SHexercise.exerciseLastViewed = exercise.exerciseLastViewed;
    SHexercise.exerciseEditedDate = exercise.exerciseEditedDate;
    SHexercise.exerciseTimesViewed = exercise.exerciseTimesViewed;
}


@end
