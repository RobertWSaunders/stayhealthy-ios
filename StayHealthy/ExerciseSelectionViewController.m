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
    
    //Check the users preferences when loading the view.
    [self checkPreferences];
    
    //Set the empty set datasource and delegate for every related scrollView.
    self.recentlyViewedTableView.emptyDataSetSource = self;
    self.recentlyViewedTableView.emptyDataSetDelegate = self;
    self.recentExercisesCollectionView.emptyDataSetDelegate = self;
    self.recentExercisesCollectionView.emptyDataSetSource = self;
    self.customExercisesTableView.emptyDataSetSource = self;
    self.customExercisesTableView.emptyDataSetDelegate = self;
    self.customExercisesCollectionView.emptyDataSetDelegate = self;
    self.customExercisesCollectionView.emptyDataSetSource = self;
    
    //Don't adjust scroll view insets, adds weird gap to views.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//What happens when the page is about to appear.
- (void)viewWillAppear:(BOOL)animated {
    //Check to see if 3D touch is enabled.
    //[self register3DTouch];
    //Sets the tutorial messages.
    [self setTutorialMessages];
    
    //Set the default module.
    if (self.moduleRender == 0) {
        self.moduleRender = exercises;
    }
    
    //Style the module alerts with the color given by the module.
    [CommonSetUpOperations styleAlertView:[CommonUtilities returnModuleColor:self.moduleRender]];
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
    //Hide the toolbar that is shown in exercise selection mode.
    self.toolbar.hidden = YES;
}

//-------------------------------------
#pragma mark Preferences Checking
//-------------------------------------

//Checks user preferences to do various things in the loading of the view.
- (void)checkPreferences {
    //If YES then show collection view.
    if ([CommonUtilities checkUserPreference:PREFERENCE_LIST_VIEW]) {
        self.recentlyViewedTableView.hidden = NO;
        self.recentExercisesCollectionView.hidden = YES;
        self.customExercisesTableView.hidden = NO;
        self.customExercisesCollectionView.hidden = YES;
    }
    else {
        self.recentlyViewedTableView.hidden = YES;
        self.recentExercisesCollectionView.hidden = NO;
        self.customExercisesTableView.hidden = YES;
        self.customExercisesCollectionView.hidden = NO;
    }
    //Re-fetch the users recently viewed exercises in case they have changed the number of recents shown.
    [self fetchRecentlyViewedExercises];
}

/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the height of the cells inside the tableView.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76.0f;
}

//Returns the number of rows in a section that should be displayed in the tableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Set the number of rows in each section.
    if (tableView == self.customExercisesTableView) {
        return [customExercises count];
    }
    else {
        return [sortedRecenltyViewedExercises count];
    }
}

//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.customExercisesTableView) {
        return 1;
    }
    else {
        return 1;
    }
}

//Configures the cells at a specific indexPath.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Muscle selection tableView.
    if (tableView == self.customExercisesTableView) {
        
        //Define the cell identifier.
        static NSString *muscleSelectionCellIdentifier = @"customExerciseTableViewCell";
        
        //Create reference to the cell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleSelectionCellIdentifier];
        
        //If the cell can't be found then just create one.
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:muscleSelectionCellIdentifier];
        }

        
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
        
        SHExercise *exercise = [sortedRecenltyViewedExercises objectAtIndex:indexPath.row];
        
        cell.exerciseName.textColor = [CommonUtilities returnModuleColor:self.moduleRender];
       
        
        cell.exerciseName.text = exercise.exerciseShortName;
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
            [cell.likeExerciseImage setImage:[UIImage imageNamed:@"LikeCollectionViewCell.png"]];
             cell.likeExerciseImage.tintColor = BLUE_COLOR;
        }
        else {
             cell.likeExerciseImage.hidden = YES;
        }
        
        //Set the selected cell background.
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
        
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
   /* if (tableView == self.muscleSelectionTableView) {
        return 25.0f;
    }
    else {*/
        return 0.01f;
    //}
}

