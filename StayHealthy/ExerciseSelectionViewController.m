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
    //Fill arrays.
    [self fetchArrayData];
    //Set notification observers.
    [self setNotificationObservers];
    
    //Style alerts.
    [CommonSetUpOperations styleAlertView];
    
    //Default Selected Segment "Body Zone"
    [self.segmentedControl setSelectedSegmentIndex:1];
    //Set the default views.
    [self setViewHidden:YES bodyZone:NO recentlyViewed:YES];
    
    //Do differernt configuration depending on what mode the view controller is called for.
    if (self.exerciseSelectionMode) {
        [self loadViewForExerciseSelection];
    }
    else {
        [self loadViewForFindExercise];
    }
    
    //Don't adjust scroll view insets, adds weird gap to views.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//What happens when the page is about to appear.
- (void)viewWillAppear:(BOOL)animated {
    //Check to see if 3D touch is enabled.
    [self register3DTouch];
    //Sets the tutorial messages.
    [self setTutorialMessages];
}

//-------------------------------------------
#pragma mark Exercise Selection Configuration
//-------------------------------------------

//Loads the view when it is called for selecting exercises.
- (void)loadViewForExerciseSelection {
    if (self.selectedExercises.count == 0) {
        self.selectedExercises = [[NSMutableArray alloc] init];
    }
    //Shows the toolbar at the bottom of the screen.
    [self showExerciseSelectionToolbar];
    //Shows the new navigations buttons for the modal popup.
    [self setNavigationButtons];
}

//-------------------------------------
#pragma mark Default Mode Configuration
//-------------------------------------

//Loads the view for the default find exercise portal.
- (void)loadViewForFindExercise {
    //By default warmup has not been pressed.
    warmupPressed = NO;
    //Hide the toolbar that is shown in exercise selection mode.
    self.toolbar.hidden = YES;
}

/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the height of the cells inside the tableView.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.muscleSelectionTableView) {
        //Set the height for the muscle list tableView.
        return 57.0f;
    }
    else {
        //Set the height for the recently viewed tableView.
        return 76.0f;
    }
}

