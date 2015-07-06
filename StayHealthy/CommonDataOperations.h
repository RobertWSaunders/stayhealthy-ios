//
//  CommonDataOperations.h
//  StayHealthy
//
//  Created by Student on 8/1/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonDataOperations : NSObject 

/*************************************/
#pragma mark - Globally Usable Methods
/*************************************/

//Returns the path to the database as sting.
+ (NSString*) returnDatabasePath:(NSString*)databaseName;

//Data returning methods, object returned in array.
//Methods used only for StayHealthy Database
//Returns array of workout objects dependant on query.
+ (NSMutableArray *) performWorkoutStatement:(NSString*)SQLQuery;
//Returns array of exercise objects dependant on query.
+ (NSMutableArray *) performExerciseStatement:(NSString*)SQLQuery;


//Standard database operations.
//Performs an Insert/Delete/Update query in the user database.
+ (void)performQuery:(NSString*)SQLQuery;

/***************************/
#pragma mark - Class Methods
/***************************/







@end
