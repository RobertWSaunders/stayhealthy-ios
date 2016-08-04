//
//  SHExerciseLog.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-29.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TelerikUI/TelerikUI.h>

@interface SHExerciseLog : TKCalendarEvent

@property (nullable, nonatomic, retain) NSDate *exerciseLogDate;
@property (nullable, nonatomic, retain) NSString *exerciseLogExerciseIdentifier;
@property (nullable, nonatomic, retain) NSString *exerciseLogExerciseSetsIdentifiers;
@property (nullable, nonatomic, retain) NSString *exerciseLogExerciseType;
@property (nullable, nonatomic, retain) NSString *exerciseLogIdentifier;
@property (nullable, nonatomic, retain) NSString *exerciseLogNotes;
@property (nullable, nonatomic, retain) NSString *exerciseLogFeeling;

@end
