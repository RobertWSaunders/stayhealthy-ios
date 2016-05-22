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

/**********************************/
#pragma mark - View Loading Methods
/**********************************/

//Called when the view loads.
- (void)viewDidLoad {
    [super viewDidLoad];

    //Remove automatically adjusting scroll view insets.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //Configure the view with the calendar and do setup required.
    [self initialViewConfiguration];
    
    //Set notification observers.
    [self setNotificationObservers];
}

//Confirgure the view on the initial load. 
- (void)initialViewConfiguration {
    
    //Create reference to a calendar.
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    //Create the maximum and minimum date for the calendar.
    NSDateComponents *components = [NSDateComponents new];
    components.year = -10;
    NSDate *minDate = [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
    components.year = 10;
    NSDate *maxDate = [calendar dateByAddingComponents:components toDate:[NSDate date] options:0];
    
    //Set the minimum date and the maximum date for the calendar.
    self.calendarView.minDate = minDate;
    self.calendarView.maxDate = maxDate;

    //Check the users preferences.
    [self checkPreferences];
    
    //Set the calendar view frame dependant on the device.
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_CALENDAR_VIEW] isEqualToString:@"Month"]) {
        
        //Set the calendar view to be month.
        self.calendarView.viewMode = TKCalendarViewModeMonth;
        
        if (IS_IPHONE_6) {
            self.calendarPlaceholderViewHeight.constant = 220.0f;
            self.calendarView = [[TKCalendar alloc] initWithFrame:CGRectMake(self.calendarPlaceholderView.frame.origin.x, 0, self.view.frame.size.width, 220)];
        }
        else if (IS_IPHONE_5) {
            self.calendarPlaceholderViewHeight.constant = 220.0f;
        }
        else if (IS_IPHONE_6P) {
            self.calendarPlaceholderViewHeight.constant = 220.0f;
        }
        else if (IS_IPHONE_4_OR_LESS) {
            self.calendarPlaceholderViewHeight.constant = 220.0f;
        }
        else {
            //Set the theme for iPad
            self.calendarView.theme = [TKCalendarIPadTheme new];
            self.calendarView = [[TKCalendar alloc] initWithFrame:CGRectMake(self.calendarPlaceholderView.frame.origin.x, 0, self.view.frame.size.width, self.calendarPlaceholderView.frame.size.height)];
        }
        
        //Change the appearance of the calendar for month mode.
        TKCalendarMonthPresenter *presenter = (TKCalendarMonthPresenter *)self.calendarView.presenter;
        presenter.titleHidden = YES;
        presenter.style.backgroundColor = [UIColor whiteColor];
        presenter.style.dayNameCellHeight = 24.0f;
        presenter.style.dayNameTextEffect = TKCalendarTextEffectUppercase;
        presenter.style.weekNumberCellWidth = 30.0f;
    }
    else {
        self.calendarPlaceholderViewHeight.constant = 80.0f;
        self.calendarView = [[TKCalendar alloc] initWithFrame:CGRectMake(self.calendarPlaceholderView.frame.origin.x, 0, self.view.frame.size.width, 80.0f)];
        self.calendarView.viewMode = TKCalendarViewModeWeek;
        
        //Change the appearance of the calendar for week mode.
        TKCalendarWeekPresenter *weekPresenter = (TKCalendarWeekPresenter *)self.calendarView.presenter;
        weekPresenter.titleHidden = YES;
        weekPresenter.style.backgroundColor = [UIColor whiteColor];
        weekPresenter.style.dayNameCellHeight = 24.0f;
        weekPresenter.style.dayNameTextEffect = TKCalendarTextEffectUppercase;
        weekPresenter.style.weekNumberCellWidth = 30.0f;
    }
    //Disable the pinch zoom feature on the calendar.
    self.calendarView.allowPinchZoom = NO;

    events = [NSMutableArray new];
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

    //Set the selected date on the calendar.
    [self chooseSelectedDate];
    
    //Set the navigation bar title to the selected date.
    [self setNavigationBarTitleToSelectedDate];
    
    //Add the calendar view to the placeholder view.
    [self.calendarPlaceholderView addSubview:self.calendarView];
    
    //Set the datasourse for the calendar view.
    self.calendarView.dataSource = self;
    self.calendarView.delegate = self;
}

