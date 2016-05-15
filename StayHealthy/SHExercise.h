//
//  SHExercise.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-15.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHExercise : NSObject

//Exercise Identifier
@property(nonatomic,copy) NSString *exerciseIdentifier;
//Exercise Name
@property(nonatomic,copy) NSString *exerciseName;
//Exercise Short Name
@property(nonatomic,copy) NSString *exerciseShortName;
//Exercise Instructions
@property(nonatomic,copy) NSString *exerciseInstructions;
//Exercise Image File
@property(nonatomic,copy) NSString *exerciseImageFile;
//Exercise Sets
@property(nonatomic,copy) NSString *exerciseSets;
//Exercise Reps
@property(nonatomic,copy) NSString *exerciseReps;
//Exercise Weight
@property(nonatomic,copy) NSString *exerciseWeight;
//Exercise Equipment
@property(nonatomic,copy) NSString *exerciseEquipment;
//Exercise Primary Muscle
@property(nonatomic,copy) NSString *exercisePrimaryMuscle;
//Exercise Secondary Muscle
@property(nonatomic,copy) NSString *exerciseSecondaryMuscle;
//Exercise Difficulty
@property(nonatomic,copy) NSString *exerciseDifficulty;
//Exercise Type
@property(nonatomic,copy) NSString *exerciseType;
//Exercise Mechanics Type
@property(nonatomic,copy) NSString *exerciseMechanicsType;
//Exercise Force Type
@property(nonatomic,copy) NSString *exerciseForceType;
//Exercise Different Variations Exercise Identifiers
@property(nonatomic,copy) NSString *exerciseDifferentVariationsExerciseIdentifiers;
//USER DATA
//Exercise Liked
@property (nonatomic, retain) NSNumber *exerciseLiked;
//Exercise Last Viewed
@property (nonatomic, retain) NSDate *exerciseLastViewed;
//Exercise Edited Date
@property (nonatomic, retain) NSDate *exerciseEditedDate;
//Exercise Liked Date
@property (nonatomic, retain) NSDate *exerciseLikedDate;
//Exercise Times Viewed
@property (nonatomic, retain) NSNumber *exerciseTimesViewed;
//Exercise Is Edited
@property (nonatomic, retain) NSNumber *exerciseIsEdited;

@end
