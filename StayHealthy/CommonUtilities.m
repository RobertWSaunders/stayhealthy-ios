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

+ (NSString *) shortAppVersionNumber {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
}

+ (NSString *) appBuildNumber {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
}

+ (NSString *)installedDatabaseVersion {
    return @"1.0.0";
}

+ (NSString *)hexBuildNumber {
    return [NSString stringWithFormat:@"%lX", (unsigned long)[[self appBuildNumber] integerValue]];
}

/************************************************/
#pragma mark - Date Formatting Tools/Calculations
/************************************************/

+ (NSString *)returnDateInString:(NSDate *)date {
    NSString *dateString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSMutableArray*)arrayOfDays:(NSDate *)startDate endDate:(NSDate *)endDate {
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
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *todayComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:nextDate];
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

+ (NSInteger)numberOfDaysBetweenDates:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:startDate];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:endDate];
    
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];
    return [difference day];
}

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

+ (NSString *)returnReadableTime:(NSDate *)date {
    NSString *timeText;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"h:mm a"];
    timeText = [formatter stringFromDate:date];
    return timeText;
}

+ (NSString *)calculateTime:(NSDate *)createdDate
{
    NSString *value;
    
    if (createdDate != nil)
    {
        createdDate                     = [self resetTime:createdDate];
        NSDate *currentDate             = [[NSDate alloc] init];
        currentDate                     = [self resetTime:currentDate];
        NSCalendar *gregorian           = [NSCalendar currentCalendar];
        NSUInteger unitFlags            = NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit;
        NSDateComponents *components    = [gregorian components:unitFlags fromDate:createdDate toDate:currentDate options:0];
        
        NSInteger months                = [components month];
        NSInteger weeks                 = [components week];
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

+ (NSDate *) resetTime:(NSDate *)date
{
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

+ (NSDate *)addHourToDate:(NSDate *)date hoursToAdd:(NSInteger)numHours {
    NSDate *hourAddedDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *endDateComponents = [[NSDateComponents alloc] init];
    [endDateComponents setHour:numHours];
    hourAddedDate = [calendar dateByAddingComponents:endDateComponents toDate:date options:0];
    
    return hourAddedDate;
}

+ (NSDate *)dateWithRoundedMinutes:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *componentsForCurrentDay = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit| NSYearCalendarUnit) fromDate:date];
    
    NSInteger hour = [componentsForCurrentDay hour];
    NSInteger day  = [componentsForCurrentDay day];
    NSInteger weekday  = [componentsForCurrentDay weekday];
    NSInteger month  = [componentsForCurrentDay month];
    NSInteger year  = [componentsForCurrentDay year];
    
    //Round today's date to the nearest 5 minutes.
    NSDateComponents *dateTime = [[NSCalendar currentCalendar] components:NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:date];
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

+ (NSDate *)dateWithOutTime:(NSDate *)dateWithTime {
    if(dateWithTime == nil )
        dateWithTime = [NSDate date];
    
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:dateWithTime];
    
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

/************************************/
#pragma mark - User Information Tools
/************************************/

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

+ (Boolean)emailIsValid:(NSString *)strEmail {
    // first look for an "@" symbol
    NSRange rangeAt = [strEmail rangeOfString:@"@"];
    if(rangeAt.location != NSNotFound) {
        // now make sure there's a "." after the "@" symbol
        NSString *strAfterAt = [strEmail substringFromIndex:rangeAt.location];
        NSRange rangeDot = [strAfterAt rangeOfString:@"."];
        if(rangeDot.location != NSNotFound) {
            if(![strAfterAt hasSuffix:@"."]) {
                return YES;
            }
        }
    }
    return NO;
}

/***************************/
#pragma mark - Useful Tools
/***************************/

+ (NSString *) returnUniqueID {
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (__bridge NSString *)string;
}

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

/****************************************/
#pragma mark - StayHealthy Specific Tools
/****************************************/

+ (NSDictionary *)returnGeneralPlist {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"StayHealthyGeneral" ofType:@"plist"];
    return [[NSDictionary alloc] initWithContentsOfFile:plistPath];
}

+ (NSString *)createExerciseQuery:(NSUInteger)index muscles:(NSArray *)muscleArray {
    NSString *table;
     NSString *query = @"";
    if (index == 0) {
        table = STRENGTH_DB_TABLENAME;
    }
    else if (index == 1){
        table = STRETCHING_DB_TABLENAME;
    }
    else {
        table = WARMUP_DB_TABLENAME;
    }
    
    int i = 0;
    if (muscleArray == nil) {
            query = [NSString stringWithFormat:@"SELECT * FROM %@",table];
    }
    else {
        
    for (NSString *muscle in muscleArray) {
        NSString *mucleInArray = muscle;
        mucleInArray = [self convertMuscleNameToDatabaseStandard:muscle];
        if (mucleInArray != nil) {
            if (i == 0) {
                 query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE exercisePrimaryMuscle LIKE '%@'",table,mucleInArray];
            }
            else {
                query = [query stringByAppendingString:[NSString stringWithFormat:@" UNION ALL SELECT * FROM %@ WHERE exercisePrimaryMuscle LIKE '%@'",table,mucleInArray]];
            }
           
        }
        i++;
    }
    }
    
    query = [query stringByAppendingString:@" ORDER BY exerciseName COLLATE NOCASE"];
    NSLog(@"%@",query);
    
   return query;
}

