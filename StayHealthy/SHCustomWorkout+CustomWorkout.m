//
//  SHCustomWorkout+CustomWorkout.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import "SHCustomWorkout+CustomWorkout.h"

@implementation SHCustomWorkout (CustomWorkout)

- (void)map:(CustomWorkout *)customWorkout {
    SHCustomWorkout *SHcustomWorkout = self;
    [customWorkout setValue:SHcustomWorkout.workoutID forKey:@"workoutID"];
    [customWorkout setValue:SHcustomWorkout.workoutName forKey:@"workoutName"];
    [customWorkout setValue:SHcustomWorkout.workoutSummary forKey:@"workoutSummary"];
    [customWorkout setValue:SHcustomWorkout.workoutTargetMuscles forKey:@"workoutTargetMuscles"];
    [customWorkout setValue:SHcustomWorkout.workoutTargetSports forKey:@"workoutTargetSports"];
    [customWorkout setValue:SHcustomWorkout.workoutType forKey:@"workoutType"];
    [customWorkout setValue:SHcustomWorkout.workoutDifficulty forKey:@"workoutDifficulty"];
    [customWorkout setValue:SHcustomWorkout.exerciseTypes forKey:@"exerciseTypes"];
    [customWorkout setValue:SHcustomWorkout.workoutExerciseIDs forKey:@"workoutExerciseIDs"];
    [customWorkout setValue:SHcustomWorkout.liked forKey:@"liked"];
    [customWorkout setValue:SHcustomWorkout.timesCompleted forKey:@"timesCompleted"];
    [customWorkout setValue:SHcustomWorkout.lastViewed forKey:@"lastViewed"];
    [customWorkout setValue:SHcustomWorkout.lastDateCompleted forKey:@"lastDateCompleted"];
    [customWorkout setValue:SHcustomWorkout.dateModified forKey:@"dateModified"];
    [customWorkout setValue:SHcustomWorkout.dateCreated forKey:@"dateCreated"];
}


- (void)bind:(CustomWorkout *)customWorkout {
    SHCustomWorkout *SHcustomWorkout = self;
    SHcustomWorkout.workoutID = customWorkout.workoutID;
    SHcustomWorkout.liked = customWorkout.liked;
    SHcustomWorkout.lastDateCompleted = customWorkout.lastDateCompleted;
    SHcustomWorkout.lastViewed = customWorkout.lastViewed;
    SHcustomWorkout.timesCompleted = customWorkout.timesCompleted;
    SHcustomWorkout.workoutName = customWorkout.workoutName;
    SHcustomWorkout.workoutSummary = customWorkout.workoutSummary;
    SHcustomWorkout.workoutTargetMuscles = customWorkout.workoutTargetMuscles;
    SHcustomWorkout.workoutTargetSports = customWorkout.workoutTargetSports;
    SHcustomWorkout.workoutExerciseIDs = customWorkout.workoutExerciseIDs;
    SHcustomWorkout.workoutDifficulty = customWorkout.workoutDifficulty;
    SHcustomWorkout.workoutType = customWorkout.workoutType;
    SHcustomWorkout.dateCreated = customWorkout.dateCreated;
    SHcustomWorkout.dateModified = customWorkout.dateModified;
    SHcustomWorkout.exerciseTypes = customWorkout.exerciseTypes;
}

@end
