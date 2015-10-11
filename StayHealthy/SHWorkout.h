//
//  SHWorkout.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHWorkout : NSObject

//Exercise Identifier
@property(nonatomic,copy) NSString *workoutIdentifier;
//Exercise Name
@property(nonatomic,copy) NSString *workoutName;
//Exercise Muscle
@property(nonatomic,copy) NSString *workoutSummary;
//Exercise Instructions
@property(nonatomic,copy) NSString *workoutTargetMuscles;

@property(nonatomic,copy) NSString *workoutTargetSports;
//Exercise ImageFile
@property(nonatomic,copy) NSString *workoutExerciseIdentifiers;
//Exercise Sets
@property(nonatomic,copy) NSString *workoutExerciseTypes;
//Exercise Reps
@property(nonatomic,copy) NSString *workoutType;
//Exercise Equipment
@property(nonatomic,copy) NSString *workoutDifficulty;
//Exercise Primary Muscle
@property(nonatomic,copy) NSString *workoutEquipment;


@property (nonatomic, retain) NSNumber *liked;

@property (nonatomic, retain) NSDate *lastViewed;

@property (nonatomic, retain) NSDate *lastDateCompleted;

@property (nonatomic, retain) NSNumber *timesCompleted;



@end
