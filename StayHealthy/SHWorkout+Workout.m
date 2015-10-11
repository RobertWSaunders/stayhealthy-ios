//
//  SHWorkout+Workout.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import "SHWorkout+Workout.h"

@implementation SHWorkout (Workout)

- (void)map:(Workout *)workout {
    SHWorkout *SHworkout = self;
    [workout setValue:SHworkout.workoutIdentifier forKey:@"workoutID"];
    [workout setValue:SHworkout.liked forKey:@"liked"];
    [workout setValue:SHworkout.lastViewed forKey:@"lastViewed"];
    [workout setValue:SHworkout.lastDateCompleted forKey:@"lastDateCompleted"];
    [workout setValue:SHworkout.timesCompleted forKey:@"timesCompleted"];
}

- (void)bind:(Workout *)workout {
    SHWorkout *SHworkout = self;
    SHworkout.workoutIdentifier = workout.workoutID;
    SHworkout.liked = workout.liked;
    SHworkout.lastDateCompleted = workout.lastDateCompleted;
    SHworkout.lastViewed = workout.lastViewed;
    SHworkout.timesCompleted = workout.timesCompleted;
}



@end
