//
//  SHWorkoutLog+WorkoutLog.m
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-29.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "SHWorkoutLog+WorkoutLog.h"

@implementation SHWorkoutLog (WorkoutLog)

//Creates WorkoutLog Record from SHWorkoutLog Record
- (void)map:(WorkoutLog *)workoutLog {
    SHWorkoutLog *SHworkoutlog = self;
    [workoutLog setValue:SHworkoutlog.logWorkoutIdentifier forKey:@"logWorkoutIdentifier"];
    [workoutLog setValue:SHworkoutlog.logWorkoutExerciseLogIdentifiers forKey:@"logWorkoutExerciseLogIdentifiers"];
    [workoutLog setValue:SHworkoutlog.logIdentifier forKey:@"logIdentifier"];
    [workoutLog setValue:SHworkoutlog.logWorkoutExerciseTypes forKey:@"logWorkoutExerciseTypes"];
    [workoutLog setValue:SHworkoutlog.logWorkoutNotes forKey:@"logWorkoutNotes"];
    [workoutLog setValue:SHworkoutlog.logWorkoutFeeling forKey:@"logWorkoutFeeling"];
    [workoutLog setValue:SHworkoutlog.logDate forKey:@"logDate"];
    [workoutLog setValue:SHworkoutlog.logWorkoutStartDate forKey:@"logWorkoutStartDate"];
    [workoutLog setValue:SHworkoutlog.logWorkoutEndDate forKey:@"logWorkoutEndDate"];
    
}

//Creates SHWorkoutLog Record from WorkoutLog Record
- (void)bind:(WorkoutLog *)workoutLog {
    SHWorkoutLog *SHworkoutlog = self;
    SHworkoutlog.logWorkoutIdentifier = workoutLog.logWorkoutIdentifier;
    SHworkoutlog.logWorkoutExerciseLogIdentifiers = workoutLog.logWorkoutExerciseLogIdentifiers;
    SHworkoutlog.logIdentifier = workoutLog.logIdentifier;
    SHworkoutlog.logWorkoutExerciseTypes = workoutLog.logWorkoutExerciseTypes;
    SHworkoutlog.logWorkoutNotes = workoutLog.logWorkoutNotes;
    SHworkoutlog.logWorkoutFeeling = workoutLog.logWorkoutFeeling;
    SHworkoutlog.logDate = workoutLog.logDate;
    SHworkoutlog.logWorkoutStartDate = workoutLog.logWorkoutStartDate;
     SHworkoutlog.logWorkoutEndDate = workoutLog.logWorkoutEndDate;
}

@end
