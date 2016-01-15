//
//  ExerciseDataManager.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-15.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Exercise.h"
#import "SHExercise.h"
#import "SHExercise+Exercise.h"
#import "DataManagerProtocol.h"

@interface ExerciseDataManager : NSObject <DataManagerProtocol>

//Define the app context for the data manager to call to.
@property (nonatomic, strong) NSManagedObjectContext  *appContext;

//Fetches the recently viewed exercise records from persistent store.
- (id)fetchRecentlyViewedExercises;

//Fetches all of the liked exercise records.
- (id)fetchAllLikedExercises;

//Fetches all of the liked strength exercise records.
- (id)fetchLikedStrengthExercises;

//Fetches all of the liked stretching exercise records.
- (id)fetchLikedStretchingExercises;

//Fetches all of the liked warmup exercise records.
- (id)fetchLikedWarmupExercises;

@end
