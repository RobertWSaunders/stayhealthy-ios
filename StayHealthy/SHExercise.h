//
//  SHExercise.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-15.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHExercise : NSObject

@property (nullable, nonatomic, retain) NSString *exerciseDifferentVariationsExerciseIdentifiers;
@property (nullable, nonatomic, retain) NSString *exerciseDifficulty;
@property (nullable, nonatomic, retain) NSDate *exerciseEditedDate;
@property (nullable, nonatomic, retain) NSString *exerciseEquipmentNeeded;
@property (nullable, nonatomic, retain) NSString *exerciseForceType;
@property (nullable, nonatomic, retain) NSString *exerciseIdentifier;
@property (nullable, nonatomic, retain) NSString *exerciseImageFile;
@property (nullable, nonatomic, retain) NSString *exerciseInstructions;
@property (nullable, nonatomic, retain) NSNumber *exerciseIsEdited;
@property (nullable, nonatomic, retain) NSDate *exerciseLastViewed;
@property (nullable, nonatomic, retain) NSNumber *exerciseLiked;
@property (nullable, nonatomic, retain) NSDate *exerciseLikedDate;
@property (nullable, nonatomic, retain) NSString *exerciseMechanicsType;
@property (nullable, nonatomic, retain) NSString *exerciseName;
@property (nullable, nonatomic, retain) NSString *exercisePrimaryMuscle;
@property (nullable, nonatomic, retain) NSString *exerciseRecommendedReps;
@property (nullable, nonatomic, retain) NSString *exerciseRecommendedSets;
@property (nullable, nonatomic, retain) NSString *exerciseSecondaryMuscle;
@property (nullable, nonatomic, retain) NSString *exerciseShortName;
@property (nullable, nonatomic, retain) NSNumber *exerciseTimesViewed;
@property (nullable, nonatomic, retain) NSString *exerciseType;


@end
