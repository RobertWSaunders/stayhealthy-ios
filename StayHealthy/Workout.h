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

@property (nonatomic, retain) NSDate * lastDateCompleted;
@property (nonatomic, retain) NSDate * lastViewed;
@property (nonatomic, retain) NSNumber * liked;
@property (nonatomic, retain) NSNumber * timesCompleted;
@property (nonatomic, retain) NSString * workoutID;

@end
