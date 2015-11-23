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
    
    
    //Fill the tableView arrays.
    [self fillTableViewArrays];
    
    //Checks what the user prefers to be displayed when the view is about to appear.
    if (![[NSUserDefaults standardUserDefaults] boolForKey:PREFERENCE_FINDEXERCISE_MODULE]) {
        self.recentlyViewedView.hidden = YES;
        self.muscleSelectionView.hidden = NO;
        segmentedControl.selectedSegmentIndex = 0;
    }
    else {
        [self checkRecentlyViewed];
        self.recentlyViewedView.hidden = NO;
        self.muscleSelectionView.hidden = YES;
        segmentedControl.selectedSegmentIndex = 1;
    }
    
    //Fetches and reloads the recentlyViewedExercises.
    [self fetchRecentlyViewedExercises];
    
    //Observe for changes. 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchRecentlyViewedExercises) name:StayHealthyCloudUpdate object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchRecentlyViewedExercises) name:exerciseNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchRecentlyViewedExercises) name:exerciseFavNotification object:nil];
    
    //By default warmup has not been pressed.
    warmupPressed = NO;
}

//What happens when the page is about to appear.
- (void)viewWillAppear:(BOOL)animated {
    
      [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_FIND_EXERICSE viewController:self message:@"Ok, so from here you can select a muscle you would like to find an exercise for, view your recently viewed exercises, press the magnifying glass in the top left to perform an advanced search, or press the dude running in the top right to find some awesome warmup exercises! You can also switch over to the other parts of the app with the bottom tab bar."];

}