//Sets the view for the header if you would like to configure a custom view.
/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    //Create the view for the header in the TableView.
    UIView *headerView = [CommonSetUpOperations drawViewForTableViewHeader:tableView];
    
    //Now customize that view.
    //Create the label inside of the view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, tableView.frame.size.width, 18)];
    [titleLabel setFont:tableViewHeaderFont];
    //Set the text color.
    if (self.exerciseSelectionMode) {
        titleLabel.textColor = WORKOUTS_COLOR;
    }
    else {
        titleLabel.textColor = EXERCISES_COLOR;
    }

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
}*/

//--------------------------------------------
#pragma mark TableView Cell Selection Handling
//--------------------------------------------

//What happens when the user selects a cell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    bodyZonePressed = NO;
    selectedTableViewIndex = indexPath;
        if (self.exerciseSelectionMode) {
            SHExercise *exercise;
            ExerciseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if (tableView == self.recentlyViewedTableView) {
                exercise = [sortedRecenltyViewedExercises objectAtIndex:indexPath.row];
            }
            else {
                exercise = [customExercises objectAtIndex:indexPath.row];
            }
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
    if (collectionView == self.bodyZoneCollectionView) {
        return [bodyZones count];
    }
    else if (collectionView ==  self.recentExercisesCollectionView) {
        return [sortedRecenltyViewedExercises count];
    }
    else if (collectionView == self.customExercisesCollectionView) {
        return [customExercises count];
    }
    return 1;
}