+ (NSString *)createExerciseQueryFromExerciseIds:(NSMutableArray *)exerciseIDs table:(NSString*)table {
    
    NSString *exerciseIdentifiers = [exerciseIDs componentsJoinedByString:@","];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE exerciseIdentifier IN (%@)",table,exerciseIdentifiers];
    
    return query;
}

+ (NSString *)createWorkoutQueryFromWorkoutIds:(NSMutableArray *)workoutIDs table:(NSString*)table {
    
    NSString *workoutIdentifiers = [workoutIDs componentsJoinedByString:@","];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE workoutIdentifier IN (%@)",table,workoutIdentifiers];
    
    return query;
}



+(NSString*)convertMuscleNameToDatabaseStandard:(NSString*)muscle {
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

+(BOOL) dateExistsYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
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

//Returns the path to the database.
+(NSString *)returnDatabasePath:(NSString*)databaseName {
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

+ (SHExercise *)getRandomExercise:(exerciseTypes)exerciseType muscle:(NSString*)muscle {
    
    NSString *query;
    
    muscle = [self convertMuscleNameToDatabaseStandard:muscle];
    
    if (exerciseType == strength) {
        query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE exercisePrimaryMuscle LIKE '%@' ORDER BY RANDOM() LIMIT 1",STRENGTH_DB_TABLENAME,muscle];
    }
    
    else {
        query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE exercisePrimaryMuscle LIKE '%@' ORDER BY RANDOM() LIMIT 1",STRETCHING_DB_TABLENAME,muscle];
    }
    
   // NSMutableArray *array = [[SHDataHandler getInstance] performExerciseStatement:query];
  /*
    if (array.count > 0)
        return [array objectAtIndex:0];
    */
    return nil;
}

//Returns an array of SHExercises that are in the workout that is passed.
+ (NSMutableArray*)getWorkoutExercises:(SHWorkout*)workout {
    
    //Get the exercises in the workout identifiers.
    NSArray *exerciseIdentifiers = [workout.workoutExerciseIdentifiers componentsSeparatedByString:@","];
    
    NSString *exerciseTypesWithoutSpaces = [workout.workoutExerciseTypes stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //Get the exercises in the workouts type.
    NSArray *exerciseTypes = [exerciseTypesWithoutSpaces componentsSeparatedByString:@","];
    
    //Reference the platform.
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    //Initialize a array that will be retured.
    NSMutableArray *exercises = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < exerciseIdentifiers.count; i++) {
        //Create a new exercise.
        SHExercise *exercise = [[SHExercise alloc] init];
        NSArray *tempExerciseArray = [[NSArray alloc] init];
        /*
        if ([[exerciseTypes objectAtIndex:i] isEqualToString:@"stretching"]) {
            tempExerciseArray = [dataHandler performExerciseStatement:[self generateWorkoutExerciseQuery:stretching exerciseIdentifier:exerciseIdentifiers[i]]];
        }
        else if ([[exerciseTypes objectAtIndex:i] isEqualToString:@"strength"]) {
            tempExerciseArray = [dataHandler performExerciseStatement:[self generateWorkoutExerciseQuery:strength exerciseIdentifier:exerciseIdentifiers[i]]];
        }
        else {
            tempExerciseArray = [dataHandler performExerciseStatement:[self generateWorkoutExerciseQuery:warmup exerciseIdentifier:exerciseIdentifiers[i]]];
        }*/
        
        if (tempExerciseArray.count > 0) {
            //Get the exercise from the searched statement.
            exercise = [tempExerciseArray objectAtIndex:0];
            //Add the exercises to the array.
            [exercises addObject:exercise];
        }
    }
    
    return exercises;
}

//Returns an array of SHExercises that are in the workout that is passed.
+ (NSMutableArray*)getCustomWorkoutExercises:(SHCustomWorkout*)workout {
    
    //Get the exercises in the workout identifiers.
    NSArray *exerciseIdentifiers = [workout.workoutExerciseIDs componentsSeparatedByString:@","];
    
    NSString *exerciseTypesWithoutSpaces = [workout.exerciseTypes stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //Get the exercises in the workouts type.
    NSArray *exerciseTypes = [exerciseTypesWithoutSpaces componentsSeparatedByString:@","];
    
    //Reference the platform.
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    //Initialize a array that will be retured.
    NSMutableArray *exercises = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < exerciseIdentifiers.count; i++) {
        //Create a new exercise.
        SHExercise *exercise = [[SHExercise alloc] init];
        NSArray *tempExerciseArray = [[NSArray alloc] init];
        /*
        if ([[exerciseTypes objectAtIndex:i] isEqualToString:@"stretching"]) {
            tempExerciseArray = [dataHandler performExerciseStatement:[self generateWorkoutExerciseQuery:stretching exerciseIdentifier:exerciseIdentifiers[i]]];
        }
        else if ([[exerciseTypes objectAtIndex:i] isEqualToString:@"strength"]) {
            tempExerciseArray = [dataHandler performExerciseStatement:[self generateWorkoutExerciseQuery:strength exerciseIdentifier:exerciseIdentifiers[i]]];
        }
        else {
            tempExerciseArray = [dataHandler performExerciseStatement:[self generateWorkoutExerciseQuery:warmup exerciseIdentifier:exerciseIdentifiers[i]]];
        }
        */
        if (tempExerciseArray.count > 0) {
            //Get the exercise from the searched statement.
            exercise = [tempExerciseArray objectAtIndex:0];
            //Add the exercises to the array.
            [exercises addObject:exercise];
        }
    }
    
    return exercises;
}


//Returns the count of exercises in a workout.
+ (NSUInteger)numExercisesInWorkout:(SHWorkout*)workout {
    //Get the exercises in the workout identifiers.
    NSArray *exerciseIdentifiers = [workout.workoutExerciseIdentifiers componentsSeparatedByString:@","];
    //Count the list which is equal to the number of exercises.
    return [exerciseIdentifiers count];
}

//Returns the count of exercises in a workout.
+ (NSUInteger)numExercisesInCustomWorkout:(SHCustomWorkout*)workout {
    //Get the exercises in the workout identifiers.
    NSArray *exerciseIdentifiers = [workout.workoutExerciseIDs componentsSeparatedByString:@","];
    //Count the list which is equal to the number of exercises.
    return [exerciseIdentifiers count];
}

+ (NSString *)generateWorkoutExerciseQuery:(exerciseTypes)exerciseType exerciseIdentifier:(NSString*)exerciseIdentifier {
    switch (exerciseType) {
        case strength:
            return [NSString stringWithFormat:@"SELECT * FROM %@ WHERE exerciseIdentifier LIKE '%@'",STRENGTH_DB_TABLENAME,exerciseIdentifier];
            break;
        case stretching:
            return [NSString stringWithFormat:@"SELECT * FROM %@ WHERE exerciseIdentifier LIKE '%@'",STRETCHING_DB_TABLENAME,exerciseIdentifier];
            break;
        case warmup:
            return [NSString stringWithFormat:@"SELECT * FROM %@ WHERE exerciseIdentifier LIKE '%@'",WARMUP_DB_TABLENAME,exerciseIdentifier];
            break;
        default:
            break;
    }
    return nil;
}

+ (BOOL)exerciseInArray:(NSMutableArray*)exerciseArray exercise:(SHExercise*)exercise {
    for (SHExercise *exerciseInArray in exerciseArray) {
        if ([exerciseInArray.exerciseType isEqualToString:exercise.exerciseType] && [exerciseInArray.exerciseIdentifier isEqualToString:exercise.exerciseIdentifier]) {
            return YES;
        }
    }
    return NO;
}

+ (NSMutableArray*)deleteSelectedExercise:(NSMutableArray*)exerciseArray exercise:(SHExercise*)exercise {
    for (SHExercise *exerciseInArray in exerciseArray) {
        if ([exerciseInArray.exerciseType isEqualToString:exercise.exerciseType] && [exerciseInArray.exerciseIdentifier isEqualToString:exercise.exerciseIdentifier]) {
            [exerciseArray removeObject:exerciseInArray];
            return exerciseArray;
        }
    }
    return exerciseArray;
}

+ (BOOL)isInternetConnection {
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        return NO;
    } else {
       return YES;
    }
}

+ (void)setTintColor:(UIColor*)color {
    //Set the appearance of the navigation bar. Set the text color to BLUE_COLOR constant.
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
    
    [[UINavigationBar appearance] setTintColor:color];
    //Set the tint color of all segmented controls.
    [[UISegmentedControl appearance] setTintColor:color];
    //Set the tint color for all UIToolbars.
    [[UIToolbar appearance] setTintColor:color];
}

+ (BOOL)checkUserPreference:(NSString *)key {
    if ([[NSUserDefaults standardUserDefaults] boolForKey:key]) {
        return YES;
    }
    else {
        return NO;
     }
}

+ (BOOL)isUsersFirstLaunch {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:USER_FIRST_LAUNCH]) {
        return YES;
    }
    else {
        return NO;
    }
}

+ (void)updateBoolForKey:(NSString *)key boolValue:(BOOL)boolValue {
    [[NSUserDefaults standardUserDefaults] setBool:boolValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:PREFERENCE_CHANGE_NOTIFICATION object:nil];
}

+ (void)updateValueForKey:(NSString *)key stringValue:(NSString*)stringValue {
    [[NSUserDefaults standardUserDefaults] setObject:stringValue forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:PREFERENCE_CHANGE_NOTIFICATION object:nil];
}

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

+ (UIColor*)returnModuleColor:(modules)module {
    if (module == journal) {
        return JOURNAL_COLOR;
    }
    else if (module == exercises) {
        return WORKOUTS_COLOR;
    }
    else if (module == workouts) {
        return WORKOUTS_COLOR;
    }
    else {
        return LIKED_COLOR;
    }
}

@end
