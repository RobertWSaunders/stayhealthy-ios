//
//  WorkoutDataManager.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Workout.h"
#import "SHWorkout.h"
#import "SHWorkout+Workout.h"
#import "DataManagerProtocol.h"

@interface WorkoutDataManager : NSObject <DataManagerProtocol>

//Define the app context for the data manager to call to.
@property (nonatomic, strong) NSManagedObjectContext  *appContext;

//Fetches all of the recently viewed workouts.
- (id)fetchRecentlyViewedWorkouts;

//Fetches all of the liked workouts.
- (id)fetchAllLikedWorkouts;

@end
