//
//  CustomWorkoutDataManager.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-23.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManagerProtocol.h"
#import "CustomWorkout.h"
#import "SHCustomWorkout.h"
#import "SHCustomWorkout+CustomWorkout.h"

@interface CustomWorkoutDataManager : NSObject <DataManagerProtocol>

@property (nonatomic, strong) NSManagedObjectContext  *appContext;

- (id) fetchAllLikedWorkouts;

@end
