//
//  SHCustomExercise.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-19.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHCustomExercise : NSObject

@property (nullable, nonatomic, retain) NSDate *customExerciseCreatedDate;
@property (nullable, nonatomic, retain) NSString *customExerciseDifferentVariationsIdentifiers;
@property (nullable, nonatomic, retain) NSString *customExerciseDifficulty;
@property (nullable, nonatomic, retain) NSDate *customExerciseEditedDate;
@property (nullable, nonatomic, retain) NSString *customExerciseEquipmentNeeded;
@property (nullable, nonatomic, retain) NSString *customExerciseForceType;
@property (nullable, nonatomic, retain) NSString *customExerciseIdentifier;
@property (nullable, nonatomic, retain) NSString *customExerciseImageFile;
@property (nullable, nonatomic, retain) NSString *customExerciseInstructions;
@property (nullable, nonatomic, retain) NSDate *customExerciseLastViewed;
@property (nullable, nonatomic, retain) NSNumber *customExerciseLiked;
@property (nullable, nonatomic, retain) NSDate *customExerciseLikedDate;
@property (nullable, nonatomic, retain) NSString *customExerciseMechanicsType;
@property (nullable, nonatomic, retain) NSString *customExerciseName;
@property (nullable, nonatomic, retain) NSString *customExercisePrimaryMuscle;
@property (nullable, nonatomic, retain) NSString *customExerciseRecommendedReps;
@property (nullable, nonatomic, retain) NSString *customExerciseRecommendedSets;
@property (nullable, nonatomic, retain) NSString *customExerciseSecondaryMuscle;
@property (nullable, nonatomic, retain) NSString *customExerciseShortName;
@property (nullable, nonatomic, retain) NSNumber *customExerciseTimesViewed;
@property (nullable, nonatomic, retain) NSString *customExerciseType;

@end
