//
//  WorkoutLog+CoreDataProperties.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-06-25.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "WorkoutLog.h"

NS_ASSUME_NONNULL_BEGIN

@interface WorkoutLog (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *workoutLogDate;
@property (nullable, nonatomic, retain) NSDate *workoutLogEndDate;
@property (nullable, nonatomic, retain) NSString *workoutLogExerciseLogIdentifiers;
@property (nullable, nonatomic, retain) NSString *workoutLogFeeling;
@property (nullable, nonatomic, retain) NSString *workoutLogIdentifier;
@property (nullable, nonatomic, retain) NSString *workoutLogName;
@property (nullable, nonatomic, retain) NSString *workoutLogNotes;
@property (nullable, nonatomic, retain) NSDate *workoutLogStartDate;
@property (nullable, nonatomic, retain) NSNumber *workoutLogWorkoutDuration;
@property (nullable, nonatomic, retain) NSNumber *workoutLogWorkoutRestingTime;

@end

NS_ASSUME_NONNULL_END
