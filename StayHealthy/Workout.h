//
//  Workout.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Workout : NSManagedObject

//Workout Identifier
@property(nonatomic,retain) NSString *workoutIdentifier;
//Workout Name
@property(nonatomic,retain) NSString *workoutName;
//Workout Summary
@property(nonatomic,retain) NSString *workoutSummary;
//Workout Target Muscles
@property(nonatomic,retain) NSString *workoutTargetMuscles;
//Workout Target Sports
@property(nonatomic,retain) NSString *workoutTargetSports;
//Workout Exercise Identifiers
@property(nonatomic,retain) NSString *workoutExerciseIdentifiers;
//Workout Exercise Types
@property(nonatomic,retain) NSString *workoutExerciseTypes;
//Workout Type
@property(nonatomic,retain) NSString *workoutType;
//Workout Difficulty
@property(nonatomic,retain) NSString *workoutDifficulty;
//Workout Equipment
@property(nonatomic,retain) NSString *workoutEquipment;
//Workout Liked
@property (nonatomic, retain) NSNumber *workoutLiked;
//Workout Last Viewed
@property (nonatomic, retain) NSDate *workoutLastViewed;
//Workout Last Date Completed
@property (nonatomic, retain) NSDate *workoutLastDateCompleted;
//Workout Times Completed
@property (nonatomic, retain) NSNumber *workoutTimesCompleted;


@end
