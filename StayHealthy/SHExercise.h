//
//  SHExercise.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-15.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHExercise : NSObject

//Exercise Identifier
@property(nonatomic,copy) NSString *exerciseIdentifier;
//Exercise Name
@property(nonatomic,copy) NSString *exerciseName;
//Exercise Muscle
@property(nonatomic,copy) NSString *exerciseMuscle;
//Exercise Instructions
@property(nonatomic,copy) NSString *exerciseInstructions;
//Exercise ImageFile
@property(nonatomic,copy) NSString *exerciseImageFile;
//Exercise Sets
@property(nonatomic,copy) NSString *exerciseSets;
//Exercise Reps
@property(nonatomic,copy) NSString *exerciseReps;
//Exercise Equipment
@property(nonatomic,copy) NSString *exerciseEquipment;
//Exercise Primary Muscle
@property(nonatomic,copy) NSString *exercisePrimaryMuscle;
//Exercise SecondaryMuscle
@property(nonatomic,copy) NSString *exerciseSecondaryMuscle;
//Exercise Difficulty
@property(nonatomic,copy) NSString *exerciseDifficulty;
//Exercise Type
@property(nonatomic,copy) NSString *exerciseType;

@property (nonatomic, retain) NSNumber * liked;

@property (nonatomic, retain) NSDate * lastViewed;

@end
