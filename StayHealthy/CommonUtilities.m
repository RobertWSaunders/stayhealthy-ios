//
//  CommonUtilities.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-06-20.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "CommonUtilities.h"

@implementation CommonUtilities

/**************************************************/
#pragma mark - App Specific Constants Tools/Fetches
/**************************************************/

//Returns the app version number.
+ (NSString *)shortAppVersionNumber {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
}

//Returns the app build number.
+ (NSString *)appBuildNumber {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
}

//Returns the app build number as a hex.
+ (NSString *)hexBuildNumber {
    return [NSString stringWithFormat:@"%lX", (unsigned long)[[self appBuildNumber] integerValue]];
}

//Returns the installed database version.
+ (NSString *)installedDatabaseVersion {
    return @"1.0.0";
}

/************************************************/
#pragma mark - Date Formatting Tools/Calculations
/************************************************/

//Returns date as a string in the format YYYY-mm-dd
+ (NSString *)returnDateInString:(NSDate *)date {
    NSString *dateString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

//Returns data as a string in a nice format.
+ (NSString *)returnReadableDate:(NSDate *)date {
    NSString *dateToShow;
    
    if(date == nil) {
        return @"";
    }
    
    // Convert date object to desired output format
    NSDateFormatter *dateFormatNormal = [[NSDateFormatter alloc] init];
    [dateFormatNormal setDateFormat:@"EEEE, MMMM d"];
    
    NSDateFormatter *dateFormatSpecialDays = [[NSDateFormatter alloc] init];
    [dateFormatSpecialDays setDateFormat:@"MMMM d"];
    
    //Making the date for tommorrow.
    NSDateComponents *componentsTomorrow = [NSDateComponents new];
    [componentsTomorrow setDay:1];
    NSDate *tomorrow = [[NSCalendar currentCalendar] dateByAddingComponents:componentsTomorrow toDate:[NSDate date] options:0];
    //Making the date for yesterday.
    NSDateComponents *componentsYesterday = [NSDateComponents new];
    [componentsYesterday setDay:-1];
    NSDate *yesterday = [[NSCalendar currentCalendar] dateByAddingComponents:componentsYesterday toDate:[NSDate date] options:0];
    
    //Setting the section heading dependant on the day.
    if ([[self dateWithOutTime:date] isEqualToDate:[self dateWithOutTime:[NSDate new]]])
        dateToShow = [NSString stringWithFormat:@"Today, %@",[dateFormatSpecialDays stringFromDate:date]];
    else if ([[self dateWithOutTime:date] isEqualToDate:[self dateWithOutTime:tomorrow]])
        dateToShow = [NSString stringWithFormat:@"Tomorrow, %@",[dateFormatSpecialDays stringFromDate:date]];
    else if ([[self dateWithOutTime:date] isEqualToDate:[self dateWithOutTime:yesterday]])
        dateToShow = [NSString stringWithFormat:@"Yesterday, %@",[dateFormatSpecialDays stringFromDate:date]];
    else
        dateToShow = [dateFormatNormal stringFromDate:date];
    
    
    NSDateFormatter *monthDayFormatter = [[NSDateFormatter alloc] init];
    [monthDayFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [monthDayFormatter setDateFormat:@"d"];
    int date_day = [[monthDayFormatter stringFromDate:date] intValue];
    NSString *suffix_string = @"|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st";
    NSArray *suffixes = [suffix_string componentsSeparatedByString: @"|"];
    NSString *suffix = [suffixes objectAtIndex:date_day];
    NSString *dateString = [dateToShow stringByAppendingString:suffix];
    
    NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
    [yearFormatter setDateFormat:@", yyyy"];
    
    NSString *yearSuffix = [yearFormatter stringFromDate:date];
    NSString *finalDateString = [dateString stringByAppendingString:yearSuffix];
    
    return finalDateString;
}

//Returns time as a strign in a nice format.
+ (NSString *)returnReadableTime:(NSDate *)date {
    NSString *timeText;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a"];
    timeText = [formatter stringFromDate:date];
    return timeText;
}

//Returns the time from a date and returns a nice string for display.
+ (NSString *)calculateTime:(NSDate *)createdDate {
    NSString *value;
    
    if (createdDate != nil)
    {
        createdDate                     = [self resetTime:createdDate];
        NSDate *currentDate             = [[NSDate alloc] init];
        currentDate                     = [self resetTime:currentDate];
        NSCalendar *gregorian           = [NSCalendar currentCalendar];
        NSUInteger unitFlags            = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfYear | NSCalendarUnitDay | NSCalendarUnitHour;
        NSDateComponents *components    = [gregorian components:unitFlags fromDate:createdDate toDate:currentDate options:0];
        
        NSInteger months                = [components month];
        NSInteger weeks                 = [components weekOfYear];
        NSInteger days                  = [components day];
        NSInteger year                  = [components year];
        
        if(year > 0)
        {
            if(year == 1)
                return [NSString stringWithFormat:@"%ld year ago", (long)year];
            else
                return [NSString stringWithFormat:@"%ld years ago", (long)year];
        }
        else if(months > 0)
        {
            if(months == 1)
                return [NSString stringWithFormat:@"%ld month ago", (long)months];
            else
                return [NSString stringWithFormat:@"%ld months ago", (long)months];
        }
        else if(weeks > 0)
        {
            if(weeks == 1)
                return [NSString stringWithFormat:@"%ld week ago", (long)weeks];
            else
                return [NSString stringWithFormat:@"%ld weeks ago", (long)weeks];
        }
        else if(days > 0)
        {
            if(days == 1)
                return @"Yesterday";
            else
                return [NSString stringWithFormat:@"%ld days ago", (long)days];
        }
        else
        {
            NSDateComponents *dateComponentsNow     = [gregorian components:unitFlags fromDate:currentDate];
            NSDateComponents *dateComponentsBirth   = [gregorian components:unitFlags fromDate:createdDate];
            days                                    = [dateComponentsNow day] - [dateComponentsBirth day];
            if(days > 0)
                return @"Yesterday";
            else
                return @"Today";
        }
    }
    return value;
}

//Resets the time for a date.
+ (NSDate *)resetTime:(NSDate *)date {
    NSCalendar *gregorian           = [NSCalendar currentCalendar];
    NSDateComponents *components    = [gregorian components: NSUIntegerMax fromDate: date];
    
    [components setHour: 0];
    [components setMinute: 0];
    [components setSecond: 0];
    
    //NSDate *newDate = [gregorian dateFromComponents: components];
    //return newDate;
    date                            = [gregorian dateFromComponents: components];
    return date;
}

//Adds a number of hours to a date.
+ (NSDate *)addHourToDate:(NSDate *)date hoursToAdd:(NSInteger)numHours {
    NSDate *hourAddedDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *endDateComponents = [[NSDateComponents alloc] init];
    [endDateComponents setHour:numHours];
    hourAddedDate = [calendar dateByAddingComponents:endDateComponents toDate:date options:0];
    
    return hourAddedDate;
}

//Rounds a dates minutes to the nearest 5 minutes.
+ (NSDate *)dateWithRoundedMinutes:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *componentsForCurrentDay = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitYear) fromDate:date];
    
    NSInteger hour = [componentsForCurrentDay hour];
    NSInteger day  = [componentsForCurrentDay day];
    NSInteger weekday  = [componentsForCurrentDay weekday];
    NSInteger month  = [componentsForCurrentDay month];
    NSInteger year  = [componentsForCurrentDay year];
    
    //Round today's date to the nearest 5 minutes.
    NSDateComponents *dateTime = [[NSCalendar currentCalendar] components:NSCalendarUnitHour | NSCalendarUnitMinute fromDate:date];
    NSInteger minutes = [dateTime minute];
    float minuteUnit = ceil((float) minutes / 5.0);
    minutes = minuteUnit * 5.0;
    [dateTime setMinute: minutes];
    [dateTime setHour:hour];
    [dateTime setDay:day];
    [dateTime setYear:year];
    [dateTime setWeekday:weekday];
    [dateTime setMonth:month];
    
    return [calendar dateFromComponents:dateTime];
}