/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the height of the cells inside the tableView.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.muscleSelectionTableView) {
        return 57.0f;
    }
    else {
        return 76.0f;
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
        return [recenltyViewedExercises count];
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
        MGSwipeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleSelectionCellIdentifier];
        
        //If the cell can't be found then just create one.
        if (cell == nil) {
            cell = [[MGSwipeTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:muscleSelectionCellIdentifier];
        }
        
        if (indexPath.section == 0) {
            cell.textLabel.text = [frontBodyMuscles objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [frontBodyMusclesScientificNames objectAtIndex:indexPath.row];
        }
        else {
            cell.textLabel.text = [backBodyMuscles objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [backBodyMusclesScientificNames objectAtIndex:indexPath.row];
        }
        
        cell.delegate = self;
        cell.textLabel.textColor = STAYHEALTHY_BLUE;
        cell.detailTextLabel.textColor = STAYHEALTHY_BLUE;
        cell.textLabel.font = tableViewTitleTextFont;
        cell.detailTextLabel.font = tableViewUnderTitleTextFont;
        
/*
        cell.leftButtons = @[[MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"Yoga.png"] backgroundColor:STAYHEALTHY_DARKERBLUE callback:^BOOL(MGSwipeTableCell *sender){
            self.selectedTableViewIndex = indexPath;
            typeSwiped = stretching;
            [self performSegueWithIdentifier:@"detailModal" sender:nil];
            return YES;
        }]];
            cell.leftExpansion.fillOnTrigger = YES;
            cell.leftExpansion.threshold = 2.0f;
            cell.leftExpansion.buttonIndex = 0;
            cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;
        
        
        //configure right buttons
        cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"Flex.png"] backgroundColor:STAYHEALTHY_DARKERBLUE callback:^BOOL(MGSwipeTableCell *sender) {
            self.selectedTableViewIndex = indexPath;
            typeSwiped = strength;
            [self performSegueWithIdentifier:@"detailModal" sender:nil];
            return YES;
        }]];
        cell.rightExpansion.fillOnTrigger = YES;
        cell.rightExpansion.threshold = 2.0f;
        cell.rightExpansion.buttonIndex = 0;
        cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
    */
        
        //Return the cell.
        return cell;
    }
    else {
        static NSString *recentlyViewedCellIdentifier = @"recentlyViewedCellIdentifier";
        
        //Create the reference for the cell.
        ExerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recentlyViewedCellIdentifier];
        
        //If the cell can't be found then just create one.
        if (cell == nil) {
            cell = [[ExerciseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recentlyViewedCellIdentifier];
        }
        
        SHExercise *exercise = [recenltyViewedExercises objectAtIndex:indexPath.row];
        
        cell.exerciseName.text = exercise.exerciseName;
        cell.difficulty.text = exercise.exerciseDifficulty;
        cell.difficulty.textColor = [CommonSetUpOperations determineDifficultyColor:exercise.exerciseDifficulty];
       
        cell.equipment.text = exercise.exerciseEquipment;
        NSString *trimmedString = [exercise.exerciseEquipment stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        
        if ([trimmedString isEqualToString:@"null"])
            cell.equipment.text = @"No Equipment";
        else
            cell.equipment.text = exercise.exerciseEquipment;
        
        //Load the exercise image on the background thread.
        [CommonSetUpOperations loadImageOnBackgroundThread:cell.exerciseImage image:[UIImage imageNamed:exercise.exerciseImageFile]];
        
        if ([exercise.liked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            cell.likeExerciseImage.hidden = NO;
            [cell.likeExerciseImage setImage:[UIImage imageNamed:@"likeSelectedColored.png"]];
             cell.likeExerciseImage.tintColor = STAYHEALTHY_BLUE;
        }
        else {
             cell.likeExerciseImage.hidden = YES;
        }
        
        //UILabel *timeLabel = (UILabel*)[cell viewWithTag:14];
        //timeLabel.text = [CommonUtilities calculateTime:exercise.lastViewed];
        
        //Set the selected cell background.
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
        /*
        //configure right buttons
        cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"workout.png"] backgroundColor:STAYHEALTHY_DARKERBLUE callback:^BOOL(MGSwipeTableCell *sender) {
            self.selectedTableViewIndex = indexPath;

            LogInfo(@"Add to workout");
            //[self performSegueWithIdentifier:@"detailModal" sender:nil];
            return YES;
        }]];
        cell.rightExpansion.fillOnTrigger = YES;
        cell.rightExpansion.threshold = 2.0f;
        cell.rightExpansion.buttonIndex = 0;
        cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
        */

        
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
        return 0.01f;
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
        titleLabel.text = @"Anterior Muscles";
    }
    else if (tableView == self.muscleSelectionTableView && section == 1) {
        //Second section is the back muscles.
        titleLabel.text = @"Posterior Muscles";
    }
    //Finally return the header view.
    return headerView;
}

//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

//What happens when the user selects a cell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedTableViewIndex = indexPath;
    if (tableView == self.muscleSelectionTableView) {
        [self selectRow:indexPath alertTitle:@"Exercise Type"];
    }
    else {
        //Go to the detail view if the user presses on a recently viewed exercise.
        [self performSegueWithIdentifier:@"detail" sender:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//--------------------------------------------
#pragma mark MCSwipeTableCell Delegate Methods
//--------------------------------------------

-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell canSwipe:(MGSwipeDirection) direction {
    NSIndexPath *myPath = [self.muscleSelectionTableView indexPathForCell:cell];
    if (myPath.section == 0 && direction == MGSwipeDirectionLeftToRight) {
        if (myPath.row == 1) {
            return NO;
        }
        else if (myPath.row == 2) {
            return NO;
        }
        else if (myPath.row == 3) {
            return NO;
        }
        else if (myPath.row == 5) {
            return NO;
        }
    }
    return YES;
}

/*****************************/
#pragma mark - Helper Methods
/*****************************/

//What happens when a user selects a cell in the tableView, method gets called from within didSelectRowAtIndexPath, presents the alert view to choose strength or stretching exercises.
- (void)selectRow:(NSIndexPath*)indexPath alertTitle:(NSString*)alertTitle{
    

    //No stretching for bicep, chest, forearms, oblique.
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"title" andMessage:nil];
    [alertView addButtonWithTitle:@"Strength"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                            alertIndex = 0;
                            [self performSegueWithIdentifier:@"viewExercises" sender:self];
                          }];
    
    //To accomodate for muscles that do not have any stretching exercises.
    if ([self setCheck:indexPath]) {
    [alertView addButtonWithTitle:@"Stretching"
                            type:SIAlertViewButtonTypeCancel
                        handler:^(SIAlertView *alertView) {
                                  alertIndex = 1;
                            [self performSegueWithIdentifier:@"viewExercises" sender:self];
                            }];
    }
    
    [alertView addButtonWithTitle:@"Cancel"
                             type:SIAlertViewButtonTypeCancel
                          handler:nil];
    
     alertView.title = alertTitle;
    [alertView show];
}

//Fetched the recently viewed exercises.
- (void)fetchRecentlyViewedExercises {
    
    dispatch_async(dispatch_get_main_queue(), ^{
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    //Fetches the recently viewed exercises, in Exercise object.
    NSArray *recenltyViewedExercisesData = [[SHDataHandler getInstance] getRecentlyViewedExercises];
    
    recenltyViewedExercises = [[NSMutableArray alloc] init];
    
    //Converts Exercise object to usable SHExercise object.
        for (int i = 0; i < recenltyViewedExercisesData.count; i++) {
            [recenltyViewedExercises addObject:[dataHandler convertExerciseToSHExercise:[recenltyViewedExercisesData objectAtIndex:i]]];
        }
        
    //Reload the recenltyviewed tableview to display the new exercises.
    [self.recentlyViewedTableView reloadData];
    });
    
}

//Checks to see if there are any recently viewed exercises to show.
- (void)checkRecentlyViewed {
    if (recenltyViewedExercises.count == 0) {
        //Presents alert if the user hasnt viewed any exercises lately.
        //[CommonSetUpOperations performTSMessage:@"Oops, looks like you haven't viewed any exercises yet!" message:@"" viewController:self canBeDismissedByUser:YES duration:5];
    }
}

//Fetches the data from the general plist and sets the arrays.
- (void)fillTableViewArrays {
    frontBodyMuscles = [CommonUtilities returnGeneralPlist][@"anteriorMuscles"];
    backBodyMuscles = [CommonUtilities returnGeneralPlist][@"posteriorMuscles"];
    frontBodyMusclesScientificNames = [CommonUtilities returnGeneralPlist][@"anteriorMusclesScientificNames"];
    backBodyMusclesScientificNames = [CommonUtilities returnGeneralPlist][@"posteriorMusclesScientificNames"];
    [CommonSetUpOperations styleAlertView];
}

//Checks if a tableView row can be chosen for a stretching exercise, not all muscles have stretches.
- (BOOL)setCheck:(NSIndexPath*)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 1) {
            return NO;
        }
        else if (indexPath.row == 2) {
            return NO;
        }
        else if (indexPath.row == 3) {
            return NO;
        }
        else if (indexPath.row == 5) {
            return NO;
        }
    }
    return YES;
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
            [self checkRecentlyViewed];
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

        UITableViewCell *cell  = [self.muscleSelectionTableView cellForRowAtIndexPath:self.selectedTableViewIndex];
        
        ExerciseListController *viewExercisesViewController = [[ExerciseListController alloc] init];
        
        viewExercisesViewController = segue.destinationViewController;
        
        NSString *muscleSelected = cell.textLabel.text;
        
        viewExercisesViewController.viewTitle = muscleSelected;
        
        if (warmupPressed) {
            viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:WARMUP_DB_TABLENAME muscle:nil];
            viewExercisesViewController.viewTitle = @"Warmup";
            warmupPressed = NO;
        }
        else if (alertIndex == 0) {
            viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:STRENGTH_DB_TABLENAME muscle:muscleSelected];
        }
        else if (alertIndex == 1) {
            viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:STRETCHING_DB_TABLENAME muscle:muscleSelected];
        }
    
    }
    else if ([segue.identifier isEqualToString:@"detail"]) {
        NSIndexPath *indexPath = [self.recentlyViewedTableView indexPathForSelectedRow];
        SHExercise *exercise = [recenltyViewedExercises objectAtIndex:indexPath.row];
        ExerciseDetailViewController *destViewController = segue.destinationViewController;
        destViewController.exerciseToDisplay = exercise;
        destViewController.viewTitle = exercise.exerciseName;
    }
    else if ([segue.identifier isEqualToString:@"detailModal"]) {
        
        UITableViewCell *cell  = [self.muscleSelectionTableView cellForRowAtIndexPath:self.selectedTableViewIndex];
        
        NSString *muscleSelected = cell.textLabel.text;
        
        UINavigationController *navController = segue.destinationViewController;
        ExerciseDetailViewController *destViewController = navController.viewControllers[0];
        
        SHExercise *randomExercise = [[SHExercise alloc] init];
        
        if (typeSwiped == strength) {
            randomExercise = [CommonUtilities getRandomExercise:strength muscle:muscleSelected];
        }
        else {
            randomExercise = [CommonUtilities getRandomExercise:stretching muscle:muscleSelected];
        }
        
        destViewController.viewTitle = [NSString stringWithFormat:@"Random %@ Exercise",muscleSelected];
        destViewController.modalView = YES;
        destViewController.exerciseToDisplay = randomExercise;
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
