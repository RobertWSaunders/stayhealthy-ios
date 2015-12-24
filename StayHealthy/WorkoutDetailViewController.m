//
//  WorkoutDetailViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-25.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import "WorkoutDetailViewController.h"

@interface WorkoutDetailViewController ()

@end

@implementation WorkoutDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    workoutExercises = [CommonUtilities getWorkoutExercises:self.workoutToDisplay];
    workoutAnalysis = @[@"Exercises",@"Exercises Liked",@"Times Completed",@"Difficulty",@"Workout Type",@"Target Sports",@"Target Muscles",@"Equipment"];
    
    NSUInteger numExercises = [CommonUtilities numExercisesInWorkout:self.workoutToDisplay];
    NSString *numE = [NSString stringWithFormat:@"%lu",(unsigned long)numExercises];
    
    NSMutableArray *likedExercises = [[NSMutableArray alloc] init];
    for (SHExercise *exercise in workoutExercises) {
        SHExercise *update = [self updateExerciseWithUserData:exercise];
        if ([update.liked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            [likedExercises addObject:exercise];
        }
    }
    NSString *likeNum = [NSString stringWithFormat:@"%lu",(unsigned long)[likedExercises count]];
    
    NSString *timesCompleted;
    
    if (self.workoutToDisplay.timesCompleted == nil) {
        timesCompleted = @"0";
    }
    else {
         timesCompleted = [NSString stringWithFormat:@"%@",self.workoutToDisplay.timesCompleted];
    }
   
    
    workoutAnalysisContent = @[numE,likeNum,timesCompleted,self.workoutToDisplay.workoutDifficulty,self.workoutToDisplay.workoutType,self.workoutToDisplay.workoutTargetSports,self.workoutToDisplay.workoutTargetMuscles,self.workoutToDisplay.workoutEquipment];
    
    self.title =  self.workoutToDisplay.workoutName;
    
    self.summaryLabel.text = self.workoutToDisplay.workoutSummary;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:exerciseFavNotification object:nil];
    
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    
    //Save or Update the exercise information.
    if ([dataHandler workoutHasBeenSaved:self.workoutToDisplay.workoutIdentifier]) {
        self.workoutToDisplay.lastViewed = [NSDate date];
        [dataHandler updateWorkoutRecord:self.workoutToDisplay];
    }
    else {
        self.workoutToDisplay.lastViewed = [NSDate date];
        [dataHandler saveWorkoutRecord:self.workoutToDisplay];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:exerciseNotification object:nil];
    
    
    if ([self.workoutToDisplay.liked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        [self.likeButton setImage:[UIImage imageNamed:@"likeSelected.png"]];
    }
    else {
        [self.likeButton setImage:[UIImage imageNamed:@"like.png"]];
    }
    
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
        self.workoutAnalysisTableView.scrollEnabled = YES;
    }
    else {
        self.workoutAnalysisTableView.scrollEnabled = NO;
    }
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
    if (tableView == self.exerciseListTableView) {
        return 76.0f;
    }
    else {
        return 44.0f;
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
            cell.likeExerciseImage.tintColor = STAYHEALTHY_BLUE;
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
        
        cell.textLabel.font = tableViewTitleTextFont;
        cell.textLabel.textColor = STAYHEALTHY_BLUE;
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
        view.workoutExercises = workoutExercises;
        view.viewTitle = self.workoutToDisplay.workoutName;
        view.workoutShown = self.workoutToDisplay;
    }
    else if ([segue.identifier isEqualToString:@"exerciseDetail"]) {
        NSIndexPath *indexPath = [self.exerciseListTableView indexPathForSelectedRow];
        SHExercise *exercise = [workoutExercises objectAtIndex:indexPath.row];
        ExerciseDetailViewController *destViewController = segue.destinationViewController;
        destViewController.exerciseToDisplay = exercise;
        destViewController.viewTitle = exercise.exerciseName;
        destViewController.modalView = NO;
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
        self.workoutToDisplay.liked = [NSNumber numberWithBool:YES];
    }
    else {
        self.workoutToDisplay.liked = [NSNumber numberWithBool:NO];
    }
    
    //Save or Update the exercise information.
    if ([dataHandler workoutHasBeenSaved:self.workoutToDisplay.workoutIdentifier]) {
        [dataHandler updateWorkoutRecord:self.workoutToDisplay];
    }
    else {
        [dataHandler saveWorkoutRecord:self.workoutToDisplay];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:workoutFavNotification object:nil];
    
}


- (IBAction)summaryButtonPressed:(id)sender {
    //No stretching for bicep, chest, forearms, oblique.
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"Workout Summary" andMessage:self.workoutToDisplay.workoutSummary];
    
    [alertView addButtonWithTitle:@"Close"
                             type:SIAlertViewButtonTypeCancel
                          handler:nil];
    
    [alertView show];

    
}

@end