//Configures the cells at a specific indexPath.
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == self.bodyZoneCollectionView) {
            BodyViewCollectionViewCell *cell = (BodyViewCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
            [CommonSetUpOperations styleCollectionViewCellBodyZone:cell];
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
    else if (collectionView == self.recentExercisesCollectionView) {
        ExerciseCollectionViewCell *cell = (ExerciseCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"exercisecell" forIndexPath:indexPath];
        
        [CommonSetUpOperations styleCollectionViewCellBodyZone:cell];
        
        SHExercise *exercise = [sortedRecenltyViewedExercises objectAtIndex:indexPath.item];
        
        cell.exerciseName.textColor = [CommonUtilities returnModuleColor:self.moduleRender];
        
        cell.exerciseName.text = exercise.exerciseName;
        
        // Do any additional setup after loading the view, typically from a nib.
        NSMutableAttributedString *difficultyText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Difficulty: %@",exercise.exerciseDifficulty]];
        
        //Red and large
        [difficultyText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:14.0f], NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(0, 11)];
        
        //Rest of text -- just futura
        [difficultyText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:14.0f], NSForegroundColorAttributeName:[CommonSetUpOperations determineDifficultyColor:exercise.exerciseDifficulty]} range:NSMakeRange(11, difficultyText.length - 11)];
        
        cell.exerciseDifficultyLabel.attributedText = difficultyText;
        
        //Load the exercise image on the background thread.
        [CommonSetUpOperations loadImageOnBackgroundThread:cell.exerciseImage image:[UIImage imageNamed:exercise.exerciseImageFile]];
        
        if (self.exerciseSelectionMode) {
            if ([CommonUtilities exerciseInArray:self.selectedExercises exercise:exercise]) {
                cell.likedImage.hidden = NO;
                [cell.likedImage setImage:[UIImage imageNamed:@"CheckmarkW.png"]];
                if ([exercise.exerciseLiked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                    cell.selectedImage.hidden = NO;
                    [cell.selectedImage setImage:[UIImage imageNamed:@"LikeCollectionViewCell.png"]];
                }
                else {
                    cell.selectedImage.hidden = YES;
                }
            }
            else {
                cell.selectedImage.hidden = YES;
                if ([exercise.exerciseLiked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                    cell.likedImage.hidden = NO;
                    [cell.likedImage setImage:[UIImage imageNamed:@"LikeCollectionViewCell.png"]];
                }
                else {
                    cell.likedImage.hidden = YES;
                }
            }
        }
        else {
            if ([exercise.exerciseLiked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                cell.likedImage.hidden = NO;
                [cell.likedImage setImage:[UIImage imageNamed:@"LikeCollectionViewCell.png"]];
            }
            else {
                cell.likedImage.hidden = YES;
            }
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
            if (indexPath.item == 0) {
                [self performSegueWithIdentifier:@"viewExercises" sender:nil];
            }
            else {
                [self presentExerciseTypeAlert:indexPath alertTitle:@"Exercise Type"];
            }
    }
    else {
        if (self.exerciseSelectionMode) {
            ExerciseCollectionViewCell *cell = (ExerciseCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            SHExercise *exercise;
            if (collectionView == self.recentExercisesCollectionView) {
                exercise = [sortedRecenltyViewedExercises objectAtIndex:indexPath.row];
            }
            else {
                exercise = [customExercises objectAtIndex:indexPath.row];
            }
            
            if ([CommonUtilities exerciseInArray:self.selectedExercises exercise:exercise]) {
                self.selectedExercises = [CommonUtilities deleteSelectedExercise:self.selectedExercises exercise:exercise];
                cell.selectedImage.hidden = YES;
                if ([exercise.exerciseLiked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                    cell.likedImage.hidden = NO;
                    [cell.likedImage setImage:[UIImage imageNamed:@"LikeCollectionViewCell.png"]];
                }
                else {
                    cell.likedImage.hidden = YES;
                }
            }
            else  {
                cell.likedImage.hidden = NO;
                [self.selectedExercises addObject:exercise];
                if ([exercise.exerciseLiked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                    [cell.likedImage setImage:[UIImage imageNamed:@"CheckmarkW.png"]];
                    [cell.selectedImage setImage:[UIImage imageNamed:@"LikeCollectionViewCell.png"]];
                     cell.selectedImage.hidden = NO;
                }
                else {
                     cell.selectedImage.hidden = YES;
                    [cell.likedImage setImage:[UIImage imageNamed:@"CheckmarkW.png"]];
                }
        }
    }
        else {
             selectedRecentCollectionViewIndex = indexPath;
            [self performSegueWithIdentifier:@"detail" sender:nil];
        }
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
                return CGSizeMake(187.5f, 187.5f);
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

/*******************************************************/
#pragma mark - Empty Set Delegate and Datasource Methods
/*******************************************************/

//Sets the title for the empty data set.
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    //Title for the empty data set.
    NSString *title;
    
    //Setting the title for the custom exercises scroll view.
    if (scrollView == self.customExercisesCollectionView || scrollView == self.customExercisesTableView) {
        //Set the title.
        title = @"No Custom Exercises";
    }
    else {
        //Set the title.
        title = @"No Recently Viewed Exercises";
    }
    
    //Set the attributes for the empty data set title.
    NSDictionary *attributes = @{NSFontAttributeName: NAVIGATIONBAR_BUTTON_FONT,
                                 NSForegroundColorAttributeName: LIGHT_GRAY_COLOR};
    
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}

//Sets the description text for the empty data set.
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    //The description text.
    NSString *descriptionText;
    
    //Setting the title for the custom exercises scroll view.
    if (scrollView == self.customExercisesCollectionView || scrollView == self.customExercisesTableView) {
        //Set the description.
        descriptionText = @"When you create exercises they will show up here. You can create exercises by tapping on the plus button at the top right of this screen or the button below!";
    }
    else {
        //Set the description.
        descriptionText = @"Looks like you haven't viewed any exercises yet. When you do the exercises you viewed the most recently will show up here.";
    }

    //Set the paragraph style.
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    //Set the text attributes.
    NSDictionary *attributes = @{NSFontAttributeName: TABLE_VIEW_TITLE_FONT,
                                 NSForegroundColorAttributeName: LIGHT_GRAY_COLOR,
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:descriptionText attributes:attributes];
}

//Set the title text on the button in the empty data set.
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    //Define the attributes text.
    NSDictionary *attributes;
    
    //Set the appearance for the various different states of the button.
    if (state == UIControlStateNormal) {
        attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Avenir-Roman" size:18.0],NSForegroundColorAttributeName: [CommonUtilities returnModuleColor:self.moduleRender]};
    }
    else if (state == UIControlStateHighlighted || state == UIControlStateSelected) {
        attributes = @{NSFontAttributeName: NAVIGATIONBAR_BUTTON_FONT,NSForegroundColorAttributeName: WHITE_COLOR};
    }
    
    //Setting the title for the custom exercises scroll view.
    if (scrollView == self.customExercisesCollectionView || scrollView == self.customExercisesTableView) {
        return [[NSAttributedString alloc] initWithString:@"Create Exercise" attributes:attributes];
    }
    else {
        return [[NSAttributedString alloc] initWithString:@"Browse Exercises" attributes:attributes];
    }
}

//Set the vertical offset for the empty data set.
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -(self.customExercisesTableView.tableHeaderView.frame.size.height/2.0f)-25.0f;
}

//Set the spacing between the items in the empty data set.
- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 20.0f;
}

//Set the background color for the empty data set/
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor whiteColor];
}

