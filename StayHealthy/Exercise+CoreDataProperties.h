//
//  Exercise+CoreDataProperties.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-06-25.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Exercise.h"

NS_ASSUME_NONNULL_BEGIN

@interface Exercise (CoreDataProperties)

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

NS_ASSUME_NONNULL_END
