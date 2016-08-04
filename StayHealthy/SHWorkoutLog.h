//
//  SHWorkoutLog.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-29.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TelerikUI/TelerikUI.h>

@interface SHWorkoutLog : TKCalendarEvent

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
