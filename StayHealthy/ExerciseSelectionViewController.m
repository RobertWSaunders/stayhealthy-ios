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
    
    
    
    NSArray *segItemsArray = [NSArray arrayWithObjects: @"Custom", @"Body Zones", @"Categories", nil];
    
    
    segmentedControl = [[UISegmentedControl alloc] initWithItems:segItemsArray];
    segmentedControl.frame = CGRectMake(0, 0, self.view.frame.size.width-20, 30);
    segmentedControl.selectedSegmentIndex = 1;
    [segmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *segmentedControlButtonItem = [[UIBarButtonItem alloc] initWithCustomView:(UIView *)segmentedControl];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *barArray = [NSArray arrayWithObjects: flexibleSpace, segmentedControlButtonItem, flexibleSpace, nil];
    
    
    [self.segmentedControlToolbar setItems:barArray];
    
    for (UIView *subView in [self.navigationController.navigationBar subviews]) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            // Hide the hairline border
            subView.hidden = YES;
        }
    }
    
    for (UIView *subView in [self.segmentedControlToolbar subviews]) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            // Hide the hairline border
            subView.hidden = YES;
        }
    }

    
    //Fill arrays.
    [self fetchArrayData];
    //Set notification observers.
    [self setNotificationObservers];

    //Set the default views.
    [self setViewHidden:YES bodyZone:NO categoriesView:YES];
    
    //Do differernt configuration depending on what mode the view controller is called for.
    if (self.exerciseSelectionMode) {
        [self loadViewForExerciseSelection];
    }
    else {
        [self loadViewForFindExercise];
    }
    
    //Check the users preferences when loading the view.
    [self checkPreferences];
    
        
    //Don't adjust scroll view insets, adds weird gap to views.
    self.automaticallyAdjustsScrollViewInsets = NO;
}



//What happens when the page is about to appear.
- (void)viewWillAppear:(BOOL)animated {
    
    //Set the default module.
    if (self.moduleRender == 0) {
        self.moduleRender = exercises;
    }
    
    //Style the module alerts with the color given by the module.
    //[CommonSetUpOperations styleAlertView:[CommonUtilities returnModuleColor:self.moduleRender]];
}

//-------------------------------------------
#pragma mark Exercise Selection Configuration
//-------------------------------------------

//Loads the view when it is called for selecting exercises.
- (void)loadViewForExerciseSelection {
    //Set the title.
    self.title = @"Select Exercises";
    if (self.selectedExercises.count == 0) {
        self.selectedExercises = [[NSMutableArray alloc] init];
    }

    //Shows the new navigations buttons for the modal popup.
    [self setNavigationButtons];
}

//-------------------------------------
#pragma mark Default Mode Configuration
//-------------------------------------

//Loads the view for the default find exercise portal.
- (void)loadViewForFindExercise {

}

//-------------------------------------
#pragma mark Preferences Checking
//-------------------------------------

//Checks user preferences to do various things in the loading of the view.
- (void)checkPreferences {
    //If YES then show collection view.
    if ([CommonUtilities checkUserPreference:PREFERENCE_LIST_VIEW]) {
    /*    self.recentlyViewedTableView.hidden = NO;
        self.recentExercisesCollectionView.hidden = YES;
        self.customExercisesTableView.hidden = NO;
        self.customExercisesCollectionView.hidden = YES;
    }
    else {
        self.recentlyViewedTableView.hidden = YES;
        self.recentExercisesCollectionView.hidden = NO;
        self.customExercisesTableView.hidden = YES;
        self.customExercisesCollectionView.hidden = NO;*/
    }
    //Re-fetch the users recently viewed exercises in case they have changed the number of recents shown.
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
    if (collectionView == self.bodyZoneCollectionView) {
        return [bodyZones count];
    }
      else if (collectionView == self.customExercisesCollectionView) {
        return [customExercises count];
    }
    return 1;
}

//Configures the cells at a specific indexPath.
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.bodyZoneCollectionView) {
            BodyViewCollectionViewCell *cell = (BodyViewCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"BodyZoneCell" forIndexPath:indexPath];
           // [CommonSetUpOperations styleCollectionViewCellBodyZone:cell];
        
        cell.layer.masksToBounds = NO;
        
        cell.layer.borderColor = LIGHT_GRAY_COLOR.CGColor;
        cell.layer.borderWidth = 0.5f;
        cell.layer.cornerRadius = 5.0f;
        cell.layer.shadowRadius = 10.0f;
        cell.layer.shadowOpacity = 0.75f;
        cell.layer.shadowOffset = CGSizeMake(0.0, 2.0);
        cell.layer.shadowColor = SHADOW_COLOR.CGColor;

        cell.bodyZoneImage.tintColor = EXERCISES_COLOR;
        cell.bodyZoneLabel.font = TABLE_VIEW_TITLE_FONT;
        
            cell.bodyZoneLabel.text = [bodyZones objectAtIndex:indexPath.row];

        if (self.exerciseSelectionMode) {
            cell.bodyZoneImage.image = [UIImage imageNamed:[bodyZonesImagesExerciseSelectionMode objectAtIndex:indexPath.row]];
             cell.bodyZoneLabel.textColor = WORKOUTS_COLOR;
        }
        else {
            cell.bodyZoneImage.image = [UIImage imageNamed:[bodyZonesImages objectAtIndex:indexPath.row]];
            cell.bodyZoneLabel.textColor = EXERCISES_COLOR;
        }
        
            return cell;
    }
      return nil;
}

