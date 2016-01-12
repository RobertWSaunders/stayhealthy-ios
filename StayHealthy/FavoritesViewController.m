//
//  FavoritesViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-10-17.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

/**********************************/
#pragma mark - View Loading Methods
/**********************************/

//Perform any set up for the view once it has loaded.
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     //self.favoritesTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

     [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_FAVORITES  viewController:self message:@"Here you can view all of your favourite exercises and workouts, you can toggle between the different types of exercises and workouts with the control just under the top bar."];
    
    
    if (self.exerciseSelectionMode) {
        [self.segmentedControl removeSegmentAtIndex:3 animated:NO];
        self.tabBarController.tabBar.hidden = YES;
    }
    else {
        self.tabBarController.tabBar.hidden = NO;
    }
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    [self setNotificationObservers];
    [self fetchLikedExercises];
    
}

/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the height of the cells inside the tableView.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (workoutData) {
            return 95.0f;
    }
    else {
            return 76.0f;
    }
    

    
}

//Returns the number of rows that should be displayed in the tableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [favoritesData count];
    
}

//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
    
}

//Configures the cells at a specific indexPath.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *exerciseTableCell = @"exerciseTableCell";
    static NSString *workoutTableCell = @"workoutCell";
    
    if (self.segmentedControl.selectedSegmentIndex != 3) {
        
        //Create the reference for the cell.
        ExerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:exerciseTableCell];
        
        //If the cell can't be found then just create one.
        if (cell == nil) {
            cell = [[ExerciseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:exerciseTableCell];
        }
        
        SHExercise *exercise = [favoritesData objectAtIndex:indexPath.row];
        
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
        
        
        //Set the selected cell background.
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
        
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
    else {
        //Create the reference for the cell.
        WorkoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:workoutTableCell];
        
        //If the cell can't be found then just create one.
        if (cell == nil) {
            cell = [[WorkoutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:workoutTableCell];
        }
        
        if ([[favoritesData objectAtIndex:indexPath.row] isKindOfClass:[SHWorkout class]]) {
            SHWorkout *workout = [favoritesData objectAtIndex:indexPath.row];
            
            cell.workoutName.text = workout.workoutName;
            cell.workoutDifficulty.text = workout.workoutDifficulty;
            cell.workoutType.text = workout.workoutType;
            cell.workoutExercises.text = [NSString stringWithFormat:@"%ld",[CommonUtilities numExercisesInWorkout:workout]];
            
            cell.workoutDifficulty.textColor = [CommonSetUpOperations determineDifficultyColor:workout.workoutDifficulty];
            
            NSMutableArray *workoutExercises = [CommonUtilities getWorkoutExercises:workout];
            
            SHExercise *imageExercise = [workoutExercises objectAtIndex:[CommonUtilities numExercisesInWorkout:workout]-2];
            
            [CommonSetUpOperations loadImageOnBackgroundThread:cell.workoutImage image:[UIImage imageNamed:imageExercise.exerciseImageFile]];
            
             [cell.likeWorkoutImage setImage:[UIImage imageNamed:@"likeSelectedColored.png"]];
            
            
        }
        else {
            SHCustomWorkout *workout = [self updateWorkoutWithUserData:[favoritesData objectAtIndex:indexPath.row]];
            
            cell.workoutName.text = workout.workoutName;
            cell.workoutDifficulty.text = workout.workoutDifficulty;
            cell.workoutType.text = workout.workoutType;
            cell.workoutExercises.text = [NSString stringWithFormat:@"%ld",[CommonUtilities numExercisesInCustomWorkout:workout]];
            
            cell.workoutDifficulty.textColor = [CommonSetUpOperations determineDifficultyColor:workout.workoutDifficulty];
            
            NSMutableArray *workoutExercises = [CommonUtilities getCustomWorkoutExercises:workout];
            
            if (workoutExercises.count>0) {
                SHExercise *imageExercise = [workoutExercises objectAtIndex:[CommonUtilities numExercisesInCustomWorkout:workout]-1];
                [CommonSetUpOperations loadImageOnBackgroundThread:cell.workoutImage image:[UIImage imageNamed:imageExercise.exerciseImageFile]];
            }
            
            [cell.likeWorkoutImage setImage:[UIImage imageNamed:@"likeSelectedColored.png"]];
            [cell.customWorkoutImage setImage:[UIImage imageNamed:@"CustomWorkout.png"]];
            
            
            
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
                [self fetchLikedWorkouts];
                return YES;
            }]];
            cell.rightExpansion.fillOnTrigger = YES;
            cell.rightExpansion.threshold = 2.0f;
            cell.rightExpansion.buttonIndex = 0;
            cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
            
            //Set the selected cell background.
            [CommonSetUpOperations tableViewSelectionColorSet:cell];
        }
        
        
        
        //Set the selected cell background.
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
   
        return cell;
}
}

