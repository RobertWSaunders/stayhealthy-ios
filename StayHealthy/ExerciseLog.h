//
//  ExerciseLog.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-29.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface ExerciseLog : NSManagedObject

@property (nullable, nonatomic, retain) NSDate *logDate;
@property (nullable, nonatomic, retain) NSNumber *logExerciseWeight;
@property (nullable, nonatomic, retain) NSNumber *logExerciseSets;
@property (nullable, nonatomic, retain) NSNumber *logExerciseReps;
@property (nullable, nonatomic, retain) NSString *logExerciseNotes;
@property (nullable, nonatomic, retain) NSString *logExerciseFeeling;
@property (nullable, nonatomic, retain) NSString *logExerciseIdentifier;
@property (nullable, nonatomic, retain) NSString *logExerciseType;
@property (nullable, nonatomic, retain) NSString *logIdentifier;

@end

