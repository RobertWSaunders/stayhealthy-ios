/** This class demonstrates AppleDoc.
 
 A second paragraph comes after an empty line.
 
	int i=0;
	i++;
 
 And some sample code can also be in a block, but indented with a TAB.
 */

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface CommonUtilities : NSObject


/** @name App Specific Constants Tools/Fetches*/

/**
* @warning h
*/
+ (NSString *)shortAppVersionNumber;

/**
 *  To access the apps global build number as string.
 *  @return The apps build number in the format (1.0).
 */
+ (NSString *)appBuildNumber;


/**
 *  To access the apps global build number as string.
 *  @return The apps build number in the format (1.0).
 */
+ (NSString *)installedDatabaseVersion;

+ (NSString *)hexBuildNumber;

/** @name Date Formatting Tools/Calculations*/

/*!
 *  Converts the date as a string.
 *  @param date The date that is returned as a string.
 *  @return A date as a string in the format (2015-08-09).
 */
+ (NSString *)returnDateInString:(NSDate *)date;

/*!
 *  Returns array of dates that lie between two dates.
 *  @param startDate First day in the array.
 *  @param endDate   Last day in the array.
 *  @return Array of dates between two days.
 */
+ (NSMutableArray *)arrayOfDays:(NSDate*)startDate endDate:(NSDate*)endDate;

/*!
 *  Returns number of days that lie between two dates.
 *  @param startDate First day in the count, date that the count starts on.
 *  @param endDate   Last day in the count, date that the count ends on.
 *  @return Number of days between two days, inclusive.
 */
+ (NSInteger)numberOfDaysBetweenDates:(NSDate*)startDate endDate:(NSDate*)endDate;

/*!
 *  Converts date into a more readable format, such as, 'Today, August 26th, 2015'.
 *  @param date Date that gets converted into readable format.
 *  @return Date in a readable format, such as, 'Today, August 26th, 2015' as a string.
 */
+ (NSString *)returnReadableDate:(NSDate*)date;

/*!
 *  Converts dates time into a more readable format, such as, '12:32 AM'.
 *  @param date Date that gets converted into readable time format.
 *  @return Date in a readable time format, such as, '12:32 AM' as a string.
 */
+ (NSString *)returnReadableTime:(NSDate*)date;

/*!
 *  Calculates the time from a passed date, in format 'just now'.
 *  @param createdDate Date that calculated time gets calculated from.
 *  @return String saying the time from the passed date, in format 'just now'.
 */
+ (NSString *)calculateTime:(NSDate *)createdDate;

/*!
 *  Resets date to midnight.
 *  @param date Date that gets reset.
 *  @return New date which is equal to passed date set to midnight.
 */
+ (NSDate *)resetTime:(NSDate*)date;

/*!
 *  Adds any number of hours to a date.
 *  @param date     Date to add the hours to.
 *  @param numHours Number of hours required to add to the date.
 *  @return A new date based off of the past date with the amount of hours added to it.
 */
+ (NSDate *)addHourToDate:(NSDate*)date hoursToAdd:(NSInteger)numHours;

/*!
 *  Rounds date to the nearest five minutes.
 *  @param date Date to round.
 *  @return New date which is equal to the passed date rounded to the nearest five minutes.
 */
+ (NSDate *)dateWithRoundedMinutes:(NSDate *)date;

/*!
 *  Creates a date without time.
 *  @param dateWithTime Date to remove time component from.
 *  @return Date without time component.
 */
+ (NSDate *)dateWithOutTime:(NSDate *)dateWithTime;


/** @name User Information Tools*/

/*!
 *  Gets firstname from a fullname string.
 *  @param name Full name string.
 *  @return Firstname string from the fullname.
 */
+ (NSString *)firstNameFromFullName:(NSString *)name;

/*!
 *  Gets lastname from a fullname string.
 *  @param name Full name string.
 *  @return Lastname string from the fullname.
 */
+ (NSString *)lastNameFromFullName:(NSString *)name;


/** @name Validation Tools*/

/*!
 *  Checks if email is a valid email.
 *  @param strEmail Email to check.
 *  @return YES if email is valid, else NO.
 */
+ (Boolean)emailIsValid:(NSString *)strEmail;

/** @name Useful Tools */

/*!
 *  To return a unique identifier.
 *  @return A unique string.
 */
+ (NSString *)returnUniqueID;

/*!
 *  Takes items in an array and creates a string seperating the items by the specified separator.
 *  @param arrayItems Array that holds the items to be separated.
 *  @param separator  String to separate the array items.
 *  @return A string containing the array items seperated by the separator.
 */
+ (NSString *)concatenateArrayItems:(NSArray *)arrayItems separator:(NSString *)separator;

+ (void)showCustomActivityIndicator:(UIImageView*)spinnerImage;

+ (void)setTintColor:(UIColor*)color;

+ (BOOL) dateExistsYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;


/** @name StayHealthy Specific Tools */

/*!
 *  Gives access to the StayHealthy plist as a dictionary.
 *  @return The StayHealthy general plist as a dictionary.
 */
+ (NSDictionary *)returnGeneralPlist;

/*!
 *  Creates a query for the StayHealthy database based off of parameters, used for find exercise by muscle.
 *  @param table  Table in the StayHealthy database.
 *  @param muscle Muscle to search for in the table.
 *  @return Query for the StayHealthy database as a string.
 */
+ (NSString *)createExerciseQuery:(NSUInteger)index muscles:(NSArray *)muscleArray;

+ (NSString *)createExerciseQueryFromExerciseIds:(NSMutableArray *)exerciseIDs table:(NSString*)table;

+ (NSString *)convertMuscleNameToDatabaseStandard:(NSString*)muscle;

+ (NSString *)returnDatabasePath:(NSString*)databaseName;

+ (SHExercise *)getRandomExercise:(exerciseTypes)exerciseType muscle:(NSString*)muscle;

//Returns an array of SHExercises that are in the workout that is passed.
+ (NSMutableArray*)getWorkoutExercises:(SHWorkout*)workout;

//Returns the count of exercises in a workout.
+ (NSUInteger)numExercisesInWorkout:(SHWorkout*)workout;

+ (NSString *)generateWorkoutExerciseQuery:(exerciseTypes)exerciseType exerciseIdentifier:(NSString*)exerciseIdentifier;
+ (NSString *)createWorkoutQueryFromWorkoutIds:(NSMutableArray *)workoutIDs table:(NSString*)table;

+ (NSUInteger)numExercisesInCustomWorkout:(SHCustomWorkout*)workout;

+ (NSMutableArray*)getCustomWorkoutExercises:(SHCustomWorkout*)workout;

+ (BOOL)exerciseInArray:(NSMutableArray*)exerciseArray exercise:(SHExercise*)exercise;

+ (NSMutableArray*)deleteSelectedExercise:(NSMutableArray*)exerciseArray exercise:(SHExercise*)exercise;

+ (SHExercise*)convertExerciseToSHExercise:(Exercise*)exercise;

+ (BOOL)isInternetConnection;
@end
