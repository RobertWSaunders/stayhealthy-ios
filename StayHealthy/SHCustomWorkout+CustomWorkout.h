//
//  SHCustomWorkout+CustomWorkout.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import "SHCustomWorkout.h"
#import "CustomWorkout.h"

@interface SHCustomWorkout (CustomWorkout)

- (void)map:(CustomWorkout *)customWorkout;
- (void)bind:(CustomWorkout *)customWorkout;

@end
