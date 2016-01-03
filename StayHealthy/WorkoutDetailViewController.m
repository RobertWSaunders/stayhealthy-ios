//
//  WorkoutDetailViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-25.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import "WorkoutDetailViewController.h"

@interface WorkoutDetailViewController ()

@end

@implementation WorkoutDetailViewController

/***********************************/
#pragma mark - View Loading Methods
/***********************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden=YES;
    
    if (self.customWorkoutMode) {
        [self loadViewForCustomWorkout];
        if ([self.customWorkoutToDisplay.workoutSummary isEqualToString:@""] || self.customWorkoutToDisplay.workoutSummary == nil) {
            self.segmentTopSpaceConstraint.constant = 0;
            self.summaryButton.hidden = YES;
            self.summaryLabel.hidden = YES;
            self.summaryNameLabel.hidden = YES;
        }
    }
    else {
        [self loadViewForDefault];
        self.navigationItem.rightBarButtonItems = @[self.likeButton];
    }
    
    workoutAnalysis = @[@"Exercises",@"Exercises Liked",@"Times Completed",@"Difficulty",@"Workout Type",@"Target Sports",@"Target Muscles",@"Equipment"];

    
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
        self.workoutAnalysisTableView.scrollEnabled = YES;
    }
    else {
        self.workoutAnalysisTableView.scrollEnabled = NO;
    }
}

- (void)loadViewForCustomWorkout {
    self.title = self.customWorkoutToDisplay.workoutName;
    self.summaryLabel.text = self.customWorkoutToDisplay.workoutSummary;
     workoutExercises = [CommonUtilities getCustomWorkoutExercises:self.customWorkoutToDisplay];
    [self getWorkoutAnalysisContent];
 
    if ([self.customWorkoutToDisplay.liked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        [self.likeButton setImage:[UIImage imageNamed:@"likeSelected.png"]];
    }
    else {
        [self.likeButton setImage:[UIImage imageNamed:@"like.png"]];
    }
    
   }

- (void)loadViewForDefault {
    self.title = self.workoutToDisplay.workoutName;
    self.summaryLabel.text = self.workoutToDisplay.workoutSummary;
     workoutExercises = [CommonUtilities getWorkoutExercises:self.workoutToDisplay];
    [self getWorkoutAnalysisContent];
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    //Save or Update the workout information.
    if ([dataHandler workoutHasBeenSaved:self.workoutToDisplay.workoutIdentifier]) {
        self.workoutToDisplay.lastViewed = [NSDate date];
        [dataHandler updateWorkoutRecord:self.workoutToDisplay];
    }
    else {
        self.workoutToDisplay.lastViewed = [NSDate date];
        [dataHandler saveWorkoutRecord:self.workoutToDisplay];
    }
    
    if ([self.workoutToDisplay.liked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        [self.likeButton setImage:[UIImage imageNamed:@"likeSelected.png"]];
    }
    else {
        [self.likeButton setImage:[UIImage imageNamed:@"like.png"]];
    }
}

/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the height of the cells inside the tableView.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.exerciseListTableView) {
        return 76.0f;
    }
    else {
        return 50.0f;
    }
  
}

//Returns the number of rows that should be displayed in the tableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.exerciseListTableView) {
        return [workoutExercises count];
    }
    else {
        return [workoutAnalysis count];
    }
}

//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Configures the cells at a specific indexPath.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.exerciseListTableView) {
        //Define the identifier.
        static NSString *exerciseListCellIdentifier = @"exerciseTableCell";
        
        //Create reference to the cell.
        ExerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:exerciseListCellIdentifier];
        
        SHExercise *exercise = [self updateExerciseWithUserData:[workoutExercises objectAtIndex:indexPath.row]];
        
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
        
        //Return the cell.
        return cell;

    }
    else {
        //Define the identifier.
        static NSString *workoutAnalysisCell = @"analysisCell";
        
        //Create reference to the cell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:workoutAnalysisCell];
        
        if (indexPath.row == 0 || indexPath.row == 1 ||indexPath.row == 2 ||indexPath.row == 3 ||indexPath.row == 4) {
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = [workoutAnalysis objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [workoutAnalysisContent objectAtIndex:indexPath.row];
        
         cell.detailTextLabel.textColor = [CommonSetUpOperations determineDifficultyColor:[workoutAnalysisContent objectAtIndex:indexPath.row]];
        
        cell.textLabel.font = tableViewTitleTextFont;
        cell.textLabel.textColor = BLUE_COLOR;
        cell.detailTextLabel.font = tableViewDetailTextFont;
        
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
    if (tableView == self.exerciseListTableView) {
        [self performSegueWithIdentifier:@"exerciseDetail" sender:nil];
    }
    else if (tableView == self.workoutAnalysisTableView && indexPath.row >= 5) {
        [self performSegueWithIdentifier:@"showList" sender:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"performWorkout"]) {
        WorkoutViewController *view = [[WorkoutViewController alloc] init];
        view = segue.destinationViewController;
        if (self.customWorkoutMode) {
            view.viewTitle = self.customWorkoutToDisplay.workoutName;
            view.customWorkoutToDisplay = self.customWorkoutToDisplay;
        }
        else {
            view.viewTitle = self.workoutToDisplay.workoutName;
            view.workoutShown = self.workoutToDisplay;
        }
        view.workoutExercises = workoutExercises;

    }
    else if ([segue.identifier isEqualToString:@"exerciseDetail"]) {
        NSIndexPath *indexPath = [self.exerciseListTableView indexPathForSelectedRow];
        SHExercise *exercise = [workoutExercises objectAtIndex:indexPath.row];
        ExerciseDetailViewController *destViewController = segue.destinationViewController;
        destViewController.exerciseToDisplay = exercise;
        destViewController.viewTitle = exercise.exerciseName;
        destViewController.modalView = NO;
        destViewController.showActionIcon = YES;
    }
    else if ([segue.identifier isEqualToString:@"showList"]) {
        NSIndexPath *indexPath = [self.workoutAnalysisTableView indexPathForSelectedRow];
        advancedOptionsSelect *attributeSelectionPage = [[advancedOptionsSelect alloc]init];
        //Set the destination.
        attributeSelectionPage = segue.destinationViewController;
        if (indexPath.row == 5) {
            attributeSelectionPage.titleText = @"Target Sports";
            attributeSelectionPage.arrayForTableView = [self.workoutToDisplay.workoutTargetSports componentsSeparatedByString:@","];
        }
        else if (indexPath.row == 6) {
            attributeSelectionPage.titleText = @"Target Muscles";
            attributeSelectionPage.arrayForTableView = [self.workoutToDisplay.workoutTargetMuscles componentsSeparatedByString:@","];
        }
        else if (indexPath.row == 7) {
            attributeSelectionPage.titleText = @"Equipment";
            attributeSelectionPage.arrayForTableView = [self.workoutToDisplay.workoutEquipment componentsSeparatedByString:@","];
        }
        attributeSelectionPage.viewMode = YES;
    }
    else if ([segue.identifier isEqualToString:@"editCustomWorkout"]) {
        UINavigationController *navController = segue.destinationViewController;
        WorkoutCreateViewController *createWorkoutController = [[WorkoutCreateViewController alloc] init];
        createWorkoutController = navController.viewControllers[0];
        createWorkoutController.editMode = YES;
        createWorkoutController.workoutToEdit = self.customWorkoutToDisplay;
        createWorkoutController.workoutToEditExercises = [workoutExercises mutableCopy];
    }
}


- (IBAction)startWorkoutButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"performWorkout" sender:nil];
}

- (IBAction)segmentValueChanged:(UISegmentedControl*)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.workoutAnalysisView.hidden = YES;
        self.exerciseListView.hidden = NO;
    }
    else {
        self.workoutAnalysisView.hidden = NO;
        self.exerciseListView.hidden = YES;
    }
}

- (SHExercise *)updateExerciseWithUserData:(SHExercise*)exercise {
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    Exercise *dataExercise = [dataHandler fetchExerciseByIdentifier:exercise.exerciseIdentifier];
    
    if (dataExercise != nil) {
        exercise.lastViewed = dataExercise.lastViewed;
        exercise.liked = dataExercise.liked;
    }
    
    return exercise;
}

- (void)updateTableView {
    [self.exerciseListTableView reloadData];
}



//Changes the images for the favorite button when the user presses it.
-(void)changeImage {
    if ([self.likeButton.image isEqual:[UIImage imageNamed:@"like.png"]])
        [self.likeButton setImage:[UIImage imageNamed:@"likeSelected.png"]];
    else
        [self.likeButton setImage:[UIImage imageNamed:@"like.png"]];
}

//The mehtod that saves the favorite or takes it away.
- (IBAction)update:(id)sender {
    [self favourite];
    
}

- (void)favourite {
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    [self changeImage];
    
    if ([self.likeButton.image isEqual:[UIImage imageNamed:@"likeSelected.png"]]) {
        if (self.customWorkoutToDisplay) {
            self.customWorkoutToDisplay.liked = [NSNumber numberWithBool:YES];
        }
        else {
            self.workoutToDisplay.liked = [NSNumber numberWithBool:YES];
        }
        
    }
    else {
        if (self.customWorkoutToDisplay) {
             self.customWorkoutToDisplay.liked = [NSNumber numberWithBool:NO];
        }
        else {
            self.workoutToDisplay.liked = [NSNumber numberWithBool:NO];
        }
        
    }
    
    //Save or Update the exercise information.
    
    if (self.customWorkoutToDisplay) {
        [dataHandler updateCustomWorkoutRecord:self.customWorkoutToDisplay];
    }
    else {
        if ([dataHandler workoutHasBeenSaved:self.workoutToDisplay.workoutIdentifier]) {
            [dataHandler updateWorkoutRecord:self.workoutToDisplay];
        }
        else {
            [dataHandler saveWorkoutRecord:self.workoutToDisplay];
        }
    }
   
    
   
    
}


- (IBAction)summaryButtonPressed:(id)sender {
    //No stretching for bicep, chest, forearms, oblique.
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Workout Summary" andMessage:self.workoutToDisplay.workoutSummary];
    
    [alertView addButtonWithTitle:@"Close"
                             type:SIAlertViewButtonTypeCancel
                          handler:nil];
    
    [alertView show];

    
}

- (void)getWorkoutAnalysisContent {
    
    NSUInteger numExercises;
    NSString *timesCompleted;
    
    if (self.customWorkoutMode) {
        numExercises = [CommonUtilities numExercisesInCustomWorkout:self.customWorkoutToDisplay];
        if (self.customWorkoutToDisplay.timesCompleted == nil) {
            timesCompleted = @"0";
        }
        else {
            timesCompleted = [NSString stringWithFormat:@"%@",self.workoutToDisplay.timesCompleted];
        }
    
        
    }
    else {
        numExercises = [CommonUtilities numExercisesInWorkout:self.workoutToDisplay];
        if (self.workoutToDisplay.timesCompleted == nil) {
            timesCompleted = @"0";
        }
        else {
            timesCompleted = [NSString stringWithFormat:@"%@",self.workoutToDisplay.timesCompleted];
        }
        
    }
    
    NSString *numE = [NSString stringWithFormat:@"%lu",(unsigned long)numExercises];
    
    NSMutableArray *likedExercises = [[NSMutableArray alloc] init];
    for (SHExercise *exercise in workoutExercises) {
        SHExercise *update = [self updateExerciseWithUserData:exercise];
        if ([update.liked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            [likedExercises addObject:exercise];
        }
    }
    NSString *likeNum = [NSString stringWithFormat:@"%lu",(unsigned long)[likedExercises count]];
    
    if (self.customWorkoutMode) {
          workoutAnalysisContent = @[numE,likeNum,timesCompleted,self.customWorkoutToDisplay.workoutDifficulty,self.customWorkoutToDisplay.workoutType,self.customWorkoutToDisplay.workoutTargetSports,self.customWorkoutToDisplay.workoutTargetMuscles,self.customWorkoutToDisplay.workoutEquipment];
    }
    else {
          workoutAnalysisContent = @[numE,likeNum,timesCompleted,self.workoutToDisplay.workoutDifficulty,self.workoutToDisplay.workoutType,self.workoutToDisplay.workoutTargetSports,self.workoutToDisplay.workoutTargetMuscles,self.workoutToDisplay.workoutEquipment];
    }
        
  
}

- (IBAction)editButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"editCustomWorkout" sender:nil];
}
@end