//Remove the time aspect from a date.
+ (NSDate *)dateWithOutTime:(NSDate *)dateWithTime {
    if(dateWithTime == nil )
        dateWithTime = [NSDate date];
    
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateWithTime];
    
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

//Returns the number of days between two dates.
+ (NSInteger)numberOfDaysBetweenDates:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:startDate];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:endDate];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    return [difference day];
}

//Returns an array of dates between two dates.
+ (NSMutableArray *)arrayOfDays:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSMutableArray *arrayOfDaysFill = [[NSMutableArray alloc] init];
    [arrayOfDaysFill removeAllObjects];
    // [arrayOfDays addObject:[self dateWithOutTime:startDate]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *startDateString = [dateFormatter stringFromDate:startDate];
    
    [arrayOfDaysFill addObject:startDateString];
    
    NSDate *nextDate;
    nextDate = startDate;
    
    for (int i = 0; i < [self numberOfDaysBetweenDates:startDate endDate:endDate]-1; i++) {
        
        // start by retrieving day, weekday, month and year components for yourDate
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDateComponents *todayComponents = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond) fromDate:nextDate];
        NSInteger theDay = [todayComponents day];
        NSInteger theMonth = [todayComponents month];
        NSInteger theYear = [todayComponents year];
        
        NSInteger theHour = [todayComponents hour];
        NSInteger theMinute = [todayComponents minute];
        NSInteger theSecond = [todayComponents second];
        
        // now build a NSDate object for yourDate using these components
        NSDateComponents *components = [[NSDateComponents alloc] init];
        [components setDay:theDay];
        [components setMonth:theMonth];
        [components setYear:theYear];
        [components setHour:theHour];
        [components setMinute:theMinute];
        [components setSecond:theSecond];
        
        NSDate *thisDate = [gregorian dateFromComponents:components];
        
        // now build a NSDate object for the next day
        NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
        [offsetComponents setDay:1];
        nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:thisDate options:0];
        
        NSString *nextDateString = [dateFormatter stringFromDate:nextDate];
        
        [arrayOfDaysFill addObject:nextDateString];
    }
    return arrayOfDaysFill;
}

