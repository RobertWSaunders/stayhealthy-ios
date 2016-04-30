//
//  SHCustomExercise+CustomExercise.m
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-29.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "SHCustomExercise+CustomExercise.h"

@implementation SHCustomExercise (CustomExercise)

//Creates CustomExercise Record from SHCustomExercise Record
- (void)map:(CustomExercise *)customExercise {
    SHCustomExercise *SHcustomexercise = self;
    [customExercise setValue:SHcustomexercise.exerciseIdentifier forKey:@"exerciseIdentifier"];
    [customExercise setValue:SHcustomexercise.exerciseName forKey:@"exerciseName"];
    [customExercise setValue:SHcustomexercise.exerciseShortName forKey:@"exerciseShortName"];
    [customExercise setValue:SHcustomexercise.exerciseInstructions forKey:@"exerciseInstructions"];
    [customExercise setValue:SHcustomexercise.exerciseImageFile forKey:@"exerciseImageFile"];
    [customExercise setValue:SHcustomexercise.exerciseSets forKey:@"exerciseSets"];
    [customExercise setValue:SHcustomexercise.exerciseReps forKey:@"exerciseReps"];
    [customExercise setValue:SHcustomexercise.exerciseEquipment forKey:@"exerciseEquipment"];
    [customExercise setValue:SHcustomexercise.exercisePrimaryMuscle forKey:@"exercisePrimaryMuscle"];
    [customExercise setValue:SHcustomexercise.exerciseSecondaryMuscle forKey:@"exerciseSecondaryMuscle"];
    [customExercise setValue:SHcustomexercise.exerciseDifficulty forKey:@"exerciseDifficulty"];
    [customExercise setValue:SHcustomexercise.exerciseType forKey:@"exerciseType"];
    [customExercise setValue:SHcustomexercise.exerciseMechanicsType forKey:@"exerciseMechanicsType"];
    [customExercise setValue:SHcustomexercise.exerciseForceType forKey:@"exerciseForceType"];
    [customExercise setValue:SHcustomexercise.exerciseDifferentVariationsExerciseIdentifiers forKey:@"exerciseDifferentVariationsExerciseIdentifiers"];
    [customExercise setValue:SHcustomexercise.exerciseLiked forKey:@"exerciseLiked"];
    [customExercise setValue:SHcustomexercise.exerciseLastViewed forKey:@"exerciseLastViewed"];
    [customExercise setValue:SHcustomexercise.exerciseDateCreated forKey:@"exerciseDateCreated"];
    [customExercise setValue:SHcustomexercise.exerciseDateModified forKey:@"exerciseDateModified"];
    [customExercise setValue:SHcustomexercise.exerciseTimesViewed forKey:@"exerciseTimesViewed"];
}

//Creates SHCustomExercise Record from CustomExercise Record
- (void)bind:(CustomExercise *)customExercise {
    SHCustomExercise *SHcustomexercise = self;
    SHcustomexercise.exerciseIdentifier = customExercise.exerciseIdentifier;
    SHcustomexercise.exerciseName = customExercise.exerciseName;
    SHcustomexercise.exerciseShortName = customExercise.exerciseShortName;
    SHcustomexercise.exerciseInstructions = customExercise.exerciseInstructions;
    SHcustomexercise.exerciseImageFile = customExercise.exerciseImageFile;
    SHcustomexercise.exerciseSets = customExercise.exerciseSets;
    SHcustomexercise.exerciseReps = customExercise.exerciseReps;
    SHcustomexercise.exerciseEquipment = customExercise.exerciseEquipment;
    SHcustomexercise.exercisePrimaryMuscle = customExercise.exercisePrimaryMuscle;
    SHcustomexercise.exerciseSecondaryMuscle = customExercise.exerciseSecondaryMuscle;
    SHcustomexercise.exerciseDifficulty = customExercise.exerciseDifficulty;
    SHcustomexercise.exerciseType = customExercise.exerciseType;
    SHcustomexercise.exerciseMechanicsType = customExercise.exerciseMechanicsType;
    SHcustomexercise.exerciseForceType = customExercise.exerciseForceType;
    SHcustomexercise.exerciseDifferentVariationsExerciseIdentifiers = customExercise.exerciseDifferentVariationsExerciseIdentifiers;
    SHcustomexercise.exerciseLiked = customExercise.exerciseLiked;
    SHcustomexercise.exerciseLastViewed = customExercise.exerciseLastViewed;
    SHcustomexercise.exerciseDateCreated = customExercise.exerciseDateCreated;
    SHcustomexercise.exerciseDateModified = customExercise.exerciseDateModified;
    SHcustomexercise.exerciseTimesViewed = customExercise.exerciseTimesViewed;
}

@end
