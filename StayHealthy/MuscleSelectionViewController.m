//
//  MuscleSelectionViewController.m
//  StayHealthy
//
//  Created by Student on 12/7/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
//


#import "MuscleSelectionViewController.h"

@interface MuscleSelectionViewController ()

@end

@implementation MuscleSelectionViewController

/*********************************/
#pragma mark - View Loading Methods
/*********************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    //Style the SIAlertViews to look good.
    [CommonSetUpOperations styleAlertView];
    
    //Set the scrollviews to not adjust to the insets, this adds a 60point gap between tableview and navigation bar.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //Arrays for 'selectMuscleTableView'
    //List of front muscles.
    frontBodyMuscles = [CommonRequests returnGeneralPlist][@"frontBodyMuscles"];
    //List of front muscles with their scientific names.
    frontBodyMusclesScientificNames = [CommonRequests returnGeneralPlist][@"frontBodyMusclesScientificNames"];
    //List of back muscles.
    backBodyMuscles = [CommonRequests returnGeneralPlist][@"backBodyMuscles"];
    //List of back muscles with their scientific names.
    backBodyMusclesScientificNames = [CommonRequests returnGeneralPlist][@"backBodyMusclesScientificNames"];
}

//View Will Appear, loaded just before the view appears.
-(void)viewWillAppear:(BOOL)animated {
    //Set the message for the first time on the view controller.
    //NSUser defaults, bool for key, just returns YES or NO is the key exists in the user defaults database.
    [CommonSetUpOperations setFirstViewTSMessage:@"MuscleSelectionViewController-FirstView" viewController:self message:@"Welcome to the exercise selection page! Here you can change between the muscle list and advanced search. Simply choose the muscle you'd like to exercise or you can use the advanced search to choose specifics, like the type of equipment, difficulty, muscle groups, if you want a more specific result. Looking for a warm-up? Press the running icon in the top right. Tap this message to dismiss."];
}

/*****************************************************/
#pragma mark - UITableView Delegate/Datasource Methods
/*****************************************************/

//Returns the height of the TableView.
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Set the height of the tableview cells to be the constant.
    return UITABLEVIEWCELL_HEIGHT;
}

//Returns the number of sections of a TableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //Return 2 (Front and Back) sections if the table view is the muscle list.
    if (tableView == self.selectMuscleTableView) {
        return 3;
    }
    //Return the number of sections recently viewed tableview.
    else if (tableView == self.recentlyViewedTableView) {
        return 1;
    }
    //Always return an else just for clarity.
    else {
        return 1;
    }
}

//Returns the number of rows in the section of a TableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //If the tableView is the selection muscles tableview set the number of rows to respective number of muscles.
    if (tableView == self.selectMuscleTableView) {
        //Using a switch statement instead of an if-else ladder.
        switch (section) {
            case 0:
                return 1;
                break;
            case 1:
                //Count of front muscle array.
                return [frontBodyMuscles count];
                break;
            case 2:
                //Count of back muscle array
                return [backBodyMuscles count];
                break;
            default:
                return 0;
                break;
        }
    }
    //Return recently viewed one section.
    else if (tableView == self.recentlyViewedTableView) {
        return 1;
    }
    //Always return an else just for clarity.
    else {
        return 1;
    }
}

//Returns the height of the header in the tableview.
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //Return no header for the recently viewed tableview search table view.
    if (tableView == self.recentlyViewedTableView) {
        return 0;
    }
    //Return 25 for the select muscle tableview.
    else if ((tableView == self.selectMuscleTableView) && (section == 1 || section == 2)) {
        return 25;
    }
    //Always return an else just for clarity.
    else {
        return 0;
    }
}

//Returns the view for the header in each section of the TableViews.
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //Create the view for the header in the TableView.
    UIView *headerView = [CommonSetUpOperations drawViewForTableViewHeader:tableView];
    
    //Now customize that view.
    //Create the label inside of the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, tableView.frame.size.width, 18)];
    [titleLabel setFont:tableViewHeaderFont];
    //Set the text color.
    titleLabel.textColor = STAYHEALTHY_BLUE;
    
    //Add the label to the headerView.
    [headerView addSubview:titleLabel];
    
    //Set the label text for the headers in the select TableView.
    if (tableView == self.selectMuscleTableView && section == 1) {
        //First section is the front muscles.
        titleLabel.text = @"Front Muscles";
    }
    else if (tableView == self.selectMuscleTableView &&  section == 2) {
        //Second section is the back muscles.
        titleLabel.text = @"Back Muscles";
    }
    //Finally return the header view.
    return headerView;
}


