//
//  SHExerciseSetLog+ExerciseSetLog.m
//  StayHealthy
//
//  Created by Robert Saunders on 2016-06-25.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "SHExerciseSetLog+ExerciseSetLog.h"

@implementation SHExerciseSetLog (ExerciseSetLog)

//Creates ExerciseSetLog Record from SHExerciseSetLog Record
- (void)map:(ExerciseSetLog *)exerciseSetLog {
    SHExerciseSetLog *SHexerciseSetLog = self;
    [exerciseSetLog setValue:SHexerciseSetLog.exerciseSetWeight forKey:@"exerciseSetWeight"];
    [exerciseSetLog setValue:SHexerciseSetLog.exerciseSetSteps forKey:@"exerciseSetSteps"];
    [exerciseSetLog setValue:SHexerciseSetLog.exerciseSetSpeed forKey:@"exerciseSetSpeed"];
    [exerciseSetLog setValue:SHexerciseSetLog.exerciseSetResistance forKey:@"exerciseSetResistance"];
    [exerciseSetLog setValue:SHexerciseSetLog.exerciseSetReps forKey:@"exerciseSetReps"];
    [exerciseSetLog setValue:SHexerciseSetLog.exerciseSetPunches forKey:@"exerciseSetPunches"];
    [exerciseSetLog setValue:SHexerciseSetLog.exerciseSetPasses forKey:@"exerciseSetPasses"];
    [exerciseSetLog setValue:SHexerciseSetLog.exerciseSetLaps forKey:@"exerciseSetLaps"];
    [exerciseSetLog setValue:SHexerciseSetLog.exerciseSetJumps forKey:@"exerciseSetJumps"];
    [exerciseSetLog setValue:SHexerciseSetLog.exerciseSetIdentifier forKey:@"exerciseSetIdentifier"];
    [exerciseSetLog setValue:SHexerciseSetLog.exerciseSetHeight forKey:@"exerciseSetHeight"];
    [exerciseSetLog setValue:SHexerciseSetLog.exerciseSetElevation forKey:@"exerciseSetElevation"];
    [exerciseSetLog setValue:SHexerciseSetLog.exerciseSetDuration forKey:@"exerciseSetDuration"];[exerciseSetLog setValue:SHexerciseSetLog.exerciseSetCalories forKey:@"exerciseSetCalories"];
    [exerciseSetLog setValue:SHexerciseSetLog.exerciseSetAverageHeartRate forKey:@"exerciseSetAverageHeartRate"];
    [exerciseSetLog setValue:SHexerciseSetLog.exerciseSetFeeling forKey:@"exerciseSetFeeling"];
}

//Creates SHExerciseSetLog Record from ExerciseSetLog Record
- (void)bind:(ExerciseSetLog *)exerciseSetLog {
    SHExerciseSetLog *SHexerciseSetLog = self;
    SHexerciseSetLog.exerciseSetWeight = exerciseSetLog.exerciseSetWeight;
     SHexerciseSetLog.exerciseSetSteps = exerciseSetLog.exerciseSetSteps;
     SHexerciseSetLog.exerciseSetSpeed = exerciseSetLog.exerciseSetSpeed;
     SHexerciseSetLog.exerciseSetResistance = exerciseSetLog.exerciseSetResistance;
     SHexerciseSetLog.exerciseSetReps = exerciseSetLog.exerciseSetReps;
     SHexerciseSetLog.exerciseSetPunches = exerciseSetLog.exerciseSetPunches;
     SHexerciseSetLog.exerciseSetPasses = exerciseSetLog.exerciseSetPasses;
     SHexerciseSetLog.exerciseSetLaps = exerciseSetLog.exerciseSetLaps;
     SHexerciseSetLog.exerciseSetJumps = exerciseSetLog.exerciseSetJumps;
     SHexerciseSetLog.exerciseSetIdentifier = exerciseSetLog.exerciseSetIdentifier;
    SHexerciseSetLog.exerciseSetHeight = exerciseSetLog.exerciseSetHeight;
    SHexerciseSetLog.exerciseSetElevation = exerciseSetLog.exerciseSetElevation;
    SHexerciseSetLog.exerciseSetDuration = exerciseSetLog.exerciseSetDuration;
    SHexerciseSetLog.exerciseSetCalories = exerciseSetLog.exerciseSetCalories;
     SHexerciseSetLog.exerciseSetFeeling = exerciseSetLog.exerciseSetFeeling;
    SHexerciseSetLog.exerciseSetAverageHeartRate = exerciseSetLog.exerciseSetAverageHeartRate;

}

@end
