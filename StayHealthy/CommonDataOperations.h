//
//  CommonDataOperations.h
//  StayHealthy
//
//  Created by Student on 8/1/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonDataOperations : NSObject 

//Returns the path to the database.
+ (NSString*)returnDatabasePath:(NSString*)databaseName;

//Performs an Insert/Delete/Update query in the database.
+ (void)performInsertQuery:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db;

//Returns an array of exercises, dependant on the query passed to it.
+ (NSMutableArray *)returnExerciseData:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db;

//Checks to see if an exercise is a favorite.
+ (NSMutableArray *) checkIfExerciseIsFavorite:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db;

//Return an array of workout data.
+ (NSMutableArray *) returnWorkoutData:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db;

//Returns the workout information for a specific workout.
+ (NSMutableArray *) retreiveWorkoutInfo:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db;

@end
