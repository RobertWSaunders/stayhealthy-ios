//
//  WorkoutDataManager.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManagerProtocol.h"
#import "Workout.h"
#import "SHWorkout.h"
#import "SHWorkout+Workout.h"

@interface WorkoutDataManager : NSObject <DataManagerProtocol>

@property (nonatomic, strong) NSManagedObjectContext  *appContext;

- (id) fetchRecentlyViewedWorkouts;

- (id) fetchAllLikedWorkouts;

@end