//Checks if a date exists given the passed information.
+ (BOOL)dateExistsYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSDateComponents *components = [[NSDateComponents alloc] init];
    
    [components setYear:year];
    [components setMonth:month];
    [components setDay:day];
    
    NSDate *date    = [[NSCalendar currentCalendar] dateFromComponents:components];
    components      = [[NSCalendar currentCalendar] components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    if([components year] != year || [components month] != month || [components day] != day)
        return NO;
    else
        return YES;
}

/************************************/
#pragma mark - User Information Tools
/************************************/

//Returns the first name from a full name.
+ (NSString *)firstNameFromFullName:(NSString *)name {
    // find the location of the first space
    NSRange r = [name rangeOfString:@" "];
    if(r.location == NSNotFound) {
        // must be just one name with no spaces
        return name;
    }
    
    // return the prefix up until the first space
    return [name substringToIndex:r.location];
}

//Returns the last name from a full name.
+ (NSString *)lastNameFromFullName:(NSString *)name {
    // find the location of the first space
    NSRange r = [name rangeOfString:@" "];
    if(r.location == NSNotFound) {
        // must be just one name with no spaces
        return name;
    }
    
    // return the suffix starting from the first space
    return [name substringFromIndex:r.location + 1];
}

/*******************************/
#pragma mark - Validation Tools
/*******************************/


/***************************/
#pragma mark - Useful Tools
/***************************/

//Checks if the device has a internet connection.
+ (BOOL)isInternetConnection {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return NO;
    } else {
        return YES;
    }
}

//Returns a unique identifier.
+ (NSString *) returnUniqueID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

//Returns a string of concatenated array items given the separator.
+ (NSString *)concatenateArrayItems:(NSArray *)arrayItems separator:(NSString *)separator {
    NSString *keyList;
    
    if(arrayItems != nil)
    {
        for(NSString *item in arrayItems)
        {
            if(keyList != nil)
            {
                keyList = [keyList stringByAppendingString:separator];
                keyList = [keyList stringByAppendingString:item];
            }
            else
                keyList = item;
        }
    }
    return keyList;
}

/****************************************/
#pragma mark - StayHealthy Specific Tools
/****************************************/

/*---------------------------*/
#pragma mark - General Tools
/*---------------------------*/

