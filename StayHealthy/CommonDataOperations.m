//
//  CommonDataOperations.m
//  StayHealthy
//
//  Created by Student on 8/1/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import "CommonDataOperations.h"

@implementation CommonDataOperations

/***************************/
#pragma mark Utility Methods
/***************************/

//Returns the path to the database.
+(NSString *)returnDatabasePath:(NSString*)databaseName {
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString* dbPath = [documentsPath stringByAppendingPathComponent:databaseName];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:dbPath];
    
    if (!fileExists) {
        NSString *dbSourcePath = [[[NSBundle mainBundle] resourcePath  ]stringByAppendingPathComponent:databaseName];
        [[NSFileManager defaultManager] copyItemAtPath:dbSourcePath toPath:dbPath error:nil];
        NSLog(@"Couldn't Not Find Database!");
    }
    return dbPath;
}

/**************************/
#pragma mark SQL Operations
/**************************/

//Connects to the user database and performs the query, passed as an argument.
+ (void)performInsertQuery:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db {
    @try {
        if(!(sqlite3_open([[self returnDatabasePath:databaseName] UTF8String], &db) == SQLITE_OK))
            NSLog(@"An error has occured: %s", sqlite3_errmsg(db));
        const char *sql = [query cStringUsingEncoding:NSASCIIStringEncoding];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
            NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
        if (sqlite3_step(sqlStatement) == SQLITE_DONE)
            NSLog(@"Insert Statement Complete.");
        else 
            NSLog(@"Failed to perform statement.");
        sqlite3_finalize(sqlStatement);
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
    }
    @finally {
        sqlite3_close(db);
    }
}

+ (void) addDailyActivity:(NSString *)query database:(sqlite3*)db {
    [self performInsertQuery:query databaseName:USER_DATABASE database:db];
}

//Returns an array of exercises dependant on the query passed to it.
+ (NSMutableArray *)returnExerciseData:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db
{
    NSMutableArray *exerciseData = [[NSMutableArray alloc] init];
    
    @try {
        if(!(sqlite3_open([[self returnDatabasePath:databaseName] UTF8String], &db) == SQLITE_OK))
            NSLog(@"An error has occured: %s", sqlite3_errmsg(db));
        const char *sql = [query cStringUsingEncoding:NSASCIIStringEncoding];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
            NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
        else{
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                sqlColumns * exercise = [[sqlColumns alloc] init];
                exercise.ID = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)];
                exercise.Name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
                exercise.Muscle = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,2)];
                exercise.Description = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
                exercise.File= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 4)];
                exercise.Sets= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 5)];
                exercise.Reps= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 6)];
                exercise.Equipment= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 7)];
                exercise.PrimaryMuscle= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 8)];
                exercise.SecondaryMuscle= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 9)];
                exercise.Difficulty= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 10)];
                exercise.isFavorite= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 11)];
                exercise.ExerciseType= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 12)];
                [exerciseData addObject:exercise];
            }
        }
        sqlite3_finalize(sqlStatement);
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
    }
    @finally {
        sqlite3_close(db);
        return exerciseData;
    }
}

//This method checks and see whether a specific exercise is a favorite.
+ (NSMutableArray *) checkIfExerciseIsFavorite:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db{

    NSMutableArray *checkIfFavorite = [[NSMutableArray alloc] init];
    @try {
        if(!(sqlite3_open([[self returnDatabasePath:databaseName] UTF8String], &db) == SQLITE_OK))
            NSLog(@"An error has occured: %s", sqlite3_errmsg(db));
        const char *sql = [query cStringUsingEncoding:NSASCIIStringEncoding];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
            NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
        else {
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                favoriteColumns * exercise = [[favoriteColumns alloc] init];
                exercise.ID = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)];
                exercise.exerciseID = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
                exercise.exerciseType= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)];
                [checkIfFavorite addObject:exercise];
            }
        }
        sqlite3_finalize(sqlStatement);
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
    }
    @finally {
        sqlite3_close(db);
        return checkIfFavorite;
    }
}

//Returns an array of workout data specified from the query.
+ (NSMutableArray *) returnWorkoutData:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db {
    NSMutableArray *workoutData = [[NSMutableArray alloc] init];
    @try {
        if(!(sqlite3_open([[self returnDatabasePath:databaseName] UTF8String], &db) == SQLITE_OK))
            NSLog(@"An error has occured: %s", sqlite3_errmsg(db));
        const char *sql = [query cStringUsingEncoding:NSASCIIStringEncoding];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
            NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
        else{
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                workoutsDataObjects * workout = [[workoutsDataObjects alloc] init];
                workout.ID = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)];
                workout.name = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
                workout.summary = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,2)];
                workout.targetMuscles = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
                workout.Sports = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 4)];
                workout.exerciseIDs = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 5)];
                workout.exerciseTypes = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 6)];
                workout.workoutType = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 7)];
                workout.gender = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 8)];
                workout.Difficulty= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 9)];
                workout.equipment= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 10)];
                [workoutData  addObject:workout];
            }
        }
        sqlite3_finalize(sqlStatement);
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
    }
    @finally {
        sqlite3_close(db);
        return  workoutData ;
    }
}

//Returns the data stored for a specific workouts.
+ (NSMutableArray *) retreiveWorkoutInfo:(NSString*)query databaseName:(NSString*)databaseName database:(sqlite3*)db {
    NSMutableArray *workoutInfo = [[NSMutableArray alloc] init];
    @try {
        if(!(sqlite3_open([[self returnDatabasePath:databaseName] UTF8String], &db) == SQLITE_OK))
            NSLog(@"An error has occured: %s", sqlite3_errmsg(db));
        const char *sql = [query cStringUsingEncoding:NSASCIIStringEncoding];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
            NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
        else{
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                workoutFavoriteObjects * workout = [[workoutFavoriteObjects alloc] init];
                workout.WorkoutID = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)];
                workout.TimesCompleted = sqlite3_column_int(sqlStatement,1);
                workout.isFavorite = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,2)];
                [workoutInfo addObject:workout];
            }
        }
        sqlite3_finalize(sqlStatement);
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(db));
    }
    @finally {
        sqlite3_close(db);
        return workoutInfo;
    }
}


@end
