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
    [exercise setValue:SHexercise.exerciseShortName forKey:@"exerciseShortName"];
    [exercise setValue:SHexercise.exerciseInstructions forKey:@"exerciseInstructions"];
    [exercise setValue:SHexercise.exerciseImageFile forKey:@"exerciseImageFile"];
    [exercise setValue:SHexercise.exerciseRecommendedSets forKey:@"exerciseRecommendedSets"];
    [exercise setValue:SHexercise.exerciseRecommendedReps forKey:@"exerciseRecommendedReps"];
    [exercise setValue:SHexercise.exerciseEquipmentNeeded forKey:@"exerciseEquipmentNeeded"];
    [exercise setValue:SHexercise.exercisePrimaryMuscle forKey:@"exercisePrimaryMuscle"];
    [exercise setValue:SHexercise.exerciseSecondaryMuscle forKey:@"exerciseSecondaryMuscle"];
    [exercise setValue:SHexercise.exerciseDifficulty forKey:@"exerciseDifficulty"];
    [exercise setValue:SHexercise.exerciseType forKey:@"exerciseType"];
    [exercise setValue:SHexercise.exerciseMechanicsType forKey:@"exerciseMechanicsType"];
    [exercise setValue:SHexercise.exerciseForceType forKey:@"exerciseForceType"];
    [exercise setValue:SHexercise.exerciseDifferentVariationsExerciseIdentifiers forKey:@"exerciseDifferentVariationsExerciseIdentifiers"];
    [exercise setValue:SHexercise.exerciseLiked forKey:@"exerciseLiked"];
    [exercise setValue:SHexercise.exerciseLastViewed forKey:@"exerciseLastViewed"];
    [exercise setValue:SHexercise.exerciseIsEdited forKey:@"exerciseIsEdited"];
    [exercise setValue:SHexercise.exerciseEditedDate forKey:@"exerciseEditedDate"];
    [exercise setValue:SHexercise.exerciseTimesViewed forKey:@"exerciseTimesViewed"];
    [exercise setValue:SHexercise.exerciseLikedDate forKey:@"exerciseLikedDate"];
}

//Creates SHExercise Record from Exercise Record
- (void)bind:(Exercise *)exercise {
    SHExercise *SHexercise = self;
    SHexercise.exerciseIdentifier = exercise.exerciseIdentifier;
    SHexercise.exerciseName = exercise.exerciseName;
    SHexercise.exerciseShortName = exercise.exerciseShortName;
    SHexercise.exerciseInstructions = exercise.exerciseInstructions;
    SHexercise.exerciseImageFile = exercise.exerciseImageFile;
    SHexercise.exerciseRecommendedSets = exercise.exerciseRecommendedSets;
    SHexercise.exerciseRecommendedReps = exercise.exerciseRecommendedReps;
    SHexercise.exerciseEquipmentNeeded = exercise.exerciseEquipmentNeeded;
    SHexercise.exercisePrimaryMuscle = exercise.exercisePrimaryMuscle;
    SHexercise.exerciseSecondaryMuscle = exercise.exerciseSecondaryMuscle;
    SHexercise.exerciseDifficulty = exercise.exerciseDifficulty;
    SHexercise.exerciseType = exercise.exerciseType;
    SHexercise.exerciseMechanicsType = exercise.exerciseMechanicsType;
    SHexercise.exerciseForceType = exercise.exerciseForceType;
    SHexercise.exerciseDifferentVariationsExerciseIdentifiers = exercise.exerciseDifferentVariationsExerciseIdentifiers;
    SHexercise.exerciseLiked = exercise.exerciseLiked;
    SHexercise.exerciseLastViewed = exercise.exerciseLastViewed;
    SHexercise.exerciseIsEdited = exercise.exerciseIsEdited;
    SHexercise.exerciseEditedDate = exercise.exerciseEditedDate;
    SHexercise.exerciseTimesViewed = exercise.exerciseTimesViewed;
    SHexercise.exerciseLikedDate = exercise.exerciseLikedDate;
}


@end