//Check the users preferences.
- (void)checkPreferences {
    //Depenging on the users preferences display the calendar a certain way.
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_CALENDAR_VIEW] isEqualToString:@"Month"]) {
        
        //Set the view mode to month.
        self.calendarView.viewMode = TKCalendarViewModeMonth;
        
        //Make reference to the month presenter.
        TKCalendarMonthPresenter *presenter = (TKCalendarMonthPresenter *)self.calendarView.presenter;
        
        //Update the presenter.
        [presenter update:YES];
        
        //Hide the week numbers if the user wants.
        if ([CommonUtilities checkUserPreference:PREFERENCE_CALENDAR_WEEKS]) {
            presenter.weekNumbersHidden = NO;
        }
        else {
            presenter.weekNumbersHidden = YES;
        }
        
        self.calendarPlaceholderViewHeight.constant = 220.0f;
    }
    else {
        
        //Set the view mode to week.
        self.calendarView.viewMode = TKCalendarViewModeWeek;
        
        //Make reference to the week presenter.
        TKCalendarWeekPresenter *weekPresenter = (TKCalendarWeekPresenter *)self.calendarView.presenter;
        
        //Update the presenter.
        [weekPresenter update:YES];
        
        //Hide the week numbers if the user wants.
        if ([CommonUtilities checkUserPreference:PREFERENCE_CALENDAR_WEEKS]) {
            weekPresenter.weekNumbersHidden = NO;
        }
        else {
            weekPresenter.weekNumbersHidden = YES;
        }
        
        self.calendarPlaceholderViewHeight.constant = 80.0f;
    }
}

//Observes for any notification observers.
- (void)setNotificationObservers {
    //Observe the preference notification, listens for any changes in preferences.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkPreferences) name:PREFERENCE_CHANGE_NOTIFICATION object:nil];
}

/*****************************************************/
#pragma mark - TKCalendar Delegate/Datasource Methods
/*****************************************************/

//This returns an array that holds the events for date, essentially puts the events on the calendar.
- (NSArray *)calendar:(TKCalendar *)calendar eventsForDate:(NSDate *)date {
    
    NSDateComponents *components = [self.calendarView.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    NSDate *endDate = [self.calendarView.calendar dateFromComponents:components];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(startDate <= %@) AND (endDate >= %@)", endDate, date];
    return [events filteredArrayUsingPredicate:predicate];
}

//What happens when the user selects a date.
- (void)calendar:(TKCalendar *)calendar didSelectDate:(NSDate *)date {
    
}

//What happens when the user navigates to a date.
- (void)calendar:(TKCalendar *) calendar didNavigateToDate:(NSDate *)date {
    
    //Change the title of the view controller to the date the user navigated to.
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM yyyy"];
    NSString *title = [formatter stringFromDate:date];
    //Set the title
    self.title = title;
    
    
}

//---------------------------
#pragma mark Calendar Visuals
//---------------------------

//Styles the calendar view accordingly.
- (void)calendar:(TKCalendar*)calendar updateVisualsForCell:(TKCalendarCell*)cell {
    
    if ([cell isKindOfClass:[TKCalendarDayNameCell class]]) {
        cell.style.textFont = [UIFont fontWithName:@"Avenir-Book" size:9.0f];
        if ([cell.label.text isEqualToString:@"SAT"] || [cell.label.text isEqualToString:@"SUN"]) {
            if ([CommonUtilities checkUserPreference:PREFERENCE_HIGHLIGHT_WEEKENDS]) {
                cell.style.backgroundColor = WHITE_COLOR; 
            }
        }
    }
    if ([cell isKindOfClass:[TKCalendarWeekNumberCell class]]) {
        NSDateComponents *comps = [self.calendarView.calendar components:NSCalendarUnitWeekOfYear fromDate:[NSDate new]];
        NSInteger weekNumber = comps.weekOfYear;
        if (weekNumber == cell.label.text.integerValue) {
            cell.style.textColor = JOURNAL_COLOR;
        }
    }
    if ([cell isKindOfClass:[TKCalendarDayCell class]]) {
        TKCalendarDayCell *dayCell = (TKCalendarDayCell*)cell;
        
        cell.style.textFont = [UIFont fontWithName:@"Avenir-Book" size:16.0f];
        
        if (dayCell.state & TKCalendarDayStateToday) {
            if (dayCell.state & TKCalendarDayStateSelected) {
                cell.style.shapeFill = [TKSolidFill solidFillWithColor:JOURNAL_COLOR];
                cell.style.shapeStroke = [TKStroke strokeWithColor:JOURNAL_COLOR];
                cell.style.textColor = [UIColor whiteColor];
            }
            else {
                cell.style.textColor = JOURNAL_COLOR;
            }
        }
        if (dayCell.state & TKCalendarDayStateWeekend) {
            //Check if user wants the weekends highlighted,
            if ([CommonUtilities checkUserPreference:PREFERENCE_HIGHLIGHT_WEEKENDS]) {
                dayCell.style.backgroundColor = WHITE_COLOR;
            }
        }
    }
    
    cell.style.bottomBorderWidth = 0.0f;
    cell.style.topBorderWidth = 0.0f;
    cell.style.rightBorderWidth = 0.0f;
    cell.style.leftBorderWidth = 0.0f;

}

//What happens when the calendar view mode changes.
- (void)calendar:(TKCalendar *)calendar didChangedViewModeFrom:(TKCalendarViewMode)previousViewMode to:(TKCalendarViewMode)viewMode {
    
    //Moving from Month View to Week View
    if (previousViewMode == TKCalendarViewModeMonth && viewMode == TKCalendarViewModeWeek) {
        
        //Change the appearance of the calendar for week mode.
        TKCalendarWeekPresenter *weekPresenter = (TKCalendarWeekPresenter *)self.calendarView.presenter;
        weekPresenter.titleHidden = YES;
        weekPresenter.style.backgroundColor = [UIColor whiteColor];
        weekPresenter.style.dayNameCellHeight = 24.0f;
        weekPresenter.style.dayNameTextEffect = TKCalendarTextEffectUppercase;
        weekPresenter.style.weekNumberCellWidth = 30.0f;
        
        //Set the frame of the calendar for week view.
        [self.calendarView setFrame:CGRectMake(self.calendarPlaceholderView.frame.origin.x, 0, self.view.frame.size.width, 80)];
    }
    //Moving from Week View to Month View
    else {
        
        //Change the appearance of the calendar for month mode.
        TKCalendarMonthPresenter *presenter = (TKCalendarMonthPresenter *)self.calendarView.presenter;
        presenter.titleHidden = YES;
        presenter.style.backgroundColor = [UIColor whiteColor];
        presenter.style.dayNameCellHeight = 24.0f;
        presenter.style.dayNameTextEffect = TKCalendarTextEffectUppercase;
        presenter.style.weekNumberCellWidth = 30.0f;
        
        //Set the frame of the calendar for month view.
        [self.calendarView setFrame:CGRectMake(self.calendarPlaceholderView.frame.origin.x, 0, self.view.frame.size.width, 220)];
    }
}

/*****************************************************/
#pragma mark - UITableView Delegate/Datasource Methods
/*****************************************************/

//Returns the number of sections of a TableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Returns the number of rows in the section of a TableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
        return 3;
    
}

