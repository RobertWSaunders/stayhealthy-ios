//
//  SHCustomWorkout.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHCustomWorkout : NSObject

@property (nullable, nonatomic, retain) NSDate *customWorkoutCreatedDate;
@property (nullable, nonatomic, retain) NSString *customWorkoutDifficulty;
@property (nullable, nonatomic, retain) NSDate *customWorkoutEditedDate;
@property (nullable, nonatomic, retain) NSString *customWorkoutEquipmentNeeded;
@property (nullable, nonatomic, retain) NSNumber *customWorkoutEstimatedDuration;
@property (nullable, nonatomic, retain) NSString *customWorkoutExerciseIdentifiers;
@property (nullable, nonatomic, retain) NSString *customWorkoutExerciseTypes;
@property (nullable, nonatomic, retain) NSString *customWorkoutIdentifier;
@property (nullable, nonatomic, retain) NSDate *customWorkoutLastDateCompleted;
@property (nullable, nonatomic, retain) NSDate *customWorkoutLastViewed;
@property (nullable, nonatomic, retain) NSDate *customWorkoutLikedDate;
@property (nullable, nonatomic, retain) NSNumber *customWorkoutLiked;
@property (nullable, nonatomic, retain) NSString *customWorkoutName;
@property (nullable, nonatomic, retain) NSString *customWorkoutShortName;
@property (nullable, nonatomic, retain) NSString *customWorkoutSummary;
@property (nullable, nonatomic, retain) NSString *customWorkoutTargetGender;
@property (nullable, nonatomic, retain) NSString *customWorkoutTargetMuscles;
@property (nullable, nonatomic, retain) NSString *customWorkoutTargetSports;
@property (nullable, nonatomic, retain) NSNumber *customWorkoutTimesCompleted;
@property (nullable, nonatomic, retain) NSNumber *customWorkoutTimesViewed;
@property (nullable, nonatomic, retain) NSString *customWorkoutType;

@end
