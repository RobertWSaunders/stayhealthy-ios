//
//  SHWorkout+Workout.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "SHWorkout+Workout.h"

@implementation SHWorkout (Workout)

//Creates Workout Record from SHWorkout Record
- (void)map:(Workout *)workout {
    SHWorkout *SHworkout = self;
    [workout setValue:SHworkout.workoutIdentifier forKey:@"workoutIdentifier"];
    [workout setValue:SHworkout.workoutDifficulty forKey:@"workoutDifficulty"];
    [workout setValue:SHworkout.workoutEquipment forKey:@"workoutEquipment"];
    [workout setValue:SHworkout.workoutExerciseIdentifiers forKey:@"workoutExerciseIdentifiers"];
    [workout setValue:SHworkout.workoutExerciseTypes forKey:@"workoutExerciseTypes"];
    [workout setValue:SHworkout.workoutLastDateCompleted forKey:@"workoutLastDateCompleted"];
    [workout setValue:SHworkout.workoutLastViewed forKey:@"workoutLastViewed"];
    [workout setValue:SHworkout.workoutLiked forKey:@"workoutLiked"];
    [workout setValue:SHworkout.workoutName forKey:@"workoutName"];
    [workout setValue:SHworkout.workoutSummary forKey:@"workoutSummary"];
    [workout setValue:SHworkout.workoutTargetMuscles forKey:@"workoutTargetMuscles"];
    [workout setValue:SHworkout.workoutTargetSports forKey:@"workoutTargetSports"];
    [workout setValue:SHworkout.workoutTimesCompleted forKey:@"workoutTimesCompleted"];
    [workout setValue:SHworkout.workoutType forKey:@"workoutType"];
}

//Creates SHWorkout Record from Workout Record
- (void)bind:(Workout *)workout {
    SHWorkout *SHworkout = self;
    SHworkout.workoutIdentifier = workout.workoutIdentifier;
    SHworkout.workoutDifficulty = workout.workoutDifficulty;
    SHworkout.workoutEquipment = workout.workoutEquipment;
    SHworkout.workoutExerciseIdentifiers = workout.workoutExerciseIdentifiers;
    SHworkout.workoutExerciseTypes = workout.workoutExerciseTypes;
    SHworkout.workoutLastDateCompleted = workout.workoutLastDateCompleted;
    SHworkout.workoutLastViewed = workout.workoutLastViewed;
    SHworkout.workoutLiked = workout.workoutLiked;
    SHworkout.workoutName = workout.workoutName;
    SHworkout.workoutSummary = workout.workoutSummary;
    SHworkout.workoutTargetMuscles = workout.workoutTargetMuscles;
    SHworkout.workoutTargetSports = workout.workoutTargetSports;
    SHworkout.workoutTimesCompleted = workout.workoutTimesCompleted;
    SHworkout.workoutType = workout.workoutType;
}

//Updates a SHWorkout with the users data.
- (void)userDataBind:(Workout *)workout {
    
}

@end
