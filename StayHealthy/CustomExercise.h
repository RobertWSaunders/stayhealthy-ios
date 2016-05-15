//
//  CustomExercise.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-29.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CustomExercise : NSManagedObject

@property (nullable, nonatomic, retain) NSString *exerciseType;
@property (nullable, nonatomic, retain) NSNumber *exerciseTimesViewed;
@property (nullable, nonatomic, retain) NSString *exerciseShortName;
@property (nullable, nonatomic, retain) NSString *exerciseSets;
@property (nullable, nonatomic, retain) NSString *exerciseSecondaryMuscle;
@property (nullable, nonatomic, retain) NSString *exerciseReps;
@property (nullable, nonatomic, retain) NSString *exerciseWeight;
@property (nullable, nonatomic, retain) NSString *exercisePrimaryMuscle;
@property (nullable, nonatomic, retain) NSString *exerciseName;
@property (nullable, nonatomic, retain) NSString *exerciseMechanicsType;
@property (nullable, nonatomic, retain) NSNumber *exerciseLiked;
@property (nullable, nonatomic, retain) NSDate *exerciseLastViewed;
@property (nullable, nonatomic, retain) NSString *exerciseInstructions;
@property (nullable, nonatomic, retain) NSString *exerciseImageFile;
@property (nullable, nonatomic, retain) NSString *exerciseIdentifier;
@property (nullable, nonatomic, retain) NSString *exerciseForceType;
@property (nullable, nonatomic, retain) NSString *exerciseEquipment;
@property (nullable, nonatomic, retain) NSString *exerciseDifficulty;
@property (nullable, nonatomic, retain) NSString *exerciseDifferentVariationsExerciseIdentifiers;
@property (nullable, nonatomic, retain) NSDate *exerciseDateCreated;
@property (nullable, nonatomic, retain) NSDate *exerciseDateModified;

@end

