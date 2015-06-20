//
//  dailyActivity.h
//  StayHealthy
//
//  Created by Student on 8/3/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dailyActivity : NSObject

@property(nonatomic,assign) NSInteger ID;
@property(nonatomic,assign) NSInteger completedWorkouts;
@property(nonatomic,assign) NSString *workoutTime;
@property(nonatomic,assign) NSInteger exercisesViewed;
@property(nonatomic,assign) NSInteger completedGoals;
@property(nonatomic,assign) NSString *date;


@end
