//
//  CustomExercise+CoreDataProperties.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-06-25.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "CustomExercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomExercise (CoreDataProperties)

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

NS_ASSUME_NONNULL_END
