//
//  SHCustomExercise.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-19.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHCustomExercise : NSObject

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
//Exercise Created Date
@property (nonatomic, retain) NSDate *exerciseDateCreated;
//Exercise Modified Date
@property (nonatomic, retain) NSDate *exerciseDateModified;
//Exercise Times Viewed
@property (nonatomic, retain) NSNumber *exerciseTimesViewed;

@end
