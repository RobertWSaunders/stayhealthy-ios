//
//  CustomWorkout.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CustomWorkout : NSManagedObject

@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSDate * dateModified;
@property (nonatomic, retain) NSNumber * lastDateCompleted;
@property (nonatomic, retain) NSDate * lastViewed;
@property (nonatomic, retain) NSNumber * liked;
@property (nonatomic, retain) NSNumber * timesCompleted;
@property (nonatomic, retain) NSString * workoutDifficulty;
@property (nonatomic, retain) NSString * workoutExerciseIDs;
@property (nonatomic, retain) NSString * workoutID;
@property (nonatomic, retain) NSString * workoutName;
@property (nonatomic, retain) NSString * workoutSummary;
@property (nonatomic, retain) NSString * workoutTargetMuscles;
@property (nonatomic, retain) NSString * workoutTargetSports;
@property (nonatomic, retain) NSString * workoutType;
@property (nonatomic, retain) NSString * exerciseTypes;
@property (nonatomic, retain) NSString * workoutEquipment;


@end
