//
//  SHExercise+Exercise.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-15.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "SHExercise.h"
#import "Exercise.h"

@interface SHExercise (Exercise)

- (void)map:(Exercise *)exercise;
- (void)bind:(Exercise *)exercise;

@end
