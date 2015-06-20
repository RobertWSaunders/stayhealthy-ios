//
//  CommonSetUpOperations.m
//  StayHealthy
//
//  Created by Student on 8/2/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import "CommonSetUpOperations.h"

@implementation CommonSetUpOperations

+ (void)styleCollectionViewCell:(UICollectionViewCell*)collectionViewCell {
     collectionViewCell.layer.masksToBounds = NO;
     collectionViewCell.layer.borderColor = [UIColor whiteColor].CGColor;
     collectionViewCell.layer.borderWidth = 2.0f;
     collectionViewCell.layer.shadowOpacity = 0.10f;
     collectionViewCell.layer.shadowRadius = 4.0f;
     collectionViewCell.layer.shadowOffset = CGSizeZero;
     collectionViewCell.layer.shadowPath = [UIBezierPath bezierPathWithRect: collectionViewCell.bounds].CGPath;
     collectionViewCell.layer.cornerRadius = 4.0f;
}

+ (void)performTSMessage:(NSString*)titleText message:(NSString*)message viewController:(UIViewController*)controllerForDisplay {
        [TSMessage showNotificationInViewController:controllerForDisplay
                                              title:titleText
                                           subtitle:message
                                              image:nil
                                               type:TSMessageNotificationTypeMessage
                                           duration:5
                                           callback:nil
                                        buttonTitle:nil
                                     buttonCallback:nil
                                         atPosition:TSMessageNotificationPositionTop
                                canBeDismisedByUser:YES];
}

//Return the date without time.
+ (NSDate *)dateWithOutTime:(NSDate *)Date {
    if(Date == nil )
        Date = [NSDate date];
    NSDateComponents* comps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:Date];
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

+ (NSString *)returnDateInString:(NSDate *)date {
    NSString *dateString;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

+ (NSString *)returnPrettyDate:(NSString*)stringDate format:(NSString*)format {
    // Convert date object to desired output format
    NSDateFormatter *dateFormatNormal = [[NSDateFormatter alloc] init];
    [dateFormatNormal setDateFormat:@"yyyy-MM-dd"];
    
    // Convert date object to desired output format
    NSDateFormatter *dateFormatDesired = [[NSDateFormatter alloc] init];
    [dateFormatDesired setDateFormat:format];
    
    NSDate *originalDate = [dateFormatNormal dateFromString:stringDate];
    
    NSString *desiredDate = [dateFormatDesired stringFromDate:originalDate];
    
    return desiredDate;
}

//This method returns an array of days between two days.
+ (NSMutableArray*)arrayOfDays:(NSDate*)startDate endDate:(NSDate*)endDate {

    NSMutableArray *arrayOfDaysFill = [[NSMutableArray alloc] init];
    [arrayOfDaysFill removeAllObjects];
    // [arrayOfDays addObject:[self dateWithOutTime:startDate]];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    NSString *startDateString = [dateFormatter stringFromDate:startDate];

    [arrayOfDaysFill addObject:startDateString];

    NSDate *nextDate;
    nextDate = startDate;

    for (int i = 0; i < [self daysBetweenDate:startDate andDate:endDate]-1; i++) {

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


+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;

    NSCalendar *calendar = [NSCalendar currentCalendar];

    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
                 interval:NULL forDate:toDateTime];

    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
                                               fromDate:fromDate toDate:toDate options:0];

    return [difference day];
}


@end
