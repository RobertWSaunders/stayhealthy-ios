//
//  WorkoutLog.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-29.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface WorkoutLog : NSManagedObject

@property (nullable, nonatomic, retain) NSDate *logDate;
@property (nullable, nonatomic, retain) NSDate *logWorkoutStartDate;
@property (nullable, nonatomic, retain) NSDate *logWorkoutEndDate;
@property (nullable, nonatomic, retain) NSString *logWorkoutIdentifier;
@property (nullable, nonatomic, retain) NSString *logWorkoutExerciseLogIdentifiers;
@property (nullable, nonatomic, retain) NSString *logWorkoutExerciseTypes;
@property (nullable, nonatomic, retain) NSString *logIdentifier;
@property (nullable, nonatomic, retain) NSString *logWorkoutFeeling;
@property (nullable, nonatomic, retain) NSString *logWorkoutNotes;

@end
 
