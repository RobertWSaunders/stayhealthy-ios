//
//  SHExerciseLog.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-29.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHExerciseLog : NSObject

//Log Exercise Identifier
@property(nonatomic,copy) NSString *logExerciseIdentifier;
//Log Exercise Type
@property(nonatomic,copy) NSString *logExerciseType;
//Log Identifier
@property(nonatomic,copy) NSString *logIdentifier;
//Log Exercise Feeling
@property(nonatomic,copy) NSString *logExerciseFeeling;
//Log Exercise Notes
@property(nonatomic,copy) NSString *logExerciseNotes;
//Log Exercise Reps
@property (nonatomic, retain) NSNumber *logExerciseReps;
//Log Exercise Sets
@property (nonatomic, retain) NSNumber *logExerciseSets;
//Log Exercise Weight
@property (nonatomic, retain) NSNumber *logExerciseWeight;
//Log Date
@property (nonatomic, retain) NSDate *logDate;

@end
