//
//  SHWorkout+Workout.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import "SHWorkout.h"
#import "Workout.h"

@interface SHWorkout (Workout)

- (void)map:(Workout *)workout;
- (void)bind:(Workout *)workout;

@end
