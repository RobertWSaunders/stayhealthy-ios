//
//  ExerciseSelectionViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-16.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "ExerciseSelectionViewController.h"

@implementation ExerciseSelectionViewController

/**********************************/
#pragma mark - View Loading Methods
/**********************************/

//Perform any set up for the view once it has loaded.
- (void)viewDidLoad {
    //Generic settings no matter what mode the view is called for.
    //Fill the tableView arrays.
    [self fillTableViewsOnLoad];
    //Take the users preferences into consideration.
    [self checkPreferences];
    [self setNotificationObservers];
    //Style the default alerts.
    [CommonSetUpOperations styleAlertView];
    
    segmentedControl.selectedSegmentIndex = 1;
    
    //Do differernt configuration depending on what mode the view controller is called for.
    if (self.exerciseSelectionMode) {
        [self loadViewForExerciseSelection];
        self.toolbarTopMuscleSelection.constant = 0.0f;
        self.toolbarTopRecentlyViewed.constant = 0.0f;
    }
    else {
        self.toolbar.hidden = YES;
        [self loadViewForFindExercise];
    }
       self.automaticallyAdjustsScrollViewInsets = NO;
}

//What happens when the page is about to appear.
- (void)viewWillAppear:(BOOL)animated {
    if (self.exerciseSelectionMode) {
        [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_EXERCISE_SELECTION viewController:self message:@"Here you can select the exercises you want in your workout. It's works exactly the same as Exercises, you find the exercises you want and select them, then you come back to this screen and select done and they will be added to your workout. At the bottom of the view you can see icons, the icon to the left is advanced search, the icon in the middle is used to select your favourited exercises, and the icon at the right is to select warmup exercises."];
    }
    else {
        [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_FIND_EXERICSE viewController:self message:@"Ok, so from here you can select a body zone you would like to work on and find exercises for it, go more in-depth and target a specific muscle from the muscle list or even view your recently viewed exercises. If want a specific exercise based off of equipment and more attributes press the magnifying glass in the top left to perform an advanced search. If you just got to the gym and need to warmup press the icon in the top right to find some warmup exercises. You can navigate to other parts of the app with the menu at the bottom of your screen."];
    }
}

//Loads the view when it is called for selecting exercises.
- (void)loadViewForExerciseSelection {
    if (self.selectedExercises.count == 0) {
        selectedWorkoutExercises = [[NSMutableArray alloc] init];
    }
    else {
        selectedWorkoutExercises = self.selectedExercises;
    }
    
    [self setNavigationButtons];
}

