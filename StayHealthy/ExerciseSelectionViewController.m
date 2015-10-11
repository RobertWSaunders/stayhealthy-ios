//
//  ExerciseSelectionViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-16.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import "ExerciseSelectionViewController.h"

@implementation ExerciseSelectionViewController

/**********************************/
#pragma mark - View Loading Methods
/**********************************/

//Perform any set up for the view once it has loaded.
- (void)viewDidLoad {
    
    frontBodyMuscles = [CommonUtilities returnGeneralPlist][@"frontBodyMuscles"];
    backBodyMuscles = [CommonUtilities returnGeneralPlist][@"backBodyMuscles"];
    frontBodyMusclesScientificNames = [CommonUtilities returnGeneralPlist][@"frontBodyMusclesScientificNames"];
    backBodyMusclesScientificNames = [CommonUtilities returnGeneralPlist][@"backBodyMusclesScientificNames"];
    [CommonSetUpOperations styleAlertView];
    warmupPressed = NO;
    
}

/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the height of the cells inside the tableView.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.muscleSelectionTableView) {
        return 55.0f;
    }
    else {
        return 44.0f;
    }
}

//Returns the number of rows that should be displayed in the tableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.muscleSelectionTableView) {
        if (section == 0) {
            return [frontBodyMuscles count];
        }
        else {
            return [backBodyMuscles count];
        }
    }
    else {
        return 3;
    }
}

//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.muscleSelectionTableView) {
        return 2;
    }
    else {
        return 1;
    }
}

//Configures the cells at a specific indexPath.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.muscleSelectionTableView) {
        
        //Define the identifier.
        static NSString *muscleSelectionCellIdentifier = @"muscleSelectionCellIdentifier";
        
        //Create reference to the cell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleSelectionCellIdentifier];
        
        //If the cell can't be found then just create one.
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:muscleSelectionCellIdentifier];
        }
        
        if (indexPath.section == 0) {
            cell.textLabel.text = [frontBodyMuscles objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [frontBodyMusclesScientificNames objectAtIndex:indexPath.row];
        }
        else {
            cell.textLabel.text = [backBodyMuscles objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [backBodyMusclesScientificNames objectAtIndex:indexPath.row];
        }
        
        cell.textLabel.textColor = STAYHEALTHY_BLUE;
        cell.detailTextLabel.textColor = STAYHEALTHY_BLUE;
        cell.textLabel.font = tableViewTitleTextFont;
        cell.detailTextLabel.font = tableViewUnderTitleTextFont;
        
        //Return the cell.
        return cell;
    }
    else {
        static NSString *recentlyViewedCellIdentifier = @"recentlyViewedCellIdentifier";
        
        //Create the reference for the cell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recentlyViewedCellIdentifier];
        
        //If the cell can't be found then just create one.
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recentlyViewedCellIdentifier];
        }
        
        //Return the cell.
        return cell;
    }
}

//----------------------------------------------------
#pragma mark TableView Header and Footer Configuration
//----------------------------------------------------

//Sets the height for the header in the specific section.
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.muscleSelectionTableView) {
        return 25.0f;
    }
    else {
        return 0.01f;;
    }
}

//Sets the view for the header if you would like to configure a custom view.
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
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
    if (tableView == self.muscleSelectionTableView && section == 0) {
        //First section is the front muscles.
        titleLabel.text = @"Front Muscles";
    }
    else if (tableView == self.muscleSelectionTableView && section == 1) {
        //Second section is the back muscles.
        titleLabel.text = @"Back Muscles";
    }
    //Finally return the header view.
    return headerView;
}

//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

//What happens when the user selects a cell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedTableViewIndex = indexPath;
    [self selectRow:indexPath alertTitle:@"Exercise Type"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*****************************/
#pragma mark - Helper Methods
/*****************************/

//What happens when a user selects a cell in the tableView, method gets called from within didSelectRowAtIndexPath, presents the alert view to choose strength or stretching exercises.
- (void)selectRow:(NSIndexPath*)indexPath alertTitle:(NSString*)alertTitle{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"title" andMessage:nil];
    [alertView addButtonWithTitle:@"Strength"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                            alertIndex = 0;
                            [self performSegueWithIdentifier:@"viewExercises" sender:self];
                          }];
    [alertView addButtonWithTitle:@"Stretching"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                            alertIndex = 1;
                            [self performSegueWithIdentifier:@"viewExercises" sender:self];
                          }];
    [alertView addButtonWithTitle:@"Cancel"
                             type:SIAlertViewButtonTypeCancel
                          handler:nil];
    
     alertView.title = alertTitle;
    [alertView show];
}

/*********************/
#pragma mark - Actions
/*********************/

//What happens when the user changes the segmented control selected index.
- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.recentlyViewedView.hidden = YES;
            self.muscleSelectionView.hidden = NO;
            break;
        case 1:
            self.recentlyViewedView.hidden = NO;
            self.muscleSelectionView.hidden = YES;
            break;
        default:
            break;
    }
}

//What happens when the user presses the warmup button in the top right of the navigation bar.
- (IBAction)warmupButtonPressed:(id)sender {
    warmupPressed = YES;
    [self performSegueWithIdentifier:@"viewExercises" sender:nil];
}

/*******************************/
#pragma mark - Prepare For Segue
/*******************************/

//Notifies the view controller that a segue is about to be performed. Allows me to pass or set properties to the segues destination view controller.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"viewExercises"]) {

        UITableViewCell *cell  = [self.muscleSelectionTableView cellForRowAtIndexPath:selectedTableViewIndex];
        
        ExerciseListController *viewExercisesViewController = [[ExerciseListController alloc] init];
        
        viewExercisesViewController = segue.destinationViewController;
        
        NSString *muscleSelected = cell.textLabel.text;
        
        if (warmupPressed) {
            viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:WARMUP_DB_TABLENAME muscle:nil];
        }
        else if (alertIndex == 0) {
            viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:STRENGTH_DB_TABLENAME muscle:muscleSelected];
        }
        else if (alertIndex == 1) {
            viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:STRETCHING_DB_TABLENAME muscle:muscleSelected];
        }
    
    }
}

/**************************************/
#pragma mark - View Terminating Methods
/**************************************/

//Handles anything we need to clear or reset when the view is about to disappear.
-(void)viewWillDisappear:(BOOL)animated {
    //Dismiss any outstaning notifications.
    [TSMessage dismissActiveNotification];
}

@end