//Returns the number of rows in a section that should be displayed in the tableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Set the number of rows in each section.
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
    //Muscle selection tableView.
    if (tableView == self.muscleSelectionTableView) {
        
        //Define the cell identifier.
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
        
        //Stye the cell with the default styles.
        cell.textLabel.textColor = BLUE_COLOR;
        cell.detailTextLabel.textColor = BLUE_COLOR;
        cell.textLabel.font = tableViewTitleTextFont;
        cell.detailTextLabel.font = tableViewUnderTitleTextFont;

        
        //Return the cell.
        return cell;
    }
    //For the recently viewed tableView.
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
        
        if ([exercise.exerciseLiked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            cell.likeExerciseImage.hidden = NO;
            [cell.likeExerciseImage setImage:[UIImage imageNamed:@"likeSelectedColored.png"]];
             cell.likeExerciseImage.tintColor = BLUE_COLOR;
        }
        else {
             cell.likeExerciseImage.hidden = YES;
        }
        
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
            if ([CommonUtilities exerciseInArray:self.selectedExercises exercise:exercise]) {
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

//--------------------------------------------
#pragma mark TableView Cell Selection Handling
//--------------------------------------------

//What happens when the user selects a cell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    bodyZonePressed = NO;
    selectedTableViewIndex = indexPath;
    if (tableView == self.muscleSelectionTableView) {
        [self presentExerciseTypeAlert:indexPath alertTitle:@"Exercise Type"];
    }
    else {
        if (self.exerciseSelectionMode) {
             ExerciseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            SHExercise *exercise = [recenltyViewedExercises objectAtIndex:indexPath.row];
            if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
                self.selectedExercises = [CommonUtilities deleteSelectedExercise:self.selectedExercises exercise:exercise];
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.likeDistanceToEdge.constant = 21.0f;
            } else {
               [self.selectedExercises addObject:exercise];
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

/**************************************************************/
#pragma mark - UICollectionView Delegate and Datasource Methods
/**************************************************************/

//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//Returns the number of rows in a section that should be displayed in the tableView.
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [bodyZones count];
}

//Configures the cells at a specific indexPath.
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BodyViewCollectionViewCell *cell = (BodyViewCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [CommonSetUpOperations styleCollectionViewCellBodyZone:cell];
    cell.bodyZoneLabel.text = [bodyZones objectAtIndex:indexPath.row];
    cell.bodyZoneImage.image = [UIImage imageNamed:[bodyZonesImages objectAtIndex:indexPath.row]];
    return cell;
    
}

//--------------------------------------------------
#pragma mark Collection View Cell Selection Handling
//--------------------------------------------------

//What happens when the user selects a cell in the tableView.
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    selectedBodyZoneIndex = indexPath;
    bodyZonePressed = YES;
    [self presentExerciseTypeAlert:indexPath alertTitle:@"Exercise Type"];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

//-------------------------------------------
#pragma mark Collection Layout Configuration
//-------------------------------------------

//Controls the size of the collection view cells for different phones.
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
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

//Delegate methods for selected exercises coming from ExerciseListController
- (void)selectedExercises:(NSMutableArray*)selectedExercises {
    self.selectedExercises = selectedExercises;
    [self.recentlyViewedTableView reloadData];
}

/*****************************************************************/
#pragma mark - Advanced Search Exercise Selection Delegate Methods
/*****************************************************************/

//Delegate methods for selected exercises coming from ExerciseAdvancedSearchedViewController
- (void)advancedSelectedExercises:(NSMutableArray*)selectedExercises {
    self.selectedExercises = selectedExercises;
     [self.recentlyViewedTableView reloadData];
}

/************************************************************/
#pragma mark - Favourites Exercise Selection Delegate Methods
/************************************************************/

//Delegate methods for selected exercises coming from FavouritesViewController
- (void)selectedFavoriteExercises:(NSMutableArray*)selectedExercises {
    self.selectedExercises = selectedExercises;
    [self.recentlyViewedTableView reloadData];
}

/*************************************************/
#pragma mark - 3D Touch Peek and Pop Configuration
/*************************************************/

//-----------------
#pragma mark Set Up
//-----------------

//Checks to see if 3D Touch is enabled on device, registers alternative if not.
- (void)register3DTouch {
    //Register for 3D Touch (if available)
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.view];
    }
}

//Called when a user turns the 3D touch feature on or off.
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    //Check to see if 3D touch is enabled.
    [self register3DTouch];
}

//---------------
#pragma mark Peek
//---------------

//Set up the view controller for peeking.
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    
    // check if we're not already displaying a preview controller
    if ([self.presentedViewController isKindOfClass:[ExerciseDetailViewController class]]) {
        return nil;
    }
    
    CGPoint cellPostion = [self.recentlyViewedTableView convertPoint:location fromView:self.view];
    selectedPreviewingIndex = [self.recentlyViewedTableView indexPathForRowAtPoint:cellPostion];
    
    //Shallow press, return the preview controller here. (peek)
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_Storyboard" bundle:nil];
    previewingExerciseDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"ExerciseDetailViewController"];
    
    //Get the exercise to display in the peek and set the peeks attributes.
    SHExercise *exercise = [recenltyViewedExercises objectAtIndex:selectedPreviewingIndex.row];
    previewingExerciseDetailViewController.exerciseToDisplay = exercise;
    previewingExerciseDetailViewController.viewTitle = exercise.exerciseName;
    previewingExerciseDetailViewController.showActionIcon = YES;
    
    return previewingExerciseDetailViewController;
}

//---------------
#pragma mark Pop
//---------------

//Show the view controller, pop.
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:previewingExerciseDetailViewController sender:self];
}

/*****************************/
#pragma mark - Helper Methods
/*****************************/

//----------------------------------
#pragma mark View Loading and Set Up
//----------------------------------

