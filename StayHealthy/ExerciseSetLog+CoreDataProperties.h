//
//  ExerciseSetLog+CoreDataProperties.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-06-25.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ExerciseSetLog.h"

NS_ASSUME_NONNULL_BEGIN

@interface ExerciseSetLog (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *exerciseSetAverageHeartRate;
@property (nullable, nonatomic, retain) NSNumber *exerciseSetCalories;
@property (nullable, nonatomic, retain) NSNumber *exerciseSetDistance;
@property (nullable, nonatomic, retain) NSNumber *exerciseSetDuration;
@property (nullable, nonatomic, retain) NSNumber *exerciseSetElevation;
@property (nullable, nonatomic, retain) NSNumber *exerciseSetHeight;
@property (nullable, nonatomic, retain) NSString *exerciseSetIdentifier;
@property (nullable, nonatomic, retain) NSString *exerciseSetFeeling;
@property (nullable, nonatomic, retain) NSNumber *exerciseSetJumps;
@property (nullable, nonatomic, retain) NSNumber *exerciseSetLaps;
@property (nullable, nonatomic, retain) NSNumber *exerciseSetPasses;
@property (nullable, nonatomic, retain) NSNumber *exerciseSetPunches;
@property (nullable, nonatomic, retain) NSNumber *exerciseSetReps;
@property (nullable, nonatomic, retain) NSNumber *exerciseSetResistance;
@property (nullable, nonatomic, retain) NSNumber *exerciseSetSpeed;
@property (nullable, nonatomic, retain) NSNumber *exerciseSetSteps;
@property (nullable, nonatomic, retain) NSNumber *exerciseSetWeight;

@end

NS_ASSUME_NONNULL_END
