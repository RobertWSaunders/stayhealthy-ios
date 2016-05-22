//
//  JournalViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-17.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JournalViewController : UIViewController <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,TKCalendarDelegate,TKCalendarDataSource> {
    NSMutableArray *events;
    NSMutableArray *fullArrayEvents;
    NSArray *sortedArrayOfEvents;
    
}

@property (retain) NSMutableArray *tableViewSections;
@property (retain) NSMutableDictionary *tableViewCells;

@property (weak, nonatomic) IBOutlet UIView *calendarPlaceholderView;

@property (strong,nonatomic) TKCalendar *calendarView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarPlaceholderViewHeight;
- (IBAction)addJournalEntry:(id)sender;

@end
