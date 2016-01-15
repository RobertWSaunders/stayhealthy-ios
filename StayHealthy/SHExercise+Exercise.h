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

//Creates Exercise Record from SHExercise Record
- (void)map:(Exercise *)exercise;

//Creates SHExercise Record from Exercise Record
- (void)bind:(Exercise *)exercise;

@end
