//
//  SHWorkout.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHWorkout : NSObject

//Workout Identifier
@property(nonatomic,copy) NSString *workoutIdentifier;
//Workout Name
@property(nonatomic,copy) NSString *workoutName;
//Workout Summary
@property(nonatomic,copy) NSString *workoutSummary;
//Workout Target Muscles
@property(nonatomic,copy) NSString *workoutTargetMuscles;
//Workout Target Sports
@property(nonatomic,copy) NSString *workoutTargetSports;
//Workout Exercise Identifiers
@property(nonatomic,copy) NSString *workoutExerciseIdentifiers;
//Workout Exercise Types
@property(nonatomic,copy) NSString *workoutExerciseTypes;
//Workout Type
@property(nonatomic,copy) NSString *workoutType;
//Workout Difficulty
@property(nonatomic,copy) NSString *workoutDifficulty;
//Workout Equipment
@property(nonatomic,copy) NSString *workoutEquipment;
//Workout Liked
@property (nonatomic, retain) NSNumber *workoutLiked;
//Workout Last Viewed
@property (nonatomic, retain) NSDate *workoutLastViewed;
//Workout Last Date Completed
@property (nonatomic, retain) NSDate *workoutLastDateCompleted;
//Workout Times Completed
@property (nonatomic, retain) NSNumber *workoutTimesCompleted;

@end