//--------------------------------------------------
#pragma mark Collection View Cell Selection Handling
//--------------------------------------------------

//What happens when the user selects a cell in the tableView.
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   if (collectionView == self.bodyZoneCollectionView) {
        selectedBodyZoneIndex = indexPath;
        bodyZonePressed = YES;
        [self performSegueWithIdentifier:@"ViewExercises" sender:nil];
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

//-------------------------------------------
#pragma mark Collection Layout Configuration
//-------------------------------------------

//Controls the size of the collection view cells for different phones.
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView ==  self.bodyZoneCollectionView) {
            if (IS_IPHONE_6P) {
                return CGSizeMake(207.f, 207.f);
            }
            else if (IS_IPHONE_6) {
                return CGSizeMake(172.0f, 172.0f);
            }
            else {
                return CGSizeMake(160.f, 160.f);
            }
        }
    else {
        if (IS_IPHONE_6P) {
            return CGSizeMake(207.f, 207.f);
        }
        else if (IS_IPHONE_6) {
            return CGSizeMake(187.5f, 240.5f);
        }
        else {
            return CGSizeMake(160.f, 160.f);
        }
    }
}

/**********************************************************/
#pragma mark - Exercise Selection Searched Delegate Methods
/**********************************************************/

//Delegate methods for selected exercises coming from ExerciseListController
- (void)selectedExercises:(NSMutableArray*)selectedExercises {
    self.selectedExercises = selectedExercises;
    //[self.recentlyViewedTableView reloadData];
}

/*****************************************************************/
#pragma mark - Advanced Search Exercise Selection Delegate Methods
/*****************************************************************/

//Delegate methods for selected exercises coming from ExerciseAdvancedSearchedViewController
- (void)advancedSelectedExercises:(NSMutableArray*)selectedExercises {
    self.selectedExercises = selectedExercises;
    // [self.recentlyViewedTableView reloadData];
}

/************************************************************/
#pragma mark - Liked Exercise Selection Delegate Methods
/************************************************************/

//Delegate methods for selected exercises coming from FavouritesViewController
- (void)selectedFavoriteExercises:(NSMutableArray*)selectedExercises {
    self.selectedExercises = selectedExercises;
   // [self.recentlyViewedTableView reloadData];
}


/*****************************************/
#pragma mark - UIToolbar Delegate Methods
/*****************************************/

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {
    if (bar == self.segmentedControlToolbar) {
        return UIBarPositionTopAttached;
        
    }
    return UIBarPositionBottom;
}

/********************************************/
#pragma mark - UIScrollView Delegate Methods
/********************************************/

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.bodyZoneCollectionView) {
        for (UIView *subView in [self.segmentedControlToolbar subviews]) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                [UIView transitionWithView:subView
                                  duration:0.4
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    subView.hidden = NO;
                                }
                                completion:NULL];
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ((scrollView == self.bodyZoneCollectionView) && (self.bodyZoneCollectionView.contentOffset.y <= 20)) {
        for (UIView *subView in [self.segmentedControlToolbar subviews]) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                [UIView transitionWithView:subView
                                  duration:0.4
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    subView.hidden = YES;
                                }
                                completion:NULL];
            }
        }
    }
}


/*****************************/
#pragma mark - Helper Methods
/*****************************/

//----------------------------------
#pragma mark View Loading and Set Up
//----------------------------------

//Fetches all array data for default mode.
- (void)fetchArrayData {
    //Fill the body zones array with the body zones.
    bodyZones = @[@"Arms",@"Legs",@"Core",@"Back",@"Chest",@"Neck",@"Shoulders",@"Butt"];
    
    //Fill the body zone images array the body zones images.
    bodyZonesImages = @[@"Arms",@"Leg",@"Core",@"Back",@"Chest",@"Neck",@"Shoulders",@"Bottom"];

    //Fetch the custom exercises.
    [self fetchCustomExercises];
}

//Fetch custom exercises.
- (void)fetchCustomExercises {
    dispatch_async(dispatch_get_main_queue(), ^{
        SHDataHandler *dataHandler = [SHDataHandler getInstance];
        customExercises = [[NSMutableArray alloc] init];
        [self.customExercisesCollectionView reloadData];
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkPreferences) name:PREFERENCE_CHANGE_NOTIFICATION object:nil];
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

//Sets the views hidden given the paramet
- (void)setViewHidden:(BOOL)customExercisesView bodyZone:(BOOL)bodyZone categoriesView:(BOOL)categories {
    self.customExercisesView.hidden = customExercisesView;
    self.bodyZoneView.hidden = bodyZone;
    self.categoriesView.hidden = categories;
}

/*********************/
#pragma mark - Actions
/*********************/

//What happens when the user selects advanced search.
- (IBAction)advancedSearchPressed:(id)sender {
    [self performSegueWithIdentifier:@"AdvancedSearch" sender:nil];
}

//What happens when the user selects the add button in the navigation bar.
- (IBAction)addExerciseButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"createExercise" sender:nil];
}