//Fetches all array data for default mode.
- (void)fetchArrayData {
    //Fill the front body muscles array.
    frontBodyMuscles = [CommonUtilities returnGeneralPlist][@"anteriorMuscles"];
    //Fill the back body muscles array.
    backBodyMuscles = [CommonUtilities returnGeneralPlist][@"posteriorMuscles"];
    //Fill the front body muscles scientific names array.
    frontBodyMusclesScientificNames = [CommonUtilities returnGeneralPlist][@"anteriorMusclesScientificNames"];
    //Fill the back body muscles scientific names array.
    backBodyMusclesScientificNames = [CommonUtilities returnGeneralPlist][@"posteriorMusclesScientificNames"];
    //Fill the body zones array with the body zones.
    bodyZones = @[@"Arms",@"Legs",@"Core",@"Back",@"Chest",@"Neck",@"Shoulders",@"Butt"];
    //Fill the body zone images array the body zones images.
    bodyZonesImages = @[@"Arms6.png",@"Legs6.png",@"Core6.png",@"BackMuscles6.png",@"Chest6.png",@"Neck6.png",@"Shoulders6.png",@"Butt6.png"];
    //Fetch the recentlyViewed exercises.
    [self fetchRecentlyViewedExercises];
}

//Fetched the recently viewed exercises.
- (void)fetchRecentlyViewedExercises {
    
    //Perform task on the background thread to maintain good user interface transition.
    dispatch_async(dispatch_get_main_queue(), ^{
        SHDataHandler *dataHandler = [SHDataHandler getInstance];
        recenltyViewedExercises = [dataHandler fetchRecentlyViewedExercises];
        //Reload the recenltyviewed tableview to display the new exercises.
        [self.recentlyViewedTableView reloadData];
    });
     
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

//Shows the toolbar that needs to be displayed in exercise selection mode.
- (void)showExerciseSelectionToolbar {
    self.toolbarTopMuscleSelection.constant = 0.0f;
    self.toolbarTopRecentlyViewed.constant = 0.0f;
}

//Sets the tutorial messages for the first launch of the view.
- (void)setTutorialMessages {
    if (self.exerciseSelectionMode) {
        [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_EXERCISE_SELECTION viewController:self message:@"Here you can select the exercises you want in your workout. It's works exactly the same as Exercises, you find the exercises you want and select them, then you come back to this screen and select done and they will be added to your workout. At the bottom of the view you can see icons, the icon to the left is advanced search, the icon in the middle is used to select your favourited exercises, and the icon at the right is to select warmup exercises."];
    }
    else {
        [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_FIND_EXERICSE viewController:self message:@"Ok, so from here you can select a body zone you would like to work on and find exercises for it, go more in-depth and target a specific muscle from the muscle list or even view your recently viewed exercises. If want a specific exercise based off of equipment and more attributes press the magnifying glass in the top left to perform an advanced search. If you just got to the gym and need to warmup press the icon in the top right to find some warmup exercises. You can navigate to other parts of the app with the menu at the bottom of your screen."];
    }
}

//-----------------------------
#pragma mark Exercise Selection
//-----------------------------

//Sets the navigations bar buttons to "Done" and "Cancel" for exercise selection mode.
- (void)setNavigationButtons {
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(doneSelectingExercises)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                    style:UIBarButtonItemStyleDone target:self action:@selector(cancelledSelectingExercises)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.leftBarButtonItem = leftButton;
}

//-------------------------
#pragma mark Miscellaneous
//-------------------------

//Presents alert when a user selects a body zone or muscle.
- (void)presentExerciseTypeAlert:(NSIndexPath*)indexPath alertTitle:(NSString*)alertTitle {
    //No stretching for bicep, chest, forearms, oblique.
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"title" andMessage:nil];
    [alertView addButtonWithTitle:@"Strength"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              alertButtonIndex = 0;
                              [self performSegueWithIdentifier:@"viewExercises" sender:self];
                          }];
    
    //To accomodate for muscles that do not have any stretching exercises.
    if ((bodyZonePressed && indexPath.item != 5) || (!bodyZonePressed && [self exerciseTypeCheck:indexPath])) {
        [alertView addButtonWithTitle:@"Stretching"
                                 type:SIAlertViewButtonTypeCancel
                              handler:^(SIAlertView *alertView) {
                                  alertButtonIndex = 1;
                                  [self performSegueWithIdentifier:@"viewExercises" sender:self];
                              }];
    }
    [alertView addButtonWithTitle:@"Cancel"
                             type:SIAlertViewButtonTypeCancel
                          handler:nil];
    
    alertView.title = alertTitle;
    [alertView show];
}

