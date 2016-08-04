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
    [exerciseLog setValue:SHexerciselog.exerciseLogNotes forKey:@"exerciseLogNotes"];
    [exerciseLog setValue:SHexerciselog.exerciseLogIdentifier forKey:@"exerciseLogIdentifier"];
    [exerciseLog setValue:SHexerciselog.exerciseLogExerciseType forKey:@"exerciseLogExerciseType"];
    [exerciseLog setValue:SHexerciselog.exerciseLogExerciseSetsIdentifiers forKey:@"exerciseLogExerciseSetsIdentifiers"];
    [exerciseLog setValue:SHexerciselog.exerciseLogExerciseIdentifier forKey:@"exerciseLogExerciseIdentifier"];
    [exerciseLog setValue:SHexerciselog.exerciseLogDate forKey:@"exerciseLogDate"];
    [exerciseLog setValue:SHexerciselog.exerciseLogFeeling forKey:@"exerciseLogFeeling"];
}

//Creates SHExerciseLog Record from ExerciseLog Record
- (void)bind:(ExerciseLog *)exerciseLog {
    SHExerciseLog *SHexerciselog = self;
    SHexerciselog.exerciseLogNotes = exerciseLog.exerciseLogNotes;
    SHexerciselog.exerciseLogExerciseType = exerciseLog.exerciseLogExerciseType;
    SHexerciselog.exerciseLogIdentifier = exerciseLog.exerciseLogIdentifier;
    SHexerciselog.exerciseLogExerciseSetsIdentifiers = exerciseLog.exerciseLogExerciseSetsIdentifiers;
    SHexerciselog.exerciseLogExerciseIdentifier = exerciseLog.exerciseLogExerciseIdentifier;
    SHexerciselog.exerciseLogDate = exerciseLog.exerciseLogDate;
    SHexerciselog.exerciseLogFeeling = exerciseLog.exerciseLogFeeling;
}


@end