//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

//What happens when the user selects a cell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.exerciseSelectionMode) {
        if (self.exerciseSelectionMode) {
            ExerciseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            SHExercise *exercise = [favoritesData objectAtIndex:indexPath.row];
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
    }
    else {
        if (workoutData) {
            [self performSegueWithIdentifier:@"workoutDetail" sender:nil];
        }
        else {
            [self performSegueWithIdentifier:@"exerciseDetail" sender:nil];
        }
    }
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*****************************/
#pragma mark - Helper Methods
/*****************************/

//Fetches the exercises the user has liked.
- (void)fetchLikedExercises {
    //Fetch and update the UI on the background thread to not corrupt the autolayout engine.
    dispatch_async(dispatch_get_main_queue(), ^{
        SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
        //Fetches the recently viewed exercises, in Exercise object.
        NSArray *favoriteExercise;
    
        if (self.segmentedControl.selectedSegmentIndex == 0) {
            favoriteExercise = [[SHDataHandler getInstance] getStrengthLikedExercises];
        }
        else if (self.segmentedControl.selectedSegmentIndex == 1) {
            favoriteExercise = [[SHDataHandler getInstance] getStretchLikedExercises];
        }
        else {
            favoriteExercise = [[SHDataHandler getInstance] getWarmupLikedExercises];
        }
    
        favoritesData = [[NSMutableArray alloc] init];
    
        //Converts Exercise object to usable SHExercise object.
        for (int i = 0; i < favoriteExercise.count; i++) {
            [favoritesData addObject:[dataHandler convertExerciseToSHExercise:[favoriteExercise objectAtIndex:i]]];
        }
    
        //[self showMessage:exerciseType];
    
        workoutData = NO;
        //Reload the recenltyviewed tableview to display the new exercises.
        [self.favoritesTableView reloadData];
        
    });
}

//Fetches the workouts the user has liked.
- (void)fetchLikedWorkouts {
    
    //Fetch and update the UI on the background thread to not corrupt the autolayout engine.
    dispatch_async(dispatch_get_main_queue(), ^{
        SHDataHandler *dataHandler = [SHDataHandler getInstance];
        

        NSArray *favoriteWorkout;
        NSArray *favoriteCustomWorkout;
        
        favoriteWorkout = [[SHDataHandler getInstance] getLikedWorkouts];
        favoriteCustomWorkout = [[SHDataHandler getInstance] getLikedCustomWorkouts];

        NSMutableArray *data = [[NSMutableArray alloc] init];
        
        //Converts Exercise object to usable SHExercise object.
        for (int i = 0; i < favoriteWorkout.count; i++) {
            [data addObject:[dataHandler convertWorkoutToSHWorkout:[favoriteWorkout objectAtIndex:i]]];
        }
        
        //Converts Exercise object to usable SHExercise object.
        for (int i = 0; i < favoriteCustomWorkout.count; i++) {
            [data addObject:[favoriteCustomWorkout objectAtIndex:i]];
        }

        
        favoritesData = data;
        
        //[self showMessage:exerciseType];
        
        workoutData = YES;
        
        //Reload the recenltyviewed tableview to display the new exercises.
        [self.favoritesTableView reloadData];
    });
}


//Shows a TSMessage if there is no favorites.
- (void)showMessage:(exerciseTypes)exerciseType {
    if (favoritesData.count == 0) {
        NSString *type;
        if (exerciseType == strength) {
            type = @"strength";
        }
        else if (exerciseType == stretching) {
            type = @"stretching";
        }
        else if (exerciseType == warmup) {
            type = @"warmup";
        }
        else {
            type = @"workouts";
        }
       // [CommonSetUpOperations performTSMessage:[NSString stringWithFormat:@"Looks like you don't have any favorite %@ exercises!",type] message:nil viewController:self canBeDismissedByUser:YES duration:6];
    }
}

/*********************/
#pragma mark - Actions
/*********************/

//What happens when the segmented control value changes.
- (IBAction)segmentValueChanged:(UISegmentedControl*)sender {
    if (sender.selectedSegmentIndex != 3) {
        [self fetchLikedExercises];
    }
    else {
        [self fetchLikedWorkouts];
    }
}

/********************************/
#pragma mark - Prepare For Segue
/********************************/