//Checks if a tableView row can be chosen for a stretching exercise, not all muscles have stretches, hardcoded indexPaths.
- (BOOL)exerciseTypeCheck:(NSIndexPath*)indexPath {
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

//Sets the views hidden given the paramet
- (void)setViewHidden:(BOOL)muscleSelection bodyZone:(BOOL)bodyZone recentlyViewed:(BOOL)recentlyViewed {
    self.recentlyViewedView.hidden = recentlyViewed;
    self.muscleSelectionView.hidden = muscleSelection;
    self.bodyZoneView.hidden = bodyZone;
}

/*********************/
#pragma mark - Actions
/*********************/

//What happens when the user presses the warmup button in the top right of the navigation bar.
- (IBAction)warmupButtonPressed:(id)sender {
    warmupPressed = YES;
    [self performSegueWithIdentifier:@"viewExercises" sender:nil];
}

- (IBAction)addExerciseButtonPressed:(id)sender {
}

//What happens when the user changes segments in the segmented control.
- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self setViewHidden:NO bodyZone:YES recentlyViewed:YES];
            break;
        case 1:
            [self setViewHidden:YES bodyZone:NO recentlyViewed:YES];
            break;
        case 2:
            [self setViewHidden:YES bodyZone:YES recentlyViewed:NO];
            break;
        default:
            break;
    }
}

//--------------------------
#pragma mark Toolbar Actions
//--------------------------

//What happens when the user selects the advanced search from the toolbar.
- (IBAction)advancedSearchExerciseSelectionPressed:(id)sender {
    [self performSegueWithIdentifier:@"advancedSearch" sender:nil];
}

//What happens when the favourite button is pressed in the toolbar for
- (IBAction)favouriteExerciseSelectionPressed:(id)sender {
    [self performSegueWithIdentifier:@"selectExercisesFromFavorites" sender:nil];
}

//-------------------------------------
#pragma mark Exercise Selection Actions
//-------------------------------------

//Called when the user is finished selecting an exercise in exercise seletion mode.
- (void)doneSelectingExercises {
    [self.delegate selectedExercises:self.selectedExercises];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Gets called when the user cancels seleting an exercise in exercise selection mode.
- (void)cancelledSelectingExercises {
    [self dismissViewControllerAnimated:YES completion:nil];
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
        
        if (self.exerciseSelectionMode) {
            viewExercisesViewController.exerciseSelectionMode = YES;
            viewExercisesViewController.delegate = self;
            viewExercisesViewController.selectedExercises = self.selectedExercises;
        }
        
        if (bodyZonePressed) {
            switch (selectedBodyZoneIndex.row) {
                case 0:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Bicep",@"Tricep",@"Forearms",@"Wrist"]];
                    
                    viewExercisesViewController.viewTitle = @"Arms";
                    break;
                case 1:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Quadriceps",@"Hamstring",@"Calf"]];
                    viewExercisesViewController.viewTitle = @"Legs";
                    break;
                case 2:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Abdominal",@"Oblique"]];
                    viewExercisesViewController.viewTitle = @"Core";
                    break;
                case 3:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Lats",@"Lower Back"]];
                    viewExercisesViewController.viewTitle = @"Back";
                    break;
                case 4:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Chest"]];
                    viewExercisesViewController.viewTitle = @"Chest";
                    break;
                case 5:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Neck"]];
                    viewExercisesViewController.viewTitle = @"Neck";
                    break;
                case 6:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Shoulder"]];
                    viewExercisesViewController.viewTitle = @"Shoulders";
                    break;
                case 7:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Glutes"]];
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
                alertButtonIndex = 3;
                viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:nil];
                viewExercisesViewController.viewTitle = @"Warmup Exercises";
                warmupPressed = NO;
            }
            else if (alertButtonIndex == 0) {
                viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[muscleSelected]];
            }
            else if (alertButtonIndex == 1) {
                viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[muscleSelected]];
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
        advancedSearch.selectedExercises = self.selectedExercises;
        advancedSearch.delegate = self;
        
    }
    else if ([segue.identifier isEqualToString:@"selectExercisesFromFavorites"]) {
        FavoritesViewController *favoritesView = [[FavoritesViewController alloc] init];
        favoritesView = segue.destinationViewController;
        favoritesView.exerciseSelectionMode = YES;
        favoritesView.selectedExercises = self.selectedExercises;
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

@end
