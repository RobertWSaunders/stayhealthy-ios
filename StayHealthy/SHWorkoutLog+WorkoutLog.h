//
//  SHWorkoutLog+WorkoutLog.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-29.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "SHWorkoutLog.h"
#import "WorkoutLog.h"

@interface SHWorkoutLog (WorkoutLog)

//Creates WorkoutLog Record from SHWorkoutLog Record
- (void)map:(WorkoutLog *)workoutLog;

//Creates SHWorkoutLog Record from WorkoutLog Record
- (void)bind:(WorkoutLog *)workoutLog;


@end
