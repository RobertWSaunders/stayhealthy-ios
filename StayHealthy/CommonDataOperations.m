//
//  CommonDataOperations.m
//  StayHealthy
//
//  Created by Student on 8/1/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import "CommonDataOperations.h"

@implementation CommonDataOperations
    sqlite3 *database;

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
#pragma mark - SQL Operations
/**************************/

/**************************************/
#pragma mark Insert/Update/Delete Query
/**************************************/

+ (void)performQuery:(NSString*)SQLQuery {
    @try {
        if(!(sqlite3_open([[self returnDatabasePath:USER_DATABASE] UTF8String], &database) == SQLITE_OK))
            NSLog(@"An error has occured: %s", sqlite3_errmsg(database));
        const char *sql = [SQLQuery cStringUsingEncoding:NSASCIIStringEncoding];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(database, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
            NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(database));
        if (sqlite3_step(sqlStatement) == SQLITE_DONE)
            NSLog(@"Statement Complete.");
        else 
            NSLog(@"Failed to perform statement.");
        sqlite3_finalize(sqlStatement);
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(database));
    }
    @finally {
        sqlite3_close(database);
    }
}

/****************************/
#pragma mark Retreive Objects
/****************************/

+ (NSMutableArray *)performExerciseStatement:(NSString*)SQLQuery {
    NSMutableArray *exerciseData = [[NSMutableArray alloc] init];
    @try {
        if(!(sqlite3_open([[self returnDatabasePath:STAYHEALTHY_DATABASE] UTF8String], &database) == SQLITE_OK))
            NSLog(@"An error has occured: %s", sqlite3_errmsg(database));
        const char *sql = [SQLQuery cStringUsingEncoding:NSASCIIStringEncoding];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(database, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
            NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(database));
        else{
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                exerciseObject * exercise = [[exerciseObject alloc] init];
                exercise.exerciseIdentifier = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)];
                exercise.exerciseName = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
                exercise.exerciseMuscle = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,2)];
                exercise.exerciseInstructions = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
                exercise.exerciseImageFile= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 4)];
                exercise.exerciseSets= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 5)];
                exercise.exerciseReps= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 6)];
                exercise.exerciseEquipment= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 7)];
                exercise.exercisePrimaryMuscle= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 8)];
                exercise.exerciseSecondaryMuscle= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 9)];
                exercise.exerciseDifficulty= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 10)];
                exercise.exerciseType= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 11)];
                [exerciseData addObject:exercise];
            }
        }
        sqlite3_finalize(sqlStatement);
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(database));
    }
    @finally {
        sqlite3_close(database);
        return exerciseData;
    }
}

+ (NSMutableArray *) performWorkoutStatement:(NSString*)SQLQuery {
    NSMutableArray *workoutData = [[NSMutableArray alloc] init];
    @try {
        if(!(sqlite3_open([[self returnDatabasePath:STAYHEALTHY_DATABASE] UTF8String], &database) == SQLITE_OK))
            NSLog(@"An error has occured: %s", sqlite3_errmsg(database));
        const char *sql = [SQLQuery cStringUsingEncoding:NSASCIIStringEncoding];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(database, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
            NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(database));
        else{
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                workoutObject * workout = [[workoutObject alloc] init];
                workout.workoutIdentifier = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,0)];
                workout.workoutName = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,1)];
                workout.workoutSummary = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement,2)];
                workout.workoutTargetMuscles = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];
                workout.workoutTargetSports = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 4)];
                workout.workoutExerciseIdentifiers = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 5)];
                workout.workoutExerciseTypes = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 6)];
                workout.workoutType = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 7)];
                workout.workoutDifficulty= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 9)];
                workout.workoutEquipment= [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 10)];
                [workoutData  addObject:workout];
            }
        }
        sqlite3_finalize(sqlStatement);
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(database));
    }
    @finally {
        sqlite3_close(database);
        return  workoutData ;
    }
}


@end