//Cell for row at index path for the TableViews.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.selectMuscleTableView) {
        //Define the identifier.
        static NSString *muscleItem = @"muscleItem";
    
        //Create reference to the cell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleItem];
    
        //If the cell can't be found then just create one.
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:muscleItem];
        }
        
        if (indexPath.section == 0) {
            cell.textLabel.text  =  @"Warmup Exercises";
            cell.detailTextLabel.text = @"View Warmup Exercises";
        }
        //If the section equals one just set the text accordingly.
        else if (indexPath.section == 1) {
            //Set the text equal to the front body muscles.
            cell.textLabel.text = [frontBodyMuscles objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [frontBodyMusclesScientificNames objectAtIndex:indexPath.row];
        }
        //If the section equals two just set the text accordingly.
        else if (indexPath.section == 2) {
            //Set the text equal to the back body muscles.
            cell.textLabel.text = [backBodyMuscles objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [backBodyMusclesScientificNames objectAtIndex:indexPath.row];
        }
        
        //Stlying the cells.
        //Using the contants referenced from the definitions file.
        cell.textLabel.font = tableViewTitleTextFont;
        cell.detailTextLabel.font = tableViewUnderTitleTextFont;
        cell.textLabel.textColor = STAYHEALTHY_BLUE;
        cell.detailTextLabel.textColor = STAYHEALTHY_BLUE;
        
        //Set the selection color.
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
    
        //Return the cell.
        return cell;
    
    }
    //This else is really for the recently viewed TableView.
    else {
        //Set the identifier.
        static NSString *recentlyViewedItem = @"recentlyViewedItem";
        
        //Create the reference for the cell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recentlyViewedItem];
        
        //If the cell can't be found then just create one.
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recentlyViewedItem];
        }
        
        //Return the cell.
        return cell;
    }
}

//Controls what happens when a user presses a cell,
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    //What happens when a user pressed on a cell on the select muscle cell.
    if (tableView == self.selectMuscleTableView) {

    }
    //What happens when a user pressed on a cell on the recently viewed TableView.
    else if (tableView == self.recentlyViewedTableView) {
        
    }
    //Then deselect the row once complete touch/select.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/********************************/
#pragma mark - Prepare For Segue
/*******************************/

//Handels what happens when a user performs a segue.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
   
}

/*****************************/
#pragma mark - Action Methods
/*****************************/

//What is fired when the user changes the value of the segment.
- (IBAction)segmentValueChanged:(UISegmentedControl*)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            //Set the views hidden correctly.
            [self setViewsHidden:NO second:YES];
            break;
        case 1:
            [self setViewsHidden:YES second:NO];
        default:
            break;
    }
}


/*****************************/
#pragma mark - Utility Methods
/*****************************/

//Creates the alet popup and handles the action when a user presses on the alert buttons.
-(void)selectRow:(NSIndexPath*)indexPath alertTitle:(NSString*)alertTitle{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"title" andMessage:nil];
    [alertView addButtonWithTitle:@"Strength"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                             
                          }];
    [alertView addButtonWithTitle:@"Stretching"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              
                          }];
    [alertView addButtonWithTitle:@"Cancel"
                             type:SIAlertViewButtonTypeCancel
                          handler:nil];
    [alertView show];
    //Set the alert title to the passed parameter.
    alertView.title = alertTitle;
}

//Sets the view hidden dependant on the boolean values passed to it.
-(void)setViewsHidden:(BOOL)muscleListHide second:(BOOL)recentlyViewed {
    self.muscleListView.hidden = muscleListHide;
    self.recentlyViewedExercisesView.hidden = recentlyViewed;
}

/**************************************/
#pragma mark - View Terminating Methods
/**************************************/

//View Will Disappear
-(void)viewWillDisappear:(BOOL)animated {
    //Dismiss any outstaning notifications.
    [TSMessage dismissActiveNotification];
}

@end
