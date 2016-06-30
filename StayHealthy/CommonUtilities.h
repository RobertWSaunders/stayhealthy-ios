//
//  CommonUtilities.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-07-05.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface CommonUtilities : NSObject

/**************************************************/
#pragma mark - App Specific Constants Tools/Fetches
/**************************************************/

//Returns the app version number.
+ (NSString *)shortAppVersionNumber;

//Returns the app build number.
+ (NSString *)appBuildNumber;

//Returns the app build number as a hex.
+ (NSString *)hexBuildNumber;

//Returns the installed database version.
+ (NSString *)installedDatabaseVersion;

/************************************************/
#pragma mark - Date Formatting Tools/Calculations
/************************************************/

//Returns date as a string in the format YYYY-mm-dd
+ (NSString *)returnDateInString:(NSDate *)date;

//Returns data as a string in a nice format.
+ (NSString *)returnReadableDate:(NSDate*)date;

//Returns time as a strign in a nice format.
+ (NSString *)returnReadableTime:(NSDate*)date;

//Returns the time from a date and returns a nice string for display.
+ (NSString *)calculateTime:(NSDate *)createdDate;

//Resets the time for a date.
+ (NSDate *)resetTime:(NSDate*)date;

//Adds a number of hours to a date.
+ (NSDate *)addHourToDate:(NSDate*)date hoursToAdd:(NSInteger)numHours;

//Rounds a dates minutes to the nearest 5 minutes.
+ (NSDate *)dateWithRoundedMinutes:(NSDate *)date;

//Remove the time aspect from a date.
+ (NSDate *)dateWithOutTime:(NSDate *)dateWithTime;

//Returns the number of days between two dates.
+ (NSInteger)numberOfDaysBetweenDates:(NSDate*)startDate endDate:(NSDate*)endDate;

//Returns an array of dates between two dates.
+ (NSMutableArray *)arrayOfDays:(NSDate*)startDate endDate:(NSDate*)endDate;

//Checks if a date exists given the passed information.
+ (BOOL)dateExistsYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/************************************/
#pragma mark - User Information Tools
/************************************/

//Returns the first name from a full name.
+ (NSString *)firstNameFromFullName:(NSString *)name;

//Returns the last name from a full name.
+ (NSString *)lastNameFromFullName:(NSString *)name;

/*******************************/
#pragma mark - Validation Tools
/*******************************/

//Checks if an email is valid.
+ (BOOL)emailIsValid:(NSString *)email;

/*********************************/
#pragma mark - Conversion Methods
/*********************************/

//Converts meters to either km or miles based on user preferences.
+ (void)metersToPreferredDistance(double)meters;

//Converts km or miles to meters based on user preferences.
+ (void)preferredDistanceToMeters(double)distance;

//Converts pounds to pounds/kilograms/stones based on user preferences.
+ (void)poundsToPreferredWeight(float)pounds;

//Converts pounds/kilograms/st to pounds based on user preferences.
+ (void)preferredWeightToPounds(float)weight;

//Converts kph to either mph/kph/ms based on user preferences.
+ (void)kphToPreferredSpeed(float)kph;

//Converts kph/mph/ms to kph based on user preferences.
+ (void)preferredSpeedToKph(float)speed;

//Converts cm to in/m/ft/mm based on user preferences.
+ (void)cmToPreferredHeight(float)cm;

//Converts in/m/ft/mm to cm based on user preferences.
+ (void)preferredHeightToCm(float)height;

//Converts kcal to kj/kcal based on user preferences.
+ (void)kcalToPreferredCalorieUnit(float)kcal;

//Converts kcal/kj to kcal based on user preferences.
+ (void)preferredCalorieUnitToKcal(float)calorieUnit;

//Converts bpm to bpm based on user preferences.
+ (void)bpmToPreferredHeartBeatUnit(float)bpm;

//Converts bpm to bpm based on user preferences.
+ (void)preferredHeartBeatUnitToBpm(float)heartBeatUnit;

