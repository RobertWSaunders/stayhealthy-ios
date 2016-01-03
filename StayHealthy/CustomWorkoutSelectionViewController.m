//
//  CustomWorkoutSelectionViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-12-26.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import "CustomWorkoutSelectionViewController.h"

@interface CustomWorkoutSelectionViewController ()

@end

@implementation CustomWorkoutSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self fetchCustomWorkouts];
    
    
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}


/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the height of the TableView.
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95;
}

//Returns the number of sections of a TableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Returns the number of rows in the section of a TableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [customWorkouts count];
}

//Configures the cells at a specific indexPath.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //Define the identifier.
    static NSString *muscleSelectionCellIdentifier = @"workoutCell";
    
    //Create reference to the cell.
    WorkoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleSelectionCellIdentifier];
    [CommonSetUpOperations tableViewSelectionColorSet:cell];
    
    SHCustomWorkout *workout = [self updateWorkoutWithUserData:[customWorkouts objectAtIndex:indexPath.row]];
    
    cell.workoutName.text = workout.workoutName;
    cell.workoutDifficulty.text = workout.workoutDifficulty;
    cell.workoutType.text = workout.workoutType;
    cell.workoutExercises.text = [NSString stringWithFormat:@"%ld",[CommonUtilities numExercisesInCustomWorkout:workout]];
    
    cell.workoutDifficulty.textColor = [CommonSetUpOperations determineDifficultyColor:workout.workoutDifficulty];
    
    NSMutableArray *workoutExercises = [CommonUtilities getCustomWorkoutExercises:workout];
    
    if (workoutExercises.count > 0) {
        SHExercise *imageExercise = [workoutExercises objectAtIndex:[CommonUtilities numExercisesInCustomWorkout:workout]-1];
        
        [CommonSetUpOperations loadImageOnBackgroundThread:cell.workoutImage image:[UIImage imageNamed:imageExercise.exerciseImageFile]];
    }
  
    
    if ([workout.liked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        cell.likeWorkoutImage.hidden = NO;
        [cell.likeWorkoutImage setImage:[UIImage imageNamed:@"likeSelectedColored.png"]];
        cell.likeWorkoutImage.tintColor = BLUE_COLOR;
    }
    else {
        cell.likeWorkoutImage.hidden = YES;
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    //Set the selected cell background.
    [CommonSetUpOperations tableViewSelectionColorSet:cell];
    
    //Return the cell.
    return cell;

}

//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

//What happens when the user selects a cell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SHDataHandler *handler = [SHDataHandler getInstance];
    SHCustomWorkout *customWorkout = [customWorkouts objectAtIndex:indexPath.row];
    [handler addExerciseToCustomWorkout:customWorkout exercise:self.exerciseToAdd];
    [self dismissViewControllerAnimated:YES completion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)fetchCustomWorkouts {
    //Perform task on the background thread.
    dispatch_async(dispatch_get_main_queue(), ^{
        SHDataHandler *dataHandler = [SHDataHandler getInstance];
        
        customWorkouts = [dataHandler fetchAllCustomWorkouts];
        
        //Reload the recenltyviewed tableview to display the new exercises.
        [self.customWorkoutsTableView reloadData];
        
        if (customWorkouts.count == 0) {
            [CommonSetUpOperations performTSMessage:@"Looks like you have no workouts you can add this exercise to. If you'd like to create a workout head over to Workouts and press the add button in the top right!" message:nil viewController:self canBeDismissedByUser:YES duration:10];
        }
    });
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

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}
@end
