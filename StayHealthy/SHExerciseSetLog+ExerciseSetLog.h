//
//  SHExerciseSetLog+ExerciseSetLog.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-06-25.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "SHExerciseSetLog.h"
#import "ExerciseSetLog.h"

@interface SHExerciseSetLog (ExerciseSetLog)

//Creates ExerciseSetLog Record from SHExerciseSetLog Record
- (void)map:(ExerciseSetLog *)exerciseSetLog;

//Creates SHExerciseSetLog Record from ExerciseSetLog Record
- (void)bind:(ExerciseSetLog *)exerciseSetLog;

@end
