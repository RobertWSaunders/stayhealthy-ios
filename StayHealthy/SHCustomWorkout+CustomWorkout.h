//
//  SHCustomWorkout+CustomWorkout.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "SHCustomWorkout.h"
#import "CustomWorkout.h"

@interface SHCustomWorkout (CustomWorkout)

//Creates Custom Workout Record from SHCustomWorkout Record
- (void)map:(CustomWorkout *)customWorkout;

//Creates SHCustomWorkout Record from Custom Workout Record
- (void)bind:(CustomWorkout *)customWorkout;

@end
