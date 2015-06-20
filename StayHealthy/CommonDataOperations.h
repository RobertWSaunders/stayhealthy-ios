//
//  CommonDataOperations.h
//  StayHealthy
//
//  Created by Student on 8/1/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "favoriteColumns.h"
#import "workoutFavoriteObjects.h"
#import "workoutsDataObjects.h"
#import "sqlColumns.h"
#import "dailyActivity.h"
#import "profileInfo.h"

@interface CommonDataOperations : NSObject 

//Returns the path to the database.
+ (NSString*)returnDatabasePath:(NSString*)databaseName;

//Performs an insert/delete/update query in our database.
+ (void)performInsertQuery:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db;

+ (void)addDailyActivity:(NSString*)query database:(sqlite3*)db;

//Returns an array of exercises, dependant on the query passed to it.
+ (NSMutableArray *)returnExerciseData:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db;

//Checks to see if an exercise is a favorite.
+ (NSMutableArray *) checkIfExerciseIsFavorite:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db;

//Return an array of workout data.
+ (NSMutableArray *) returnWorkoutData:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db;

//Returns the workout information for the specific workouts.
+ (NSMutableArray *) retreiveWorkoutInfo:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db;

//Returns the daily activity information.
+ (NSMutableArray *) retreiveDailyActivity:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db;

+ (NSMutableArray *) retrieveProfileInformation:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db;

@end
