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
    [customExercise setValue:SHcustomexercise.customExerciseIdentifier forKey:@"customExerciseIdentifier"];
    [customExercise setValue:SHcustomexercise.customExerciseName forKey:@"customExerciseName"];
    [customExercise setValue:SHcustomexercise.customExerciseShortName forKey:@"customExerciseShortName"];
    [customExercise setValue:SHcustomexercise.customExerciseInstructions forKey:@"customExerciseInstructions"];
    [customExercise setValue:SHcustomexercise.customExerciseImageFile forKey:@"customExerciseImageFile"];
    [customExercise setValue:SHcustomexercise.customExerciseRecommendedSets forKey:@"customExerciseRecommendedSets"];
    [customExercise setValue:SHcustomexercise.customExerciseRecommendedReps forKey:@"customExerciseRecommendedReps"];
    [customExercise setValue:SHcustomexercise.customExerciseEquipmentNeeded forKey:@"customExerciseEquipmentNeeded"];
    [customExercise setValue:SHcustomexercise.customExercisePrimaryMuscle forKey:@"customExercisePrimaryMuscle"];
    [customExercise setValue:SHcustomexercise.customExerciseSecondaryMuscle forKey:@"customExerciseSecondaryMuscle"];
    [customExercise setValue:SHcustomexercise.customExerciseDifficulty forKey:@"customExerciseDifficulty"];
    [customExercise setValue:SHcustomexercise.customExerciseType forKey:@"customExerciseType"];
    [customExercise setValue:SHcustomexercise.customExerciseMechanicsType forKey:@"customExerciseMechanicsType"];
    [customExercise setValue:SHcustomexercise.customExerciseForceType forKey:@"customExerciseForceType"];
    [customExercise setValue:SHcustomexercise.customExerciseDifferentVariationsIdentifiers forKey:@"customExerciseDifferentVariationsIdentifiers"];
    [customExercise setValue:SHcustomexercise.customExerciseLastViewed forKey:@"customExerciseLastViewed"];
    [customExercise setValue:SHcustomexercise.customExerciseCreatedDate forKey:@"customExerciseCreatedDate"];
    [customExercise setValue:SHcustomexercise.customExerciseEditedDate forKey:@"customExerciseEditedDate"];
    [customExercise setValue:SHcustomexercise.customExerciseTimesViewed forKey:@"customExerciseTimesViewed"];
     [customExercise setValue:SHcustomexercise.customExerciseLiked forKey:@"customExerciseLiked"];
     [customExercise setValue:SHcustomexercise.customExerciseLikedDate forKey:@"customExerciseLikedDate"];
}

//Creates SHCustomExercise Record from CustomExercise Record
- (void)bind:(CustomExercise *)customExercise {
    SHCustomExercise *SHcustomexercise = self;
    SHcustomexercise.customExerciseIdentifier = customExercise.customExerciseIdentifier;
    SHcustomexercise.customExerciseName = customExercise.customExerciseName;
    SHcustomexercise.customExerciseShortName = customExercise.customExerciseShortName;
    SHcustomexercise.customExerciseInstructions = customExercise.customExerciseInstructions;
    SHcustomexercise.customExerciseImageFile = customExercise.customExerciseImageFile;
    SHcustomexercise.customExerciseRecommendedSets = customExercise.customExerciseRecommendedSets;
    SHcustomexercise.customExerciseRecommendedReps = customExercise.customExerciseRecommendedReps;
    SHcustomexercise.customExerciseEquipmentNeeded = customExercise.customExerciseEquipmentNeeded;
    SHcustomexercise.customExercisePrimaryMuscle = customExercise.customExercisePrimaryMuscle;
    SHcustomexercise.customExerciseSecondaryMuscle = customExercise.customExerciseSecondaryMuscle;
    SHcustomexercise.customExerciseDifficulty = customExercise.customExerciseDifficulty;
    SHcustomexercise.customExerciseType = customExercise.customExerciseType;
    SHcustomexercise.customExerciseMechanicsType = customExercise.customExerciseMechanicsType;
    SHcustomexercise.customExerciseForceType = customExercise.customExerciseForceType;
    SHcustomexercise.customExerciseDifferentVariationsIdentifiers = customExercise.customExerciseDifferentVariationsIdentifiers;
    SHcustomexercise.customExerciseLiked = customExercise.customExerciseLiked;
     SHcustomexercise.customExerciseLikedDate = customExercise.customExerciseLikedDate;
    SHcustomexercise.customExerciseLastViewed = customExercise.customExerciseLastViewed;
    SHcustomexercise.customExerciseCreatedDate = customExercise.customExerciseCreatedDate;
    SHcustomexercise.customExerciseEditedDate = customExercise.customExerciseEditedDate;
    SHcustomexercise.customExerciseTimesViewed = customExercise.customExerciseTimesViewed;
}

@end