//Sets the tint color throughout the application.
+ (void)setGlobalTintColor:(UIColor *)color {
    //Set the appearance of the navigation bar. Set the text color to EXERCISES_COLOR constant.
    //Set the font of the navigation bar to the STAYHEALTHY_NABBARFONT
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           color,
                                                           NSForegroundColorAttributeName,
                                                           NAVIGATIONBAR_TITLE_FONT,
                                                           NSFontAttributeName,
                                                           nil]];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName:NAVIGATIONBAR_BUTTON_FONT,
                                                           NSForegroundColorAttributeName:color
                                                           } forState:UIControlStateNormal];
    
    [[UINavigationBar appearance] setBarTintColor:WHITE_COLOR];
    [[UINavigationBar appearance] setTintColor:color];
    //Set the tint color of all segmented controls.
    [[UISegmentedControl appearance] setTintColor:color];
    //Set the tint color for all UIToolbars.
    [[UIToolbar appearance] setTintColor:color];
    [[UIToolbar appearance] setBarTintColor:WHITE_COLOR];
    [[UITabBar appearance] setBarTintColor:WHITE_COLOR];
    
    UIFont *font = [UIFont systemFontOfSize:13.0f weight:UIFontWeightMedium];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:NSFontAttributeName];
    
    [[UISegmentedControl appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

//Shows the custom activity indicator in the passed image view.
+ (void)showCustomActivityIndicator:(UIImageView*)spinnerImage {
    //Create the first status image and the indicator view
    spinnerImage.image = [UIImage imageNamed:@"Spinner1.png"];
    
    //Add more images which will be used for the animation
    spinnerImage.animationImages = [NSArray arrayWithObjects:
                                    [UIImage imageNamed:@"Spinner1.png"],
                                    [UIImage imageNamed:@"Spinner2.png"],
                                    [UIImage imageNamed:@"Spinner3.png"],
                                    [UIImage imageNamed:@"Spinner4.png"],
                                    [UIImage imageNamed:@"Spinner5.png"],
                                    [UIImage imageNamed:@"Spinner6.png"],
                                    [UIImage imageNamed:@"Spinner7.png"],
                                    [UIImage imageNamed:@"Spinner8.png"],
                                    nil];
    
    spinnerImage.animationDuration = 0.8;
    
    //Start the animation
    [spinnerImage startAnimating];
    
    spinnerImage.hidden = NO;
}

//Loads an image in the background.
+ (void)loadImageOnBackgroundThread:(UIImageView *)imageView image:(UIImage *)image {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            imageView.image = image;
            /*imageView.alpha = 0.0;
             [UIView animateWithDuration:0.8 animations:^{
             imageView.alpha = 1.0;
             }];
             */
        });
    });
}

//Returns a color given the module.
+ (UIColor *)returnModuleColor:(modules)module {
    if (module == journal) {
        return JOURNAL_COLOR;
    }
    else if (module == exercises) {
        return EXERCISES_COLOR;
    }
    else if (module == workouts) {
        return WORKOUTS_COLOR;
    }
    else {
        return LIKED_COLOR;
    }
}

//Returns the path to the database.
+ (NSString *)returnDatabasePath:(NSString*)databaseName {
    NSString* documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString* dbPath = [documentsPath stringByAppendingPathComponent:databaseName];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:dbPath];
    
    if (!fileExists) {
        LogDataError(@"Database was not found in documents directory...");
        NSString *dbSourcePath = [[[NSBundle mainBundle] resourcePath  ]stringByAppendingPathComponent:databaseName];
        [[NSFileManager defaultManager] copyItemAtPath:dbSourcePath toPath:dbPath error:nil];
        LogDataSuccess(@"Database was succesfully copied to documents directory...");
    }
    return dbPath;
}

/*------------------------------------------*/
#pragma mark - View Controller Styling Tools
/*------------------------------------------*/

//Styles square collection view cells in their normal state.
+ (void)styleSquareCollectionViewCell:(UICollectionViewCell*)collectionViewCell {
    collectionViewCell.layer.masksToBounds = NO;
    collectionViewCell.layer.borderColor = LIGHT_GRAY_COLOR.CGColor;
    collectionViewCell.layer.borderWidth = 0.50f;
}

//Styles square collection view cells in their selected state.
+ (void)styleSquareCollectionViewCellSelected:(UICollectionViewCell*)collectionViewCell {
    collectionViewCell.layer.masksToBounds = NO;
    collectionViewCell.layer.borderColor = EXERCISES_COLOR.CGColor;
    collectionViewCell.layer.borderWidth = 2.0f;
}