//What happens when the user changes segments in the segmented control.
- (void)segmentValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self setViewHidden:NO bodyZone:YES categoriesView:YES];
            break;
        case 1:
            [self setViewHidden:YES bodyZone:NO categoriesView:YES];
            break;
        case 2:
            [self setViewHidden:YES bodyZone:YES categoriesView:NO];
            break;
        default:
            break;
    }
}

//--------------------------
#pragma mark Toolbar Actions
//--------------------------


//What happens when the favourite button is pressed in the toolbar for
- (IBAction)likedExerciseSelectionPressed:(id)sender {
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
    
    //For BODY ZONE
    if ([segue.identifier isEqualToString:@"ViewExercises"]) {
        
        ExerciseListController *viewExercisesViewController = [[ExerciseListController alloc] init];
        
        viewExercisesViewController = segue.destinationViewController;
        
        if (self.exerciseSelectionMode) {
            viewExercisesViewController.exerciseSelectionMode = YES;
            viewExercisesViewController.delegate = self;
            viewExercisesViewController.selectedExercises = self.selectedExercises;
        }
        
        if (bodyZonePressed) {
            switch (selectedBodyZoneIndex.item) {
                case 0:
                    viewExercisesViewController.exerciseQuery = [SHDataUtilities createExerciseQuery:strength muscles:@[@"Bicep",@"Tricep",@"Forearms",@"Wrist"]];
                    viewExercisesViewController.viewTitle = @"Arm Exercises";
                    break;
                case 1:
                    viewExercisesViewController.exerciseQuery = [SHDataUtilities createExerciseQuery:strength muscles:@[@"Quadriceps",@"Hamstring",@"Calf"]];
                    viewExercisesViewController.viewTitle = @"Leg Exercises";
                    break;
                case 2:
                    viewExercisesViewController.exerciseQuery = [SHDataUtilities createExerciseQuery:strength muscles:@[@"Abdominal",@"Oblique"]];
                    viewExercisesViewController.viewTitle = @"Core Exercises";
                    break;
                case 3:
                    viewExercisesViewController.exerciseQuery = [SHDataUtilities createExerciseQuery:strength muscles:@[@"Lats",@"Lower Back"]];
                    viewExercisesViewController.viewTitle = @"Back Exercises";
                    break;
                case 4:
                    viewExercisesViewController.exerciseQuery = [SHDataUtilities createExerciseQuery:strength muscles:@[@"Chest"]];
                    viewExercisesViewController.viewTitle = @"Chest Exercises";
                    break;
                case 5:
                    viewExercisesViewController.exerciseQuery = [SHDataUtilities createExerciseQuery:strength muscles:@[@"Neck"]];
                    viewExercisesViewController.viewTitle = @"Neck Exercises";
                    break;
                case 6:
                    viewExercisesViewController.exerciseQuery = [SHDataUtilities createExerciseQuery:strength muscles:@[@"Shoulder"]];
                    viewExercisesViewController.viewTitle = @"Shoulder Exercises";
                    break;
                case 7:
                    viewExercisesViewController.exerciseQuery = [SHDataUtilities createExerciseQuery:strength muscles:@[@"Glutes"]];
                    viewExercisesViewController.viewTitle = @"Butt Exercises";
                    break;
                default:
                    break;
            }
            bodyZonePressed = NO;
        }
      //FOR ADVANCED SEARCH
    else if ([segue.identifier isEqualToString:@"advancedSearch"]) {
        UINavigationController *navController = [[UINavigationController alloc] init];
        navController = segue.destinationViewController;
        ExerciseAdvancedSearchViewController *advancedSearch = [[ExerciseAdvancedSearchViewController alloc] init];
        advancedSearch = navController.viewControllers[0];
        advancedSearch.exerciseSelectionMode = YES;
        advancedSearch.selectedExercises = self.selectedExercises;
        advancedSearch.delegate = self;
        
    }
    //FOR EXERCISE SELECTION FROM FAVOURITES
    else if ([segue.identifier isEqualToString:@"selectExercisesFromFavorites"]) {
        FavoritesViewController *favoritesView = [[FavoritesViewController alloc] init];
        favoritesView = segue.destinationViewController;
        favoritesView.exerciseSelectionMode = YES;
        favoritesView.selectedExercises = self.selectedExercises;
        favoritesView.delegate = self;
    }
}
}

/**************************************/
#pragma mark - View Terminating Methods
/**************************************/

- (void)viewWillDisappear:(BOOL)animated {
    
}

@end
