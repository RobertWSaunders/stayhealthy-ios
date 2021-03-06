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
    
    
    SHCustomWorkout *workout = [self updateWorkoutWithUserData:[customWorkouts objectAtIndex:indexPath.row]];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    //Set the selected cell background.
    
    
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
  //  [handler addExerciseToCustomWorkout:customWorkout exercise:self.exerciseToAdd];
    [self dismissViewControllerAnimated:YES completion:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)fetchCustomWorkouts {
    //Perform task on the background thread.
    dispatch_async(dispatch_get_main_queue(), ^{
        SHDataHandler *dataHandler = [SHDataHandler getInstance];
        
        //customWorkouts = [dataHandler fetchAllCustomWorkouts];
        
        //Reload the recenltyviewed tableview to display the new exercises.
        [self.customWorkoutsTableView reloadData];
        
           });
}

- (id)updateWorkoutWithUserData:(SHCustomWorkout*)workout {
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    //CustomWorkout *dataWorkout = [dataHandler fetchCustomWorkoutByIdentifier:workout.workoutID];
    /*
    if (dataWorkout != nil) {
        workout.lastViewed = dataWorkout.lastViewed;
        workout.liked = dataWorkout.liked;
    }*/
    
    return workout;
}

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}
@end
