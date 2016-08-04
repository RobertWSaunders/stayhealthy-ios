//
//  SHWorkout.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHWorkout : NSObject

@property (nullable, nonatomic, retain) NSString *workoutDifficulty;
@property (nullable, nonatomic, retain) NSDate *workoutEditedDate;
@property (nullable, nonatomic, retain) NSString *workoutEquipmentNeeded;
@property (nullable, nonatomic, retain) NSNumber *workoutEstimatedDuration;
@property (nullable, nonatomic, retain) NSString *workoutExerciseIdentifiers;
@property (nullable, nonatomic, retain) NSString *workoutExerciseTypes;
@property (nullable, nonatomic, retain) NSString *workoutIdentifier;
@property (nullable, nonatomic, retain) NSNumber *workoutIsEdited;
@property (nullable, nonatomic, retain) NSDate *workoutLastDateCompleted;
@property (nullable, nonatomic, retain) NSDate *workoutLastViewed;
@property (nullable, nonatomic, retain) NSNumber *workoutLiked;
@property (nullable, nonatomic, retain) NSDate *workoutLikedDate;
@property (nullable, nonatomic, retain) NSString *workoutName;
@property (nullable, nonatomic, retain) NSString *workoutShortName;
@property (nullable, nonatomic, retain) NSString *workoutSummary;
@property (nullable, nonatomic, retain) NSString *workoutTargetGender;
@property (nullable, nonatomic, retain) NSString *workoutTargetMuscles;
@property (nullable, nonatomic, retain) NSString *workoutTargetSports;
@property (nullable, nonatomic, retain) NSNumber *workoutTimesCompleted;
@property (nullable, nonatomic, retain) NSNumber *workoutTimesViewed;
@property (nullable, nonatomic, retain) NSString *workoutType;

@end