//Notifies the view controller that a segue is about to be performed.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"workoutDetail"]) {
        NSIndexPath *indexPath = [self.favoritesTableView indexPathForSelectedRow];
        if ([[favoritesData objectAtIndex:indexPath.row] isKindOfClass:[SHWorkout class]]) {
            SHWorkout *workout = [favoritesData objectAtIndex:indexPath.row];
            WorkoutDetailViewController *detailView = [[WorkoutDetailViewController alloc] init];
            detailView = segue.destinationViewController;
            detailView.workoutToDisplay = workout;

        }
        else {
            SHCustomWorkout *workout = [favoritesData objectAtIndex:indexPath.row];
            WorkoutDetailViewController *detailView = [[WorkoutDetailViewController alloc] init];
            detailView = segue.destinationViewController;
            detailView.customWorkoutToDisplay = workout;
            detailView.customWorkoutMode = YES;
        }
        
    }
    else if ([segue.identifier isEqualToString:@"addToWorkout"]) {
        UINavigationController *navController = [[UINavigationController alloc] init];
        CustomWorkoutSelectionViewController *customWorkoutSelection = [[CustomWorkoutSelectionViewController alloc] init];
        navController = segue.destinationViewController;
        customWorkoutSelection = navController.viewControllers[0];
        customWorkoutSelection.exerciseToAdd = [favoritesData objectAtIndex:selectedIndex.row];
    }
    else if ([segue.identifier isEqualToString:@"editWorkout"]) {
        NSIndexPath *indexPath = [self.favoritesTableView indexPathForSelectedRow];
        UINavigationController *navController = segue.destinationViewController;
        WorkoutCreateViewController *createWorkoutController = [[WorkoutCreateViewController alloc] init];
        createWorkoutController = navController.viewControllers[0];
        SHCustomWorkout *customWorkout = [favoritesData objectAtIndex:indexPath.row];
        createWorkoutController.editMode = YES;
        createWorkoutController.workoutToEdit = customWorkout;
        createWorkoutController.workoutToEditExercises = [CommonUtilities getCustomWorkoutExercises:customWorkout];
    }
    else {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        NSIndexPath *indexPath = [self.favoritesTableView indexPathForSelectedRow];
        SHExercise *exercise = [favoritesData objectAtIndex:indexPath.row];
        ExerciseDetailViewController *destViewController = segue.destinationViewController;
        destViewController.exerciseToDisplay = exercise;
        destViewController.viewTitle = exercise.exerciseName;
        destViewController.showActionIcon = YES;
    }
 
}

- (id)updateWorkoutWithUserData:(SHCustomWorkout*)workout {
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    Workout *dataWorkout = [dataHandler fetchWorkoutByIdentifier:workout.workoutID];
    
    if (dataWorkout != nil) {
        workout.lastViewed = dataWorkout.lastViewed;
        workout.liked = dataWorkout.liked;
    }
    
    return workout;
}

//Sets the observers for the notifications that need to be observed for.
- (void)setNotificationObservers {
    //Observe for changes. All just reload the recently
    //iCloud update notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateForCloud) name:CLOUD_UPDATE_NOTIFICATION object:nil];
    //Changes in a exercise record, i.e. changes in lastViewed.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateForExercise) name:EXERCISE_UPDATE_NOTIFICATION object:nil];
    //Changes in a exercise favorite.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateForExercise) name:EXERCISE_SAVE_NOTIFICATION object:nil];
    //Changes in a exercise record, i.e. changes in lastViewed.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateForWorkouts) name:CUSTOM_WORKOUT_DELETE_NOTIFICATION object:nil];
    //Changes in a exercise favorite.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateForWorkouts) name:CUSTOM_WORKOUT_SAVE_NOTIFICATION object:nil];
    //Changes in a exercise favorite.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateForWorkouts) name:CUSTOM_WORKOUT_UPDATE_NOTIFICATION object:nil];
    //Changes in a exercise record, i.e. changes in lastViewed.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateForWorkouts) name:WORKOUT_SAVE_NOTIFICATION object:nil];
    //Changes in a exercise favorite.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateForWorkouts) name:WORKOUT_UPDATE_NOTIFICATION object:nil];
}

- (void)updateForCloud {
    if (self.segmentedControl.selectedSegmentIndex < 3) {
        [self fetchLikedExercises];
    }
    else {
        [self fetchLikedWorkouts];
    }
}

- (void)updateForExercise {
    if (self.segmentedControl.selectedSegmentIndex < 3) {
        [self fetchLikedExercises];
    }
}
-(void)updateForWorkouts {
    if (self.segmentedControl.selectedSegmentIndex == 3) {
        [self fetchLikedWorkouts];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [TSMessage dismissActiveNotification];
    
    // check if the back button was pressed
    if (self.isMovingFromParentViewController) {
        if (self.exerciseSelectionMode) {
            [self.delegate selectedFavoriteExercises:self.selectedExercises];
        }
    }
}

@end
