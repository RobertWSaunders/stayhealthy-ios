//
//  ExerciseDataManager.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-15.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManagerProtocol.h"
#import "Exercise.h"
#import "SHExercise.h"
#import "SHExercise+Exercise.h"

@interface ExerciseDataManager : NSObject <DataManagerProtocol>

@property (nonatomic, strong) NSManagedObjectContext  *appContext;

- (NSFetchRequest *) getFetchRequest;

- (id) fetchRecentlyViewedExercises;

- (id) fetchAllLikedExercises;

- (id) fetchStretchLikedExercises;

- (id) fetchStrengthLikedExercises;

- (id) fetchWarmupLikedExercises;

@end