//Shows a message on the screen.
+ (void)showMessage:(NSString *)titleText message:(NSString *)message viewController:(UIViewController *)controllerForDisplay canBeDismissedByUser:(BOOL)canDismiss duration:(int)duration {
    [TSMessage showNotificationInViewController:controllerForDisplay
                                          title:titleText
                                       subtitle:message
                                          image:nil
                                           type:TSMessageNotificationTypeMessage
                                       duration:duration
                                       callback:nil
                                    buttonTitle:nil
                                 buttonCallback:nil
                                     atPosition:TSMessageNotificationPositionTop
                            canBeDismisedByUser:canDismiss];
}

//Shows the initial tutorial TSMessage.
+ (void)showFirstViewMessage:(NSString *)key viewController:(UIViewController *)view message:(NSString *)message {
    //If the user has allowed tutorial messages from the settings page, perform the tutorial message. By default the key is NO, which is actually YES.
    if (![[NSUserDefaults standardUserDefaults] boolForKey:PREFERENCE_TUTORIAL_MESSAGES]) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:key])
        {
            [self showMessage:nil message:message viewController:view canBeDismissedByUser:YES duration:1000];
        }
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//Styles alert views.
+ (void)styleAlertView:(UIColor*)color {
    //Style the SIAlertView asking what exercise type.
    [[SIAlertView appearance] setTitleFont:alertViewTitleFont];
    [[SIAlertView appearance] setTitleColor:color];
    [[SIAlertView appearance] setMessageColor:color];
    [[SIAlertView appearance] setCornerRadius:4];
    [[SIAlertView appearance] setShadowRadius:0];
    [[SIAlertView appearance] setViewBackgroundColor:WHITE_COLOR];
    [[SIAlertView appearance] setButtonColor:color];
    [[SIAlertView appearance] setDestructiveButtonColor:color];
    [[SIAlertView appearance] setCancelButtonColor:color];
    [[SIAlertView appearance] setButtonFont:alertViewButtonFont];
    [[SIAlertView appearance] setMessageFont:alertViewMessageFont];
    [[SIAlertView appearance] setMessageColor:LIGHT_GRAY_COLOR];
}

//Sets the selected background color for UITableViews.
+ (UIView *)tableViewSelectionColorSet:(UITableViewCell *)cell {
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = WHITE_COLOR;
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];
    return bgColorView;
}

//Draws the view for the TableView header.
+ (UIView *)drawViewForTableViewHeader:(UITableView*)tableView {
    //Create a view for the header.
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    [view setBackgroundColor:WHITE_COLOR];
    return view;
}

//Returns the color based off of the difficulty passed to it.
+ (UIColor *)determineDifficultyColor:(NSString *)difficulty {
    if ([difficulty isEqualToString:@"Easy"])
        return EASY_GREEN_COLOR;
    else if ([difficulty isEqualToString:@"Intermediate"])
        return INTERMEDIATE_BLUE_COLOR;
    else if ([difficulty isEqualToString:@"Hard"])
        return HARD_RED_COLOR;
    else if ([difficulty isEqualToString:@"Very Hard"])
        return [UIColor blackColor];
    return LIGHT_GRAY_COLOR;
}

/*---------------------------*/
#pragma mark - Journal Tools
/*---------------------------*/



/*---------------------------*/
#pragma mark - Exercises Tools
/*---------------------------*/

//Converts a muscle string to the muscle name in the database.
+ (NSString *)convertMuscleNameToDatabaseStandard:(NSString*)muscle {
    if ([muscle isEqualToString:@"Abdominal"]) {
        muscle = @"Abdominals";
    }
    else if ([muscle isEqualToString:@"Chest"]) {
        muscle = @"Pectoralis Major";
    }
    else if ([muscle isEqualToString:@"Forearms"]) {
        muscle = @"Brachioradialis";
    }
    else if ([muscle isEqualToString:@"Neck"]) {
        muscle = @"Trapezius";
    }
    else if ([muscle isEqualToString:@"Quadriceps"]) {
        muscle = @"Quadricep";
    }
    else if ([muscle isEqualToString:@"Shoulder"]) {
        muscle = @"Deltoid";
    }
    else if ([muscle isEqualToString:@"Wrist"]) {
        muscle = @"Wrist Flexor";
    }
    else if ([muscle isEqualToString:@"Glutes"]) {
        muscle = @"Gluteus";
    }
    else if ([muscle isEqualToString:@"Lats"]) {
        muscle = @"Latissimus Dorsii";
    }
    
    else if ([muscle isEqualToString:@"Lower Back"]) {
        muscle = @"Erector Spinae";
    }
    
    return muscle;
}

