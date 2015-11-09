//
//  CommonUtilities.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-06-20.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
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

/****************************************/
#pragma mark - StayHealthy Specific Tools
/****************************************/

+ (NSDictionary *)returnGeneralPlist {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"StayHealthyGeneral" ofType:@"plist"];
    return [[NSDictionary alloc] initWithContentsOfFile:plistPath];;
}

+ (NSString *)createExerciseQuery:(NSString *)table muscle:(NSString *)muscle {

    muscle = [self convertMuscleNameToDatabaseStandard:muscle];
    
    NSString *query = @"";
    if (muscle != nil) {
        query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE exercisePrimaryMuscle LIKE '%@' ORDER BY exerciseName COLLATE NOCASE",table,muscle];
    }
    else {
        query = [NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY exerciseName COLLATE NOCASE",table];
        
    }
    return query;
}

+ (NSString *)createExerciseQueryFromExerciseIds:(NSMutableArray *)exerciseIDs table:(NSString*)table {
    
    NSString *exerciseIdentifiers = [exerciseIDs componentsJoinedByString:@","];
    
    NSString *query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE exerciseIdentifier IN (%@)",table,exerciseIdentifiers];
    
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

+ (SHExercise *)getRandomExercise:(exerciseTypes)exerciseType muscle:(NSString*)muscle {
    
    NSString *query;
    
    muscle = [self convertMuscleNameToDatabaseStandard:muscle];
    
    if (exerciseType == strength) {
        query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE exercisePrimaryMuscle LIKE '%@' ORDER BY RANDOM() LIMIT 1",STRENGTH_DB_TABLENAME,muscle];
    }
    
    else {
        query = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE exercisePrimaryMuscle LIKE '%@' ORDER BY RANDOM() LIMIT 1",STRETCHING_DB_TABLENAME,muscle];
    }
    
    NSMutableArray *array = [[SHDataHandler getInstance] performExerciseStatement:query];
    
    if (array.count > 0)
        return [array objectAtIndex:0];
    
    return nil;
}

@end