//Cell for row at index path for the TableViews.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Set the identifier.
    static NSString *cellIdentifier = @"cellIdentifier";
    
    //Create the reference for the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //If the cell can't be found then just create one.
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
    
}

//Returns the height of the TableView.
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
    
}

//----------------------------------------------------
#pragma mark TableView Header and Footer Configuration
//----------------------------------------------------

//Returns the height of the header in the tableview.
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25.0f;
}

//Returns the view for the header in each section of the TableViews.
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //Create the view for the header in the TableView.
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    [headerView setBackgroundColor:[UIColor whiteColor]];
    
    //Now customize that view.
    //Create the label inside of the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, tableView.frame.size.width, 18)];
    [titleLabel setFont:tableViewHeaderFont];
    //Set the text color.
    titleLabel.textColor = JOURNAL_COLOR;
    
    //Add the label to the headerView.
    [headerView addSubview:titleLabel];
    
    titleLabel.text = @"Today, May 10th, 2016";

    //Finally return the header view.
    return headerView;
}

//--------------------------------------------
#pragma mark TableView Cell Selection Handling
//--------------------------------------------

//Controls what happens when a user presses a cell,
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

//---------------------------------
#pragma mark TableView Editing Mode
//---------------------------------

//Sets a trigger to determine if the user can edit a row.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

        return YES;

}

//Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

}

/**************************************************/
#pragma mark - UIScroll Delegate/Datasource Methods
/**************************************************/

//Toggles a boolean value to allow the calendar to select a date.
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

//Toggles a value that allows and disallows the user to scroll the scroller from tableview and collectionview.
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

}

//What happens when the scrollview has stopped dragging, we select our date on the calendar.
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

}


/****************************/
#pragma mark - Helper Methods
/****************************/

- (void)chooseSelectedDate {
    if (true) {
        //Default the selected day to today
        [self.calendarView setSelectedDate:[CommonUtilities dateWithOutTime:[NSDate date]]];
    }
    else if (false) {
        //Set the selected day to the last date with activity.
    }
    else {
        //Set the selected day to the next planned activity on a future date.
    }
}

- (void)setNavigationBarTitleToSelectedDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM yyyy"];
    NSString *title = [formatter stringFromDate:self.calendarView.selectedDate];
    [self.navigationItem setTitle:title];
}

/**********************/
#pragma mark - Actions
/**********************/

- (void)showWeekMode {
    NSLog(@"Show Week");
}

- (void)showMonthMode {
    NSLog(@"Show Month");
}

/********************************/
#pragma mark - Prepare For Segue
/********************************/

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


- (IBAction)addJournalEntry:(id)sender {
    [self performSegueWithIdentifier:@"addJournalEntry" sender:nil];
}
@end
