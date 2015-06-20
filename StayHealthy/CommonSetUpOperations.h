//
//  CommonSetUpOperations.h
//  StayHealthy
//
//  Created by Student on 8/2/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TSMessage.h"

@interface CommonSetUpOperations : NSObject

//Styles a collectionview cell to the desired appearance.
+ (void)styleCollectionViewCell:(UICollectionViewCell*)collectionViewCell;

+ (void)performTSMessage:(NSString*)titleText message:(NSString*)message viewController:(UIViewController*)controllerForDisplay;

+ (NSDate *)dateWithOutTime:(NSDate *)Date;

+ (NSString *)returnDateInString:(NSDate *)date;

+ (NSString *)returnPrettyDate:(NSString*)stringDate format:(NSString*)format;

+ (NSMutableArray*)arrayOfDays:(NSDate*)startDate endDate:(NSDate*)endDate;

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime;



@end
