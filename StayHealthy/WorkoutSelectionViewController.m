 //
//  WorkoutSelectionViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-22.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import "WorkoutSelectionViewController.h"

@interface WorkoutSelectionViewController ()

@end

@implementation WorkoutSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.yourWorkoutsTableView.emptyDataSetSource = self;
    self.yourWorkoutsTableView.emptyDataSetDelegate = self;
    
    [self.browseScroller setScrollEnabled:YES];
    [self.browseOptionsTableView setScrollEnabled:NO];
    
    browseOptions = @[@"Sports",@"Muscles",@"Equipment",@"Types",@"Difficulties", @"Recents"];
    browseOptionsImages = @[@"Sports.png",@"Muscles.png",@"Equipment.png",@"Types.png",@"Difficulty.png", @"Recents.png"];
    
    //[self fetchCustomWorkouts];
    [self setNotificationObservers];
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_WORKOUTS viewController:self message:@"Here you can browse the workouts that we provide or create your very own by tapping on the add icon in the top right. You can search for workouts based off of certain sports, muscles, equipment and more! You can also perform an advanced search by tapping on the icon in the top left. Good luck with all of your workouts!"];
    
    // A little trick for removing the cell separators
    self.yourWorkoutsTableView.tableFooterView = [UIView new];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No Custom Workouts";
    
    NSDictionary *attributes = @{NSFontAttributeName: NAVIGATIONBAR_BUTTON_FONT,
                                 NSForegroundColorAttributeName: LIGHT_GRAY_COLOR};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"When you create workouts they will show up here. You can create workouts by tapping on the plus button at the top right of this screen or the button below! ";
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: TABLE_VIEW_TITLE_FONT,
                                 NSForegroundColorAttributeName: LIGHT_GRAY_COLOR,
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSDictionary *attributes;
    if (state == UIControlStateNormal) {
        attributes = @{NSFontAttributeName: [UIFont fontWithName:@"Avenir-Roman" size:18.0],NSForegroundColorAttributeName: WORKOUTS_COLOR};
    }
    else if (state == UIControlStateHighlighted || state == UIControlStateSelected) {
        attributes = @{NSFontAttributeName: NAVIGATIONBAR_BUTTON_FONT,NSForegroundColorAttributeName: WHITE_COLOR};
    }

    
    return [[NSAttributedString alloc] initWithString:@"Create Workout" attributes:attributes];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return -(self.yourWorkoutsTableView.tableHeaderView.frame.size.height/2.0f)-25.0f;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
{
    return 20.0f;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    NSLog(@"HELLO");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the height of the cells inside the tableView.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.yourWorkoutsTableView) {
        return 95.0f;
    }
    else {
        return 44.0f;
    }
    
}

//Returns the number of rows that should be displayed in the tableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.yourWorkoutsTableView) {
        return [customWorkouts count];
    }
    else {
        return [browseOptions count];
    }
}

