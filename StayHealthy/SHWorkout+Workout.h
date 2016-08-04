//
//  SHWorkout+Workout.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "SHWorkout.h"
#import "Workout.h"

@interface SHWorkout (Workout)

//Creates Workout Record from SHWorkout Record
- (void)map:(Workout *)workout;

//Creates SHWorkout Record from Workout Record
- (void)bind:(Workout *)workout;


@end
