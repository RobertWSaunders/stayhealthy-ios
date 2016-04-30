//
//  JournalViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-17.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "JournalViewController.h"

@interface JournalViewController ()

@end

@implementation JournalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.calendarView.dataSource = self;
    self.calendarView.delegate = self;
    
    self.calendarView.allowPinchZoom = false;

    
   
    
    events = [NSMutableArray new];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [NSDate date];
    for (int i = 0; i<10; i++) {
        TKCalendarEvent *event = [TKCalendarEvent new];
        event.title = @"Sample event";
        NSDateComponents *components = [calendar components:NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear fromDate:date];
        NSInteger random = arc4random()%20;
        components.day += random > 10 ? 20 - random : -random;
        event.startDate = [calendar dateFromComponents:components];
        components.hour += 2;
        event.endDate = [calendar dateFromComponents:components];
        event.eventColor = [UIColor redColor];
        [events addObject:event];
    }
    
    
    self.calendarView = [[TKCalendar alloc] initWithFrame:CGRectMake(self.calendarPlaceholderView.frame.origin.x, 0, self.view.frame.size.width, 310)];
     [self.calendarPlaceholderView addSubview:self.calendarView];
}

- (NSArray *)calendar:(TKCalendar *)calendar eventsForDate:(NSDate *)date
{
    NSDateComponents *components = [self.calendarView.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    NSDate *endDate = [self.calendarView.calendar dateFromComponents:components];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(startDate <= %@) AND (endDate >= %@)", endDate, date];
    return [events filteredArrayUsingPredicate:predicate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
