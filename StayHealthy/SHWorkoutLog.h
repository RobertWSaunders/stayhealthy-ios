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

//Log Workout Identifier
@property(nonatomic,copy) NSString *logWorkoutIdentifier;
//Log Workout Exercise Identifier
@property(nonatomic,copy) NSString *logWorkoutExerciseLogIdentifiers;
//Log Identifier
@property(nonatomic,copy) NSString *logIdentifier;
//Log Workout Feeling
@property(nonatomic,copy) NSString *logWorkoutExerciseTypes;
//Log Workout Notes
@property(nonatomic,copy) NSString *logWorkoutNotes;
//Log Workout Feeling
@property(nonatomic,copy) NSString *logWorkoutFeeling;
//Log Date
@property (nonatomic, retain) NSDate *logDate;
//Log Start Date
@property (nonatomic, retain) NSDate *logWorkoutStartDate;
//Log End Date
@property (nonatomic, retain) NSDate *logWorkoutEndDate;


@end