//Called when the user presses on the empty data set button.
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    //Setting the title for the custom exercises scroll view.
    if (scrollView == self.customExercisesCollectionView || scrollView == self.customExercisesTableView) {
        [self performSegueWithIdentifier:@"createExercise" sender:nil];
    }
    else {
        [self.segmentedControl setSelectedSegmentIndex:1];
        [self setViewHidden:YES bodyZone:NO recentlyViewed:YES];
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
#pragma mark - Liked Exercise Selection Delegate Methods
/************************************************************/

//Delegate methods for selected exercises coming from FavouritesViewController
- (void)selectedFavoriteExercises:(NSMutableArray*)selectedExercises {
    self.selectedExercises = selectedExercises;
    [self.recentlyViewedTableView reloadData];
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
    bodyZones = @[@"Arms",@"Legs",@"Core",@"Back",@"Chest",@"Neck",@"Shoulders",@"Butt", @"Warmup", @"Suggested"];
    
    if (self.exerciseSelectionMode) {
        //Fill the body zone images array the body zones images.
        bodyZonesImagesExerciseSelectionMode = @[@"ArmsW.png",@"LegW.png",@"CoreW.png",@"BackW.png",@"ChestW.png",@"NeckW.png",@"ShouldersW.png",@"ButtW.png",@"WarmupW.png",@"SuggestedW.png"];
    }
    else {
        //Fill the body zone images array the body zones images.
        bodyZonesImages = @[@"Arms6.png",@"Legs6.png",@"Core6.png",@"BackMuscles6.png",@"Chest6.png",@"Neck6.png",@"Shoulders6.png",@"Butt6.png",@"Warmup.png",@"Suggested.png"];
    }
    
    //Fetch the recentlyViewed exercises.
    [self fetchRecentlyViewedExercises];
    //Fetch the custom exercises.
    [self fetchCustomExercises];
}

//Fetched the recently viewed exercises.
- (void)fetchRecentlyViewedExercises {
    //Perform task on the background thread to maintain good user interface transition.
    dispatch_async(dispatch_get_main_queue(), ^{
        SHDataHandler *dataHandler = [SHDataHandler getInstance];
        sortedRecenltyViewedExercises = [dataHandler fetchRecentlyViewedExercises];
        //Reload the recenltyviewed tableview to display the new exercises.
        [self.recentlyViewedTableView reloadData];
        [self.recentExercisesCollectionView reloadData];
    });
}

//Fetch custom exercises.
- (void)fetchCustomExercises {
    dispatch_async(dispatch_get_main_queue(), ^{
        SHDataHandler *dataHandler = [SHDataHandler getInstance];
        customExercises = [[NSMutableArray alloc] init];
        //Reload the recenltyviewed tableview to display the new exercises.
        [self.customExercisesTableView reloadData];
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

//Shows the toolbar that needs to be displayed in exercise selection mode.
- (void)showExerciseSelectionToolbar {
    self.toolbarTopCustomExercises.constant = 0.0f;
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
    if (bodyZonePressed && indexPath.item != 5) {
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

//Sets the views hidden given the paramet
- (void)setViewHidden:(BOOL)customExercises bodyZone:(BOOL)bodyZone recentlyViewed:(BOOL)recentlyViewed {
    self.recentlyViewedView.hidden = recentlyViewed;
    self.customExercisesView.hidden = customExercises;
    self.bodyZoneView.hidden = bodyZone;
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
    if ([segue.identifier isEqualToString:@"viewExercises"]) {

        UITableViewCell *cell  = [self.customExercisesTableView cellForRowAtIndexPath:selectedTableViewIndex];
        
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
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:2 muscles:nil];
                    viewExercisesViewController.viewTitle = @"Warmup Exercises";
                    break;
                case 1:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Bicep",@"Tricep",@"Forearms",@"Wrist"]];
                    
                    viewExercisesViewController.viewTitle = @"Arm Exercises";
                    break;
                case 2:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Quadriceps",@"Hamstring",@"Calf"]];
                    viewExercisesViewController.viewTitle = @"Leg Exercises";
                    break;
                case 3:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Abdominal",@"Oblique"]];
                    viewExercisesViewController.viewTitle = @"Core Exercises";
                    break;
                case 4:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Lats",@"Lower Back"]];
                    viewExercisesViewController.viewTitle = @"Back Exercises";
                    break;
                case 5:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Chest"]];
                    viewExercisesViewController.viewTitle = @"Chest Exercises";
                    break;
                case 6:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Neck"]];
                    viewExercisesViewController.viewTitle = @"Neck Exercises";
                    break;
                case 7:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Shoulder"]];
                    viewExercisesViewController.viewTitle = @"Shoulder Exercises";
                    break;
                case 8:
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[@"Glutes"]];
                    viewExercisesViewController.viewTitle = @"Butt Exercises";
                    break;
                default:
                    break;
            }
            bodyZonePressed = NO;
        }
        else {
            NSString *muscleSelected = cell.textLabel.text;
            
            viewExercisesViewController.viewTitle = [NSString stringWithFormat:@"%@ Exercises",muscleSelected];
         
            if (alertButtonIndex == 0) {
                viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[muscleSelected]];
            }
            else if (alertButtonIndex == 1) {
                viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:alertButtonIndex muscles:@[muscleSelected]];
            }
        }
    }
    
    //FOR RECENTS
    else if ([segue.identifier isEqualToString:@"detail"]) {
        if ([CommonUtilities checkUserPreference:PREFERENCE_LIST_VIEW]) {
            NSIndexPath *indexPath = [self.recentlyViewedTableView indexPathForSelectedRow];
            SHExercise *exercise = [sortedRecenltyViewedExercises objectAtIndex:indexPath.row];
            ExerciseDetailViewController *destViewController = segue.destinationViewController;
            destViewController.exerciseToDisplay = exercise;
            destViewController.viewTitle = exercise.exerciseName;
            destViewController.showActionIcon = YES;
        }
        else {
            SHExercise *exercise = [sortedRecenltyViewedExercises objectAtIndex:selectedRecentCollectionViewIndex.item];
            ExerciseDetailViewController *detailView = [[ExerciseDetailViewController alloc] init];
            detailView = segue.destinationViewController;
            detailView.exerciseToDisplay = exercise;
            detailView.viewTitle = exercise.exerciseName;
            detailView.modalView = NO;
            detailView.showActionIcon = YES;
        }
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

/**************************************/
#pragma mark - View Terminating Methods
/**************************************/

//Handles anything we need to clear or reset when the view is about to disappear.
-(void)viewWillDisappear:(BOOL)animated {
    //Dismiss any outstaning notifications.
    [TSMessage dismissActiveNotification];
}

@end
