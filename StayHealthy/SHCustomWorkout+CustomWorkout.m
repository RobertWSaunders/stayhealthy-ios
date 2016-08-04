//
//  SHCustomWorkout+CustomWorkout.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "SHCustomWorkout+CustomWorkout.h"

@implementation SHCustomWorkout (CustomWorkout)

//Creates Custom Workout Record from SHCustomWorkout Record
- (void)map:(CustomWorkout *)customWorkout {
    SHCustomWorkout *SHcustomWorkout = self;
    [customWorkout setValue:SHcustomWorkout.customWorkoutIdentifier forKey:@"customWorkoutIdentifier"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutName forKey:@"customWorkoutName"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutSummary forKey:@"customWorkoutSummary"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutTargetMuscles forKey:@"customWorkoutTargetMuscles"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutTargetSports forKey:@"customWorkoutTargetSports"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutType forKey:@"customWorkoutType"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutDifficulty forKey:@"customWorkoutDifficulty"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutExerciseTypes forKey:@"customWorkoutExerciseTypes"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutExerciseIdentifiers forKey:@"customWorkoutExerciseIdentifiers"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutLiked forKey:@"customWorkoutLiked"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutTimesCompleted forKey:@"customWorkoutTimesCompleted"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutTimesViewed forKey:@"customWorkoutTimesViewed"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutLastViewed forKey:@"customWorkoutLastViewed"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutLastDateCompleted forKey:@"customWorkoutLastDateCompleted"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutEditedDate forKey:@"customWorkoutEditedDate"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutCreatedDate forKey:@"customWorkoutCreatedDate"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutEquipmentNeeded forKey:@"customWorkoutEquipmentNeeded"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutLikedDate forKey:@"customWorkoutLikedDate"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutShortName forKey:@"customWorkoutShortName"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutTargetGender forKey:@"customWorkoutTargetGender"];
    [customWorkout setValue:SHcustomWorkout.customWorkoutEstimatedDuration forKey:@"customWorkoutEstimatedDuration"];
}

//Creates SHCustomWorkout Record from Custom Workout Record
- (void)bind:(CustomWorkout *)customWorkout {
    SHCustomWorkout *SHcustomWorkout = self;
    SHcustomWorkout.customWorkoutIdentifier = customWorkout.customWorkoutIdentifier;
    SHcustomWorkout.customWorkoutLiked = customWorkout.customWorkoutLiked;
    SHcustomWorkout.customWorkoutLastDateCompleted = customWorkout.customWorkoutLastDateCompleted;
    SHcustomWorkout.customWorkoutLastViewed = customWorkout.customWorkoutLastViewed;
    SHcustomWorkout.customWorkoutTimesCompleted = customWorkout.customWorkoutTimesCompleted;
    SHcustomWorkout.customWorkoutName = customWorkout.customWorkoutName;
    SHcustomWorkout.customWorkoutSummary= customWorkout.customWorkoutSummary;
    SHcustomWorkout.customWorkoutTargetMuscles = customWorkout.customWorkoutTargetMuscles;
    SHcustomWorkout.customWorkoutTargetSports = customWorkout.customWorkoutTargetSports;
    SHcustomWorkout.customWorkoutExerciseIdentifiers = customWorkout.customWorkoutExerciseIdentifiers;
    SHcustomWorkout.customWorkoutDifficulty = customWorkout.customWorkoutDifficulty;
    SHcustomWorkout.customWorkoutType = customWorkout.customWorkoutType;
    SHcustomWorkout.customWorkoutCreatedDate = customWorkout.customWorkoutCreatedDate;
    SHcustomWorkout.customWorkoutEditedDate = customWorkout.customWorkoutEditedDate;
    SHcustomWorkout.customWorkoutExerciseTypes = customWorkout.customWorkoutExerciseTypes;
    SHcustomWorkout.customWorkoutEquipmentNeeded = customWorkout.customWorkoutEquipmentNeeded;
    SHcustomWorkout.customWorkoutLikedDate = customWorkout.customWorkoutLikedDate;
    SHcustomWorkout.customWorkoutShortName = customWorkout.customWorkoutShortName;
    SHcustomWorkout.customWorkoutTargetGender = customWorkout.customWorkoutTargetGender;
    SHcustomWorkout.customWorkoutEstimatedDuration = customWorkout.customWorkoutEstimatedDuration;
    SHcustomWorkout.customWorkoutTimesViewed = customWorkout.customWorkoutTimesViewed;
}

@end
