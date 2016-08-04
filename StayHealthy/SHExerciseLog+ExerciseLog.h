//
//  SHExerciseLog+ExerciseLog.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-29.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "SHExerciseLog.h"
#import "ExerciseLog.h"

@interface SHExerciseLog (ExerciseLog)

//Creates ExerciseLog Record from SHExerciseLog Record
- (void)map:(ExerciseLog *)exerciseLog;

//Creates SHExerciseLog Record from ExerciseLog Record
- (void)bind:(ExerciseLog *)exerciseLog;

@end
