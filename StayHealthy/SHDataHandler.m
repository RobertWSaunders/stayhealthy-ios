//
//  SHDataHandler.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-15.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import "SHDataHandler.h"

@implementation SHDataHandler

#pragma mark - Initialization

-(id)init {
    if (self = [super init]) {
        exerciseManager = [[ExerciseDataManager alloc] init];
        workoutManager = [[WorkoutDataManager alloc] init];
        customWorkoutManager = [[CustomWorkoutDataManager alloc] init];
        userDataManager = [[UserDataManager alloc] init];
    }
    return self;
}

#pragma mark - Singleton Instance

+ (id) getInstance {
    static SHDataHandler *_instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    
    return _instance;
}

#pragma mark - StayHealthy Database Data Manager Methods

- (void)performQuery:(NSString*)SQLQuery {
    @try {
        if(!(sqlite3_open([[CommonUtilities returnDatabasePath:STAYHEALTHY_DATABASE_NAME] UTF8String], &database) == SQLITE_OK))
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

- (NSMutableArray *)performExerciseStatement:(NSString*)SQLQuery {
    NSMutableArray *exerciseData = [[NSMutableArray alloc] init];
    @try {
        if(!(sqlite3_open([[CommonUtilities returnDatabasePath:STAYHEALTHY_DATABASE_NAME] UTF8String], &database) == SQLITE_OK))
            LogDataError(@"An error has occured while fetching SHExercises from StayHealthy database: %s", sqlite3_errmsg(database));
        const char *sql = [SQLQuery cStringUsingEncoding:NSASCIIStringEncoding];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(database, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
            LogDataError(@"Could not load SHExercises from StayHealthy database, problem with prepare statement:  %s", sqlite3_errmsg(database));
        else{
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                SHExercise * exercise = [[SHExercise alloc] init];
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
        LogDataError(@"Could not load SHExercises from StayHealthy database, problem with prepare statement:  %s", sqlite3_errmsg(database));
    }
    @finally {
        sqlite3_close(database);
        return exerciseData;
    }
}

- (NSMutableArray *)performWorkoutStatement:(NSString*)SQLQuery {
    NSMutableArray *workoutData = [[NSMutableArray alloc] init];
    @try {
        if(!(sqlite3_open([[CommonUtilities returnDatabasePath:STAYHEALTHY_DATABASE_NAME] UTF8String], &database) == SQLITE_OK))
            NSLog(@"An error has occured: %s", sqlite3_errmsg(database));
        const char *sql = [SQLQuery cStringUsingEncoding:NSASCIIStringEncoding];
        sqlite3_stmt *sqlStatement;
        if(sqlite3_prepare(database, sql, -1, &sqlStatement, NULL) != SQLITE_OK)
            NSLog(@"Problem with prepare statement:  %s", sqlite3_errmsg(database));
        else{
            while (sqlite3_step(sqlStatement)==SQLITE_ROW) {
                SHWorkout *workout = [[SHWorkout alloc] init];
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

- (SHExercise *)convertExerciseToSHExercise:(Exercise*)exercise {
    
    SHExercise *shExercise = [[SHExercise alloc] init];
    
    NSMutableArray *exerciseID = [[NSMutableArray alloc] initWithObjects:exercise.exerciseID, nil];
    
    NSString*table;
    
    if ([exercise.exerciseType isEqualToString:@"strength"]) {
        table = STRENGTH_DB_TABLENAME;
    }
    else if ([exercise.exerciseType isEqualToString:@"stretching"]) {
        table = STRETCHING_DB_TABLENAME;
    }
    else {
        table = WARMUP_DB_TABLENAME;
    }
    
    NSArray *shExerciseData = [[SHDataHandler getInstance] performExerciseStatement:[CommonUtilities createExerciseQueryFromExerciseIds:exerciseID table:table]];
    
    shExercise = [shExerciseData objectAtIndex:0];
    
    shExercise.lastViewed = exercise.lastViewed;
    shExercise.liked = exercise.liked;
    
    return shExercise;
}

#pragma mark - Exercise Data Manager Methods

- (void)saveExerciseRecord:(SHExercise *)exercise {
    [exerciseManager saveItem:exercise];
}

- (void)updateExerciseRecord:(SHExercise *)exercise {
    [exerciseManager updateItem:exercise];
}

- (NSArray*)fetchExerciseByIdentifier:(NSString *)exerciseIdentifier {
    return [exerciseManager fetchItemByIdentifier:exerciseIdentifier];
}

- (BOOL)exerciseHasBeenSaved:(NSString *)exerciseIdentifier {
    Exercise *exercise = [exerciseManager fetchItemByIdentifier:exerciseIdentifier];
    if (exercise != nil)
        return YES;
    return NO;
}

- (NSMutableArray *)getRecentlyViewedExercises {
    return [[exerciseManager fetchRecentlyViewedExercises] mutableCopy];
}

- (NSMutableArray *)getAllLikedExercises {
    return [[exerciseManager fetchAllLikedExercises] mutableCopy];
}

- (NSMutableArray *)getStrengthLikedExercises {
     return [[exerciseManager fetchStrengthLikedExercises] mutableCopy];
}

- (NSMutableArray *)getStretchLikedExercises {
     return [[exerciseManager fetchStretchLikedExercises] mutableCopy];
}

- (NSMutableArray *)getWarmupLikedExercises {
     return [[exerciseManager fetchWarmupLikedExercises] mutableCopy];
}

#pragma mark - Workout Data Manager Methods

- (void)saveWorkoutRecord:(SHWorkout *)workout {
    [workoutManager saveItem:workout];
}

- (void)updateWorkoutRecord:(SHWorkout *)workout {
    [workoutManager updateItem:workout];
}

- (BOOL)workoutHasBeenSaved:(NSString *)workoutIdentifier {
    Workout *workout = [workoutManager fetchItemByIdentifier:workoutIdentifier];
    if (workout != nil)
        return YES;
    return NO;

}

#pragma mark - Custom Workout Data Manager Methods

- (void)saveCustomWorkoutRecord:(SHCustomWorkout *)customWorkout {
    [customWorkoutManager saveItem:customWorkout];
}

- (void)updateCustomWorkoutRecord:(SHCustomWorkout *)customWorkout {
    [customWorkoutManager updateItem:customWorkout];
}

- (SHCustomWorkout *)returnCustomWorkoutByIdentifier:(NSString*)identifier {
    return [customWorkoutManager fetchItemByIdentifier:identifier];
}

#pragma mark - User Data Manager Methods

- (void)saveUser:(SHUser *)user {
    [userDataManager saveItem:user];
}

- (void)updateUser:(SHUser*)user {
    [userDataManager updateItem:user];
}

- (NSString*)getUserIdentifier {
    return [userDataManager getUserID];
}

- (BOOL)userIsCreated {
    return [userDataManager userIsCreated];
}

//---------------------------------------
#pragma mark Auto Database Update Methods
//---------------------------------------

//Checks to see if the user wants auto database updates then compares current installed database to online database and installs if nescessary.
- (void)performDatabaseUpdate {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:PREFERENCE_AUTO_DATABASE_UPDATES]) {
        //Check if a newer database is actually online to download.
        if ([self isDatabaseUpdate]) {
            
            //Reference the path to the documents directory.
            NSString *documentDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            //Get the path of the database.
            NSString *filePath = [documentDir stringByAppendingPathComponent:@"StayHealthyDatabase.sqlite"];
            
            //Set the URL request to download from.
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:DATABASE_URL]];
            
            //Download file and overwrite the previous database version.
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                if (error) {
                    //Downloading error.
                    LogDataError(@"Error downloading updated StayHealthy database: %@", error.description);
                }
                if (data) {
                    //Overwrite current database.
                    [data writeToFile:filePath atomically:YES];
                    //Download success.
                    LogDataSuccess(@"Successfully downloaded and replaced database. Saved to %@", filePath);
                }
            }];
        }
    }
}

//Checks if there is a update that can be made to the database.
- (BOOL)isDatabaseUpdate {
    //Make sure that the string from the web is not empty.
    if ([self onlineDatabaseVersion] != nil) {
        //Compare to the installed version on the phone to the version online.
        if (![[self onlineDatabaseVersion] isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:USER_INSTALLED_DATABASE_VERSION]]) {
            //If there is a update required, set the new user database version to be the online one.
            [[NSUserDefaults standardUserDefaults] setValue:[self onlineDatabaseVersion] forKey:USER_INSTALLED_DATABASE_VERSION];
            //Save the changes.
            [[NSUserDefaults standardUserDefaults] synchronize];
            return TRUE;
        }
        else {
            return FALSE;
        }
    }
    return FALSE;
}

//Returns the database version that is store on the web.
- (NSString *)onlineDatabaseVersion {
    //Set the NSURL for where the database version is stored.
    NSURL *URL = [NSURL URLWithString:DATABASE_VERSION_URL];
    
    NSError *error;
    
    //Get the string from the text file online.
    NSString *stringFromFileAtURL = [[NSString alloc]
                                     initWithContentsOfURL:URL
                                     encoding:NSUTF8StringEncoding
                                     error:&error];
    
    //If the string is nil then log the error.
    if (stringFromFileAtURL == nil) {
        LogDataError(@"Could not find database version online.");
    }
    
    //Return the string.
    return stringFromFileAtURL;
}


@end