/***************************/
#pragma mark - Useful Tools
/***************************/

//Checks if the device has a internet connection.
+ (BOOL)isInternetConnection;

//Returns a unique identifier.
+ (NSString *)returnUniqueID;

//Returns a string of concatenated array items given the separator.
+ (NSString *)concatenateArrayItems:(NSArray *)arrayItems separator:(NSString *)separator;

/****************************************/
#pragma mark - StayHealthy Specific Tools
/****************************************/

/*---------------------------*/
#pragma mark - General Tools
/*---------------------------*/

//Sets the tint color throughout the application.
+ (void)setGlobalTintColor:(UIColor*)color;

//Shows the custom activity indicator in the passed image view.
+ (void)showCustomActivityIndicator:(UIImageView*)spinnerImage;

//Loads an image in the background.
+ (void)loadImageOnBackgroundThread:(UIImageView*)imageView image:(UIImage*)image;

//Returns a color given the module.
+ (UIColor*)returnModuleColor:(modules)module;

//Returns the path to the database.
+ (NSString *)returnDatabasePath:(NSString*)databaseName;

/*------------------------------------------*/
#pragma mark - View Controller Styling Tools
/*------------------------------------------*/

//Styles square collection view cells in their normal state.
+ (void)styleSquareCollectionViewCell:(UICollectionViewCell*)collectionViewCell;

//Styles square collection view cells in their selected state.
+ (void)styleSquareCollectionViewCellSelected:(UICollectionViewCell*)collectionViewCell;

//Shows a message on the screen.
+ (void)showMessage:(NSString*)titleText message:(NSString*)message viewController:(UIViewController*)controllerForDisplay canBeDismissedByUser:(BOOL)canDismiss duration:(int)duration;

//Shows the initial tutorial TSMessage.
+ (void)showFirstViewMessage:(NSString*)key viewController:(UIViewController*)view message:(NSString*)message;

//Styles alert views.
+ (void)styleAlertView:(UIColor*)color;

//Sets the selected background color for UITableViews.
+ (UIView *)tableViewSelectionColorSet:(UITableViewCell*)cell;

//Draws the view for the TableView header.
+ (UIView *)drawViewForTableViewHeader:(UITableView*)tableView;

//Returns the color based off of the difficulty passed to it.
+ (UIColor*)determineDifficultyColor:(NSString*)difficulty;

/*---------------------------*/
#pragma mark - Journal Tools
/*---------------------------*/


/*---------------------------*/
#pragma mark - Exercises Tools
/*---------------------------*/

//Converts a muscle string to the muscle name in the database.
+ (NSString *)convertMuscleNameToDatabaseStandard:(NSString*)muscle;

//Checks if a passed exercises is in the passed array.
+ (BOOL)exerciseInArray:(NSMutableArray*)exerciseArray exercise:(id *)exercise;

//Deletes the passed exercises from the passed array.
+ (NSMutableArray *)deleteSelectedExercise:(NSMutableArray*)exerciseArray exercise:(id *)exercise;

/*---------------------------*/
#pragma mark - Workout Tools
/*---------------------------*/

//Returns the count of exercises in a workout.
+ (NSUInteger)numExercisesInWorkout:(id *)workout;

/*------------------------*/
#pragma mark - Liked Tools
/*------------------------*/

/*-----------------------------------*/
#pragma mark - User Preferences Tools
/*-----------------------------------*/

//Checks if it is the users first launch.
+ (BOOL)isUsersFirstLaunch;

//Checks a users preference, bool preferences only.
+ (BOOL)checkUserPreference:(NSString *)key;

//Updates a users preference key with their selection.
+ (void)updateBoolForKey:(NSString *)key boolValue:(BOOL)boolValue;

//Updates a users preference key string value.
+ (void)updateValueForKey:(NSString *)key stringValue:(NSString*)stringValue;

//Resets all of the users preferences to our suggested preferences.
+ (void)resetUserPreferences;

@end
