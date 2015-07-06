//
//  workoutsDataObjects.h
//  StayHealthy
//
//  Created by Student on 3/25/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

//Workout object, each workout is assigned one of these.
@interface workoutObject : NSObject

//Workout Identifier
@property(nonatomic,copy) NSString *workoutIdentifier;
//Workout Name
@property(nonatomic,copy) NSString *workoutName;
//Workout Summary
@property(nonatomic,copy) NSString *workoutSummary;
//Workout Target Muscles
@property(nonatomic,copy) NSString *workoutTargetMuscles;
//Workout TargetSports
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


@end