//Checks if a passed exercises is in the passed array.
+ (BOOL)exerciseInArray:(NSMutableArray*)exerciseArray {
    return NO;
}

//Deletes the passed exercises from the passed array.
+ (NSMutableArray*)deleteSelectedExercise:(NSMutableArray*)exerciseArray exercise:(id *)exercise {
    return nil;
   }

/*---------------------------*/
#pragma mark - Workout Tools
/*---------------------------*/

//Returns the count of exercises in a workout.
+ (NSUInteger)numExercisesInWorkout:(id *)workout {
    return nil;
}

/*------------------------*/
#pragma mark - Liked Tools
/*------------------------*/

/*-----------------------------------*/
#pragma mark - User Preferences Tools
/*-----------------------------------*/

//Checks if it is the users first launch.
+ (BOOL)isUsersFirstLaunch {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:USER_FIRST_LAUNCH]) {
        return YES;
    }
    else {
        return NO;
    }
}

//Checks a users preference, bool preferences only.
+ (BOOL)checkUserPreference:(NSString *)key {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:key]) {
        return YES;
    }
    else {
        return NO;
     }
}

//Updates a users preference key with their selection.
+ (void)updateBoolForKey:(NSString *)key boolValue:(BOOL)boolValue {
    [[NSUserDefaults standardUserDefaults] setBool:boolValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:PREFERENCE_CHANGE_NOTIFICATION object:nil];
}

//Updates a users preference key string value.
+ (void)updateValueForKey:(NSString *)key stringValue:(NSString*)stringValue {
    [[NSUserDefaults standardUserDefaults] setObject:stringValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:PREFERENCE_CHANGE_NOTIFICATION object:nil];
}

//Resets all of the users preferences to our suggested preferences.
+ (void)resetUserPreferences {
    
    //General Preferences
    [self updateBoolForKey:PREFERENCE_TUTORIAL_MESSAGES boolValue:YES];
    [self updateBoolForKey:PREFERENCE_AUTO_DATABASE_UPDATES boolValue:YES];
    [self updateBoolForKey:PREFERENCE_LIST_VIEW boolValue:NO];
    [self updateValueForKey:PREFERENCE_DEFAULT_LAUNCH_MODULE stringValue:@"Journal"];
    
    
    [self updateBoolForKey:PREFERENCE_CALENDAR_WEEKS boolValue:NO];
    [self updateBoolForKey:PREFERENCE_HIGHLIGHT_WEEKENDS boolValue:YES];
    [self updateBoolForKey:PREFERENCE_SIMPLE_MODE boolValue:NO];
    [self updateValueForKey:PREFERENCE_CALENDAR_VIEW stringValue:@"Month"];
    [self updateValueForKey:PREFERENCE_CALENDAR_SELECTED_DATE stringValue:@"Today"];
    
    [self updateBoolForKey:PREFERENCE_INTELLIGENT_MODE boolValue:YES];
    [self updateBoolForKey:PREFERENCE_ALWAYS_FOCUSED boolValue:NO];
    [self updateBoolForKey:PREFERENCE_SCIENTIFIC_NAMES boolValue:NO];
    [self updateValueForKey:PREFERENCE_EXERCISES_RECENTS_SHOWN stringValue:@"25"];
    [self updateValueForKey:PREFERENCE_DEFAULT_EXERCISES_VIEW stringValue:@"Body Zone"];

    [self updateBoolForKey:PREFERENCE_WORKOUT_SECTIONS boolValue:YES];
    [self updateValueForKey:PREFERENCE_DEFAULT_WORKOUTS_VIEW stringValue:@"Categories"];
    
    [self updateValueForKey:PREFERENCE_DEFAULT_LIKED_VIEW stringValue:@"Exercises"];
}

+ (NSDictionary *)returnGeneralPlist {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"StayHealthyGeneral" ofType:@"plist"];
    return [[NSDictionary alloc] initWithContentsOfFile:plistPath];
}

@end
