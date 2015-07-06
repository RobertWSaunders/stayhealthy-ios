//
//  CommonRequests.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-06-20.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonRequests : NSObject

//Returns the app version number (i.e. 1.0.0)
+ (NSString *)shortAppVersion;
//Returns the app build number
+ (NSString *)appBuild;
//Return the date without time
+ (NSDate *)dateWithOutTime:(NSDate *)Date;
//Return the date as string
+ (NSString *)returnDateInString:(NSDate *)date;
//Returns the date in a string as a pretty format.
+ (NSString *)returnPrettyDate:(NSString*)stringDate format:(NSString*)format;
//Returns an array of dates between two dates in the form of a string.
+ (NSMutableArray*)arrayOfDays:(NSDate*)startDate endDate:(NSDate*)endDate;
//Returns the number of days between two dates.
+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;
//Converts the exercise type to the table name for queries.
+ (NSString*)convertExerciseTypeToTableName:(NSString*)exerciseType;
+ (NSDictionary*)returnGeneralPlist;

@end