//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Configures the cells at a specific indexPath.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.yourWorkoutsTableView) {
        //Define the identifier.
        static NSString *muscleSelectionCellIdentifier = @"workoutCell";
        
        //Create reference to the cell.
        WorkoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleSelectionCellIdentifier];
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
        
        SHCustomWorkout *workout = nil;//[self updateWorkoutWithUserData:[customWorkouts objectAtIndex:indexPath.row]];
        
        cell.workoutName.text = workout.workoutName;
        cell.workoutDifficulty.text = workout.workoutDifficulty;
        cell.workoutType.text = workout.workoutType;
        cell.workoutExercises.text = [NSString stringWithFormat:@"%ld",[CommonUtilities numExercisesInCustomWorkout:workout]];
        
        cell.workoutDifficulty.textColor = [CommonSetUpOperations determineDifficultyColor:workout.workoutDifficulty];
        
        NSMutableArray *workoutExercises = [CommonUtilities getCustomWorkoutExercises:workout];
        
        if (workoutExercises.count>0) {
         SHExercise *imageExercise = [workoutExercises objectAtIndex:[workoutExercises count]-1];
            [CommonSetUpOperations loadImageOnBackgroundThread:cell.workoutImage image:[UIImage imageNamed:imageExercise.exerciseImageFile]];
        }
    
        
        
        
        if ([workout.liked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            cell.customWorkoutImage.hidden = NO;
            cell.likeWorkoutImage.hidden = NO;
            [cell.likeWorkoutImage setImage:[UIImage imageNamed:@"likeSelectedColored.png"]];
            [cell.customWorkoutImage setImage:[UIImage imageNamed:@"CustomWorkout.png"]];
        }
        else {
            [cell.likeWorkoutImage setImage:[UIImage imageNamed:@"CustomWorkout.png"]];
            cell.customWorkoutImage.hidden = YES;
        }
        
        
        cell.leftButtons = @[[MGSwipeButton buttonWithTitle:nil icon:[UIImage imageNamed:@"EditSwipe.png"] backgroundColor:BLUE_COLOR callback:^BOOL(MGSwipeTableCell *sender){
            [self performSegueWithIdentifier:@"editWorkout" sender:nil];
            return YES;
        }]];
        cell.leftExpansion.fillOnTrigger = YES;
        cell.leftExpansion.threshold = 2.0f;
        cell.leftExpansion.buttonIndex = 0;
        cell.leftSwipeSettings.transition = MGSwipeTransitionDrag;
        
        
        //configure right buttons
        cell.rightButtons = @[[MGSwipeButton buttonWithTitle:nil icon:[UIImage imageNamed:@"DeleteSwipe.ong"] backgroundColor:RED_COLOR callback:^BOOL(MGSwipeTableCell *sender) {
            SHDataHandler *dataHandler = [SHDataHandler getInstance];
            [dataHandler deleteCustomWorkoutRecord:workout];
            //[self fetchCustomWorkouts];
           return YES;
        }]];
        cell.rightExpansion.fillOnTrigger = YES;
        cell.rightExpansion.threshold = 2.0f;
        cell.rightExpansion.buttonIndex = 0;
        cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
        
        //Set the selected cell background.
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
        
    
        //Return the cell.
        return cell;

    }
    else {
        //Define the identifier.
        static NSString *muscleSelectionCellIdentifier = @"browseOptionCell";
        
        //Create reference to the cell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleSelectionCellIdentifier];
        
        cell.textLabel.text = [browseOptions objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[browseOptionsImages objectAtIndex:indexPath.row]];
        
        cell.textLabel.textColor = BLUE_COLOR;
        cell.textLabel.font = TABLE_VIEW_TITLE_FONT;
        
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
        //Return the cell.
        return cell;

    }
}


//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

//What happens when the user selects a cell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.browseOptionsTableView) {
        [self performSegueWithIdentifier:@"browseOptions" sender:nil];
    }
    else if (tableView ==  self.yourWorkoutsTableView) {
        selectedIndexPath = indexPath;
        [self performSegueWithIdentifier:@"workoutDetail" sender:nil];
    }
       [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"advancedSearch"]) {
        UINavigationController *navController = segue.destinationViewController;
        WorkoutsAdvancedSearchViewController *advancedSearchController = [[WorkoutsAdvancedSearchViewController alloc] init];
        advancedSearchController = navController.viewControllers[0];
        
    }
    else if ([segue.identifier isEqualToString:@"createWorkout"]) {
        UINavigationController *navController = segue.destinationViewController;
        WorkoutCreateViewController *createWorkoutController = [[WorkoutCreateViewController alloc] init];
        createWorkoutController = navController.viewControllers[0];
        createWorkoutController.editMode = NO;
    }
    else if ([segue.identifier isEqualToString:@"browseOptions"]) {
        WorkoutBrowseOptionsViewController *browseOptionsView = [[WorkoutBrowseOptionsViewController alloc] init];
        
        browseOptionsView = segue.destinationViewController;
        
        if (browseIndexPath.row == 0) {
            browseOptionsView.passedOption = targetSports;
            browseOptionsView.viewTitle = @"Target Sport";
        }
        else if (browseIndexPath.row == 1) {
            browseOptionsView.passedOption = targetMuscles;
            browseOptionsView.viewTitle = @"Target Muscle";
        }
        else if (browseIndexPath.row == 2) {
            browseOptionsView.passedOption = workoutEquipment;
            browseOptionsView.viewTitle = @"Workout Equipment";
        }
        else if (browseIndexPath.row == 3) {
            browseOptionsView.passedOption = workoutType;
            browseOptionsView.viewTitle = @"Workout Type";
        }
        else {
            browseOptionsView.passedOption = workoutDifficulty;
            browseOptionsView.viewTitle = @"Workout Difficulty";
        }
    }
    else if ([segue.identifier isEqualToString:@"workoutDetail"]) {
        SHCustomWorkout *workout = [customWorkouts objectAtIndex:selectedIndexPath.row];
        WorkoutDetailViewController *detailView = [[WorkoutDetailViewController alloc] init];
        detailView = segue.destinationViewController;
        detailView.customWorkoutToDisplay = workout;
        detailView.customWorkoutMode = YES;
    }
    else if ([segue.identifier isEqualToString:@"editWorkout"]) {
        NSIndexPath *indexPath = [self.yourWorkoutsTableView indexPathForSelectedRow];
        UINavigationController *navController = segue.destinationViewController;
        WorkoutCreateViewController *createWorkoutController = [[WorkoutCreateViewController alloc] init];
        createWorkoutController = navController.viewControllers[0];
        SHCustomWorkout *customWorkout = [customWorkouts objectAtIndex:indexPath.row];
        createWorkoutController.editMode = YES;
        createWorkoutController.workoutToEdit = customWorkout;
        createWorkoutController.workoutToEditExercises = [CommonUtilities getCustomWorkoutExercises:customWorkout];
        }
    else if ([segue.identifier isEqualToString:@"workoutList"]) {
        WorkoutListViewController *listView = [[WorkoutListViewController alloc] init];
        listView = segue.destinationViewController;
        listView.viewTitle = @"Recently Viewed";
        listView.workoutDataSent = [self fetchRecentlyViewedWorkouts];
    }
}

