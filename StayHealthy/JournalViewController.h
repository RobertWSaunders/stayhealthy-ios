//
//  JournalViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-17.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TelerikUI/TelerikUI.h>

@interface JournalViewController : UIViewController <TKCalendarDataSource,TKCalendarDelegate> {
    NSMutableArray *events;
}

@property (weak, nonatomic) IBOutlet UIView *calendarPlaceholderView;

@property (strong,nonatomic) TKCalendar *calendarView;

@end
