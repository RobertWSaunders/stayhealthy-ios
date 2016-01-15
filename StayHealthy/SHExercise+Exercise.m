//
//  SHExercise+Exercise.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-15.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "SHExercise+Exercise.h"

@implementation SHExercise (Exercise)

//Creates Exercise Record from SHExercise Record
- (void)map:(Exercise *)exercise {
    SHExercise *SHexercise = self;
    [exercise setValue:SHexercise.exerciseIdentifier forKey:@"exerciseID"];
    [exercise setValue:SHexercise.liked forKey:@"liked"];
    [exercise setValue:SHexercise.lastViewed forKey:@"lastViewed"];
    [exercise setValue:SHexercise.exerciseType forKey:@"exerciseType"];
    [exercise setValue:SHexercise.timesViewed forKey:@"timesViewed"];
}

//Creates SHExercise Record from Exercise Record
- (void)bind:(Exercise *)exercise {
    SHExercise *SHexercise = self;
    SHexercise.exerciseIdentifier = exercise.exerciseID;
    SHexercise.liked = exercise.liked;
    SHexercise.lastViewed = exercise.lastViewed;
    SHexercise.exerciseType = exercise.exerciseType;
    SHexercise.timesViewed = exercise.timesViewed;
}

@end