//Fetches the recently viewed exercises and loads them into the tableView.
- (NSMutableArray*)fetchRecentlyViewedWorkouts {

        
    
    //Fetches the recently viewed exercises, in Exercise object.
    /*
        NSArray *recenltyViewedWorkoutsData = [[SHDataHandler getInstance] getRecentlyViewedWorkouts];
        
        NSMutableArray *recenltyViewedWorkouts = [[NSMutableArray alloc] init];
        
        //Converts Exercise object to usable SHExercise object.
        for (int i = 0; i < recenltyViewedWorkoutsData.count; i++) {
            if (i == 50) {
                break;
            }
            else {
                [recenltyViewedWorkouts addObject:[SHDataUtilities convertWorkoutToSHWorkout:[recenltyViewedWorkoutsData objectAtIndex:i]]];
            }
        }
    */
    return nil;
    
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [browseOptions count];
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BodyViewCollectionViewCell *cell = (BodyViewCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [CommonSetUpOperations styleCollectionViewCellBodyZone:cell];
    cell.bodyZoneLabel.textColor = WORKOUTS_COLOR;
    cell.bodyZoneLabel.text = [browseOptions objectAtIndex:indexPath.row];
    cell.bodyZoneImage.image = [UIImage imageNamed:[browseOptionsImages objectAtIndex:indexPath.row]];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    browseIndexPath = indexPath;
    if (indexPath.item == 5) {
        [self performSegueWithIdentifier:@"workoutList" sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"browseOptions" sender:nil];
    }

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




- (IBAction)segmentValueChanged:(UISegmentedControl*)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.browseWorkoutsView.hidden = NO;
        self.yourWorkoutsView.hidden = YES;
    }
    else {
        self.browseWorkoutsView.hidden = YES;
        self.yourWorkoutsView.hidden = NO;
    }
}


- (IBAction)addCustomWorkout:(id)sender {
    [self performSegueWithIdentifier:@"createWorkout" sender:nil];
}

- (IBAction)workoutSearch:(id)sender {
    [self performSegueWithIdentifier:@"advancedSearch" sender:nil];
}

- (void)workoutUpdate
{
    //[self fetchCustomWorkouts];
}

//Sets the observers for the notifications that need to be observed for.
- (void)setNotificationObservers {
    //Observe for changes. All just reload the recently
    //iCloud update notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(workoutUpdate) name:CLOUD_UPDATE_NOTIFICATION object:nil];
        //Changes in a exercise record, i.e. changes in lastViewed.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(workoutUpdate) name:CUSTOM_WORKOUT_DELETE_NOTIFICATION object:nil];
    //Changes in a exercise favorite.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(workoutUpdate) name:CUSTOM_WORKOUT_SAVE_NOTIFICATION object:nil];
    //Changes in a exercise favorite.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(workoutUpdate) name:CUSTOM_WORKOUT_UPDATE_NOTIFICATION object:nil];
    //Changes in a exercise record, i.e. changes in lastViewed.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(workoutUpdate) name:WORKOUT_SAVE_NOTIFICATION object:nil];
    //Changes in a exercise favorite.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(workoutUpdate) name:WORKOUT_UPDATE_NOTIFICATION object:nil];
}

@end
