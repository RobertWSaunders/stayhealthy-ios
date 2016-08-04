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
    [workoutLog setValue:SHworkoutlog.workoutLogIdentifier forKey:@"workoutLogIdentifier"];
    [workoutLog setValue:SHworkoutlog.workoutLogWorkoutRestingTime forKey:@"workoutLogWorkoutRestingTime"];
    [workoutLog setValue:SHworkoutlog.workoutLogWorkoutDuration forKey:@"workoutLogWorkoutDuration"];
    [workoutLog setValue:SHworkoutlog.workoutLogStartDate forKey:@"workoutLogStartDate"];
    [workoutLog setValue:SHworkoutlog.workoutLogEndDate forKey:@"workoutLogEndDate"];
    [workoutLog setValue:SHworkoutlog.workoutLogNotes forKey:@"workoutLogNotes"];
    [workoutLog setValue:SHworkoutlog.workoutLogName forKey:@"workoutLogName"];
    [workoutLog setValue:SHworkoutlog.workoutLogFeeling forKey:@"workoutLogFeeling"];
    [workoutLog setValue:SHworkoutlog.workoutLogExerciseLogIdentifiers forKey:@"workoutLogExerciseLogIdentifiers"];
    [workoutLog setValue:SHworkoutlog.workoutLogDate forKey:@"workoutLogDate"];
}

//Creates SHWorkoutLog Record from WorkoutLog Record
- (void)bind:(WorkoutLog *)workoutLog {
    SHWorkoutLog *SHworkoutlog = self;
    SHworkoutlog.workoutLogIdentifier = workoutLog.workoutLogIdentifier;
    SHworkoutlog.workoutLogWorkoutRestingTime = workoutLog.workoutLogWorkoutRestingTime;
    SHworkoutlog.workoutLogWorkoutDuration = workoutLog.workoutLogWorkoutDuration;
    SHworkoutlog.workoutLogStartDate = workoutLog.workoutLogStartDate;
    SHworkoutlog.workoutLogEndDate = workoutLog.workoutLogEndDate;
    SHworkoutlog.workoutLogNotes = workoutLog.workoutLogNotes;
    SHworkoutlog.workoutLogName = workoutLog.workoutLogName;
    SHworkoutlog.workoutLogFeeling = workoutLog.workoutLogFeeling;
    SHworkoutlog.workoutLogExerciseLogIdentifiers = workoutLog.workoutLogExerciseLogIdentifiers;
    SHworkoutlog.workoutLogDate = workoutLog.workoutLogDate;
}

@end
