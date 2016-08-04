//
//  CustomWorkoutDataManager.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomWorkout.h"
#import "SHCustomWorkout.h"
#import "SHCustomWorkout+CustomWorkout.h"
#import "DataManagerProtocol.h"

@interface CustomWorkoutDataManager : NSObject <DataManagerProtocol>

//Define the app context for the data manager to call to.
@property (nonatomic, strong) NSManagedObjectContext  *appContext;

//Fetches all of the liked custom workouts.
- (id)fetchAllLikedCustomWorkouts;

@end