//Loads the view for the default find exercise portal.
- (void)loadViewForFindExercise {
    //By default warmup has not been pressed.
    warmupPressed = NO;
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
        cell.textLabel.textColor = BLUE_COLOR;
        cell.detailTextLabel.textColor = BLUE_COLOR;
        cell.textLabel.font = tableViewTitleTextFont;
        cell.detailTextLabel.font = tableViewUnderTitleTextFont;

        
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
             cell.likeExerciseImage.tintColor = BLUE_COLOR;
        }
        else {
             cell.likeExerciseImage.hidden = YES;
        }
        
        //UILabel *timeLabel = (UILabel*)[cell viewWithTag:14];
        //timeLabel.text = [CommonUtilities calculateTime:exercise.lastViewed];
        
        //Set the selected cell background.
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
        
        if (!self.exerciseSelectionMode) {
            //configure right buttons
            cell.rightButtons = @[[MGSwipeButton buttonWithTitle:nil icon:[UIImage imageNamed:@"AddToWorkout.png"] backgroundColor:BLUE_COLOR callback:^BOOL(MGSwipeTableCell *sender) {
                selectedIndex = indexPath;
                [self performSegueWithIdentifier:@"addToWorkout" sender:nil];
                return YES;
            }]];
            cell.rightExpansion.fillOnTrigger = YES;
            cell.rightExpansion.threshold = 2.0f;
            cell.rightExpansion.buttonIndex = 0;
            cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
            
        }
        
        
        if (self.exerciseSelectionMode) {
            //Set the accessory type dependant on whether it is in selected cells array.
            if ([CommonUtilities exerciseInArray:selectedWorkoutExercises exercise:exercise]) {
                //Make the checkmark show up.
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.likeDistanceToEdge.constant = 0.0f;
            }
            else {
                //Make no checkmark.
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.likeDistanceToEdge.constant = 21.0f;
            }
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
    titleLabel.textColor = BLUE_COLOR;
    
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
    bodyZonePressed = NO;
    if (tableView == self.muscleSelectionTableView) {
        [self selectRow:indexPath alertTitle:@"Exercise Type"];
    }
    else {
        if (self.exerciseSelectionMode) {
             ExerciseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            SHExercise *exercise = [recenltyViewedExercises objectAtIndex:indexPath.row];
            if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
                selectedWorkoutExercises = [CommonUtilities deleteSelectedExercise:selectedWorkoutExercises exercise:exercise];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.likeDistanceToEdge.constant = 21.0f;
            } else {
               [selectedWorkoutExercises addObject:exercise];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.likeDistanceToEdge.constant = 0.0f;
            }
        }
        else {
            //Go to the detail view if the user presses on a recently viewed exercise.
            [self performSegueWithIdentifier:@"detail" sender:nil];
        }
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

/*******************************************************/
#pragma mark - UICollectionView Delegate and Datasource Methods
/*******************************************************/

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [collectionViewBodyZones count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BodyViewCollectionViewCell *cell = (BodyViewCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [CommonSetUpOperations styleCollectionViewCellBodyZone:cell];
    cell.bodyZoneLabel.text = [collectionViewBodyZones objectAtIndex:indexPath.row];
    cell.bodyZoneImage.image = [UIImage imageNamed:[collectionViewBodyZonesImages objectAtIndex:indexPath.row]];
    cell.bodyZoneMuscleLabel.text = [collectionViewBodyZonesMuscles objectAtIndex:indexPath.row];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    selectedCollectionViewIndex = indexPath;
    bodyZonePressed = YES;
    [self selectRow:indexPath alertTitle:@"Exercise Type"];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE_6P) {
        return CGSizeMake(207.f, 207.f);
    }
    else if (IS_IPHONE_6) {
        return CGSizeMake(187.5f, 187.5f);
    }
    else {
        return CGSizeMake(160.f, 160.f);
    }
}


/**********************************************************/
#pragma mark - Exercise Selection Searched Delegate Methods
/**********************************************************/

- (void)selectedExercises:(NSMutableArray*)selectedExercises {
    self.selectedExercises = selectedExercises;
    [self.recentlyViewedTableView reloadData];
}


- (void)advancedSelectedExercises:(NSMutableArray*)selectedExercises {
    self.selectedExercises = selectedExercises;
     [self.recentlyViewedTableView reloadData];
}

- (void)selectedFavoriteExercises:(NSMutableArray*)selectedExercises {
    self.selectedExercises = selectedExercises;
    [self.recentlyViewedTableView reloadData];
}


/*****************************/
#pragma mark - Helper Methods
/*****************************/

//Fetches the information from the general plist and fills the arrays to display in the tableView, also fetches and fills the "Recently Viewed" tableView.
- (void)fillTableViewsOnLoad {
    //Fill the front body muscles array.
    frontBodyMuscles = [CommonUtilities returnGeneralPlist][@"anteriorMuscles"];
    //Fill the back body muscles array.
    backBodyMuscles = [CommonUtilities returnGeneralPlist][@"posteriorMuscles"];
    //Fill the front body muscles scientific names array.
    frontBodyMusclesScientificNames = [CommonUtilities returnGeneralPlist][@"anteriorMusclesScientificNames"];
    //Fill the back body muscles scientific names array.
    backBodyMusclesScientificNames = [CommonUtilities returnGeneralPlist][@"posteriorMusclesScientificNames"];
    //Fetch the recently viewed exercises and load that tableView.
    collectionViewBodyZones = @[@"Arms",@"Legs",@"Core",@"Back",@"Chest",@"Neck",@"Shoulders",@"Butt"];
    collectionViewBodyZonesMuscles = @[@"Bicep, Tricep, Forearms",@"Quadricep, Hamstring, Calf",@"Abdominal, Oblique",@"Lats, Lower Back",@"Pectoralis",@"Trapezius",@"Deltoid",@"Gluteus"];
    collectionViewBodyZonesImages = @[@"Arms6.png",@"Legs6.png",@"Core6.png",@"BackMuscles6.png",@"Chest6.png",@"Neck6.png",@"Shoulders6.png",@"Butt6.png"];
    
    [self fetchRecentlyViewedExercises];
}

//Sets the observers for the notifications that need to be observed for.
- (void)setNotificationObservers {
    //Observe for changes. All just reload the recently
    //iCloud update notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchRecentlyViewedExercises) name:CLOUD_UPDATE_NOTIFICATION object:nil];
    //Changes in a exercise record, i.e. changes in lastViewed.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchRecentlyViewedExercises) name:EXERCISE_UPDATE_NOTIFICATION object:nil];
    //Changes in a exercise favorite.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fetchRecentlyViewedExercises) name:EXERCISE_SAVE_NOTIFICATION object:nil];
}

//Fetches the recently viewed exercises and loads them into the tableView.
- (void)fetchRecentlyViewedExercises {
    //Perform task on the background thread.
    dispatch_async(dispatch_get_main_queue(), ^{
        SHDataHandler *dataHandler = [SHDataHandler getInstance];
        
        //Fetches the recently viewed exercises, in Exercise object.
        NSArray *recenltyViewedExercisesData = [[SHDataHandler getInstance] getRecentlyViewedExercises];
        
        recenltyViewedExercises = [[NSMutableArray alloc] init];
        
        //Converts Exercise object to usable SHExercise object.
        for (int i = 0; i < recenltyViewedExercisesData.count; i++) {
            if (i == 50) {
                break;
            }
            else {
                [recenltyViewedExercises addObject:[dataHandler convertExerciseToSHExercise:[recenltyViewedExercisesData objectAtIndex:i]]];
            }
        }
        
        //Reload the recenltyviewed tableview to display the new exercises.
        [self.recentlyViewedTableView reloadData];
    });
    
}

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
    if ((bodyZonePressed && indexPath.item != 5) || (!bodyZonePressed && [self setCheck:indexPath])) {
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

//Checks to see if there are any recently viewed exercises to show.
- (void)checkRecentlyViewed {
    if (recenltyViewedExercises.count == 0) {
        //Presents alert if the user hasnt viewed any exercises lately.
        //[CommonSetUpOperations performTSMessage:@"Oops, looks like you haven't viewed any exercises yet!" message:@"" viewController:self canBeDismissedByUser:YES duration:5];
    }
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

//When loading the view take the users preferences into consideration.
- (void)checkPreferences {
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
}

//Sets the navigations bar buttons for the exercise selection mode. 
- (void)setNavigationButtons {
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(doneSelectingExercises)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(cancelledSelectingExercises)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.leftBarButtonItem = leftButton;
}

/*********************/
#pragma mark - Actions
/*********************/

//What happens when the user changes the segmented control selected index.
- (IBAction)searchToolbarPressed:(id)sender {
    [self performSegueWithIdentifier:@"advancedSearch" sender:nil];
}

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.recentlyViewedView.hidden = YES;
            self.muscleSelectionView.hidden = NO;
            self.bodyZoneView.hidden = YES;
            break;
        case 1:
            [self checkRecentlyViewed];
            self.recentlyViewedView.hidden = YES;
            self.muscleSelectionView.hidden = YES;
            self.bodyZoneView.hidden = NO;
            break;
        case 2:
            [self checkRecentlyViewed];
            self.recentlyViewedView.hidden = NO;
            self.muscleSelectionView.hidden = YES;
            self.bodyZoneView.hidden = YES;
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

//Called when the user is finished selecting an exercise in exercise seletion mode.
- (void)doneSelectingExercises {
    [self.delegate selectedExercises:selectedWorkoutExercises];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Gets called when the user cancels seleting an exercise in exerciseSelectionMode.
- (void)cancelledSelectingExercises {
    [self dismissViewControllerAnimated:YES completion:nil];
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
        
        
        if (self.exerciseSelectionMode) {
            viewExercisesViewController.exerciseSelectionMode = YES;
            viewExercisesViewController.delegate = self;
            viewExercisesViewController.selectedExercises = selectedWorkoutExercises;
        }
        
        if (bodyZonePressed) {
            switch (selectedCollectionViewIndex.row) {
                case 0:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertIndex muscles:@[@"Bicep",@"Tricep",@"Forearms",@"Wrist"]];
                    
                    viewExercisesViewController.viewTitle = @"Arms";
                    break;
                case 1:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertIndex muscles:@[@"Quadriceps",@"Hamstring",@"Calf"]];
                    viewExercisesViewController.viewTitle = @"Legs";
                    break;
                case 2:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertIndex muscles:@[@"Abdominal",@"Oblique"]];
                    viewExercisesViewController.viewTitle = @"Core";
                    break;
                case 3:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertIndex muscles:@[@"Lats",@"Lower Back"]];
                    viewExercisesViewController.viewTitle = @"Back";
                    break;
                case 4:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertIndex muscles:@[@"Chest"]];
                    viewExercisesViewController.viewTitle = @"Chest";
                    break;
                case 5:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertIndex muscles:@[@"Neck"]];
                    viewExercisesViewController.viewTitle = @"Neck";
                    break;
                case 6:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertIndex muscles:@[@"Shoulder"]];
                    viewExercisesViewController.viewTitle = @"Shoulders";
                    break;
                case 7:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertIndex muscles:@[@"Glutes"]];
                    viewExercisesViewController.viewTitle = @"Butt";
                    break;
                default:
                    break;
            }
            bodyZonePressed = NO;
        }
        else {
            NSString *muscleSelected = cell.textLabel.text;
            
            viewExercisesViewController.viewTitle = muscleSelected;
            if (warmupPressed) {
                alertIndex = 3;
                viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertIndex muscles:nil];
                viewExercisesViewController.viewTitle = @"Warmup Exercises";
                warmupPressed = NO;
            }
            else if (alertIndex == 0) {
                viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertIndex muscles:@[muscleSelected]];
            }
            else if (alertIndex == 1) {
                viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertIndex muscles:@[muscleSelected]];
            }
        }
    }
    else if ([segue.identifier isEqualToString:@"detail"]) {
        NSIndexPath *indexPath = [self.recentlyViewedTableView indexPathForSelectedRow];
        SHExercise *exercise = [recenltyViewedExercises objectAtIndex:indexPath.row];
        ExerciseDetailViewController *destViewController = segue.destinationViewController;
        destViewController.exerciseToDisplay = exercise;
        destViewController.viewTitle = exercise.exerciseName;
         destViewController.showActionIcon = YES;
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
        destViewController.showActionIcon = YES;
    }
    else if ([segue.identifier isEqualToString:@"addToWorkout"]) {
        UINavigationController *navController = [[UINavigationController alloc] init];
        CustomWorkoutSelectionViewController *customWorkoutSelection = [[CustomWorkoutSelectionViewController alloc] init];
        navController = segue.destinationViewController;
        customWorkoutSelection = navController.viewControllers[0];
        customWorkoutSelection.exerciseToAdd = [recenltyViewedExercises objectAtIndex:selectedIndex.row];
    }
    else if ([segue.identifier isEqualToString:@"advancedSearch"]) {
        UINavigationController *navController = [[UINavigationController alloc] init];
        navController = segue.destinationViewController;
        ExerciseAdvancedSearchViewController *advancedSearch = [[ExerciseAdvancedSearchViewController alloc] init];
        advancedSearch = navController.viewControllers[0];
        advancedSearch.exerciseSelectionMode = YES;
        advancedSearch.selectedExercises = selectedWorkoutExercises;
        advancedSearch.delegate = self;
        
    }
    else if ([segue.identifier isEqualToString:@"selectExercisesFromFavorites"]) {
        FavoritesViewController *favoritesView = [[FavoritesViewController alloc] init];
        favoritesView = segue.destinationViewController;
        favoritesView.exerciseSelectionMode = YES;
        favoritesView.selectedExercises = selectedWorkoutExercises;
        favoritesView.delegate = self;
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

- (IBAction)favListPressed:(id)sender {
    [self performSegueWithIdentifier:@"selectExercisesFromFavorites" sender:nil];
}
@end
