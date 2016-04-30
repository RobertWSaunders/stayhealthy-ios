//
//  SHExerciseLog+ExerciseLog.m
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-29.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "SHExerciseLog+ExerciseLog.h"

@implementation SHExerciseLog (ExerciseLog)

//Creates ExerciseLog Record from SHExerciseLog Record
- (void)map:(ExerciseLog *)exerciseLog {
    SHExerciseLog *SHexerciselog = self;
    [exerciseLog setValue:SHexerciselog.logExerciseIdentifier forKey:@"logExerciseIdentifier"];
    [exerciseLog setValue:SHexerciselog.logExerciseType forKey:@"logExerciseType"];
    [exerciseLog setValue:SHexerciselog.logIdentifier forKey:@"logIdentifier"];
    [exerciseLog setValue:SHexerciselog.logExerciseFeeling forKey:@"logExerciseFeeling"];
    [exerciseLog setValue:SHexerciselog.logExerciseNotes forKey:@"logExerciseNotes"];
    [exerciseLog setValue:SHexerciselog.logExerciseReps forKey:@"logExerciseReps"];
    [exerciseLog setValue:SHexerciselog.logExerciseSets forKey:@"logExerciseSets"];
    [exerciseLog setValue:SHexerciselog.logExerciseWeight forKey:@"logExerciseWeight"];
    [exerciseLog setValue:SHexerciselog.logDate forKey:@"logDate"];
}

//Creates SHExerciseLog Record from ExerciseLog Record
- (void)bind:(ExerciseLog *)exerciseLog {
    SHExerciseLog *SHexerciselog = self;
    SHexerciselog.logExerciseIdentifier = exerciseLog.logExerciseIdentifier;
    SHexerciselog.logExerciseType = exerciseLog.logExerciseType;
    SHexerciselog.logIdentifier = exerciseLog.logIdentifier;
    SHexerciselog.logExerciseFeeling = exerciseLog.logExerciseFeeling;
    SHexerciselog.logExerciseNotes = exerciseLog.logExerciseNotes;
    SHexerciselog.logExerciseReps = exerciseLog.logExerciseReps;
    SHexerciselog.logExerciseSets = exerciseLog.logExerciseSets;
    SHexerciselog.logExerciseWeight = exerciseLog.logExerciseWeight;
    SHexerciselog.logDate = exerciseLog.logDate;
}


@end
