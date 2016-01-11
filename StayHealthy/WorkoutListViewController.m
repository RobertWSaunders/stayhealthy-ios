//
//  WorkoutListViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-25.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import "WorkoutListViewController.h"

@interface WorkoutListViewController ()

@end

@implementation WorkoutListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    //Set the title for the page to the muscle.
    self.title = self.viewTitle;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //Get the exercise data.
    if (self.workoutDataSent == nil) {
         workoutData = [[SHDataHandler getInstance] performWorkoutStatement:self.workoutQuery];
    }
    else {
        workoutData = self.workoutDataSent;
    }
   
    
    //If the exercise data is nothing then show the message declaring that.
    if (workoutData.count == 0)
        [CommonSetUpOperations performTSMessage:@"No Workouts Were Found" message:nil viewController:self canBeDismissedByUser:YES duration:60];
    
    [self setNotificationObservers];
    
    [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_WORKOUTS_SEARCHED viewController:self message:@"I found these workouts for you! Here you can just choose a workout you like the look of and I'll show you more about it and you can perform it!"];
    
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

/***************************************************/
#pragma mark UITableView Delegate/Datasource Methods
/***************************************************/

//Returns the height of the cells inside the tableView.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 95.0f;
}

//Sets the number of rows in the tableview.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Equal to the number of exercises for this search.
    return [workoutData count];
}

//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


//determine everything for each cell, at each indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //write the cell identifier.
    static NSString *simpleTableIdentifier = @"workoutTableCell";
    
    //Create the reference for the cell.
    WorkoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    //If the cell can't be found then just create one.
    if (cell == nil) {
        cell = [[WorkoutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    SHWorkout *workout = [self updateWorkoutWithUserData:[workoutData objectAtIndex:indexPath.row]];
    
    cell.workoutName.text = workout.workoutName;
    cell.workoutDifficulty.text = workout.workoutDifficulty;
    cell.workoutType.text = workout.workoutType;
    cell.workoutExercises.text = [NSString stringWithFormat:@"%ld",[CommonUtilities numExercisesInWorkout:workout]];
    
    cell.workoutDifficulty.textColor = [CommonSetUpOperations determineDifficultyColor:workout.workoutDifficulty];
   
    NSMutableArray *workoutExercises = [CommonUtilities getWorkoutExercises:workout];
    
    SHExercise *imageExercise = [workoutExercises objectAtIndex:[CommonUtilities numExercisesInWorkout:workout]-1];
    
    [CommonSetUpOperations loadImageOnBackgroundThread:cell.workoutImage image:[UIImage imageNamed:imageExercise.exerciseImageFile]];
    
    if ([workout.liked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        cell.likeWorkoutImage.hidden = NO;
        [cell.likeWorkoutImage setImage:[UIImage imageNamed:@"likeSelectedColored.png"]];
        cell.likeWorkoutImage.tintColor = BLUE_COLOR;
    }
    else {
        cell.likeWorkoutImage.hidden = YES;
    }
    
    
    //Set the selected cell background.
    [CommonSetUpOperations tableViewSelectionColorSet:cell];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    selectedIndex = indexPath;
    [self performSegueWithIdentifier:@"detail" sender:self];
    //deselect the cell when you select it, makes selected background view disappear.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*****************************/
#pragma mark Prepare For Segue
/*****************************/

//What happens just before a segue is performed.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"detail"]) {

        SHWorkout *workout = [workoutData objectAtIndex:selectedIndex.row];
        WorkoutDetailViewController *detailView = [[WorkoutDetailViewController alloc] init];
        detailView = segue.destinationViewController;
        detailView.workoutToDisplay = workout;
    }
}

- (void)updateTableView {
    //workoutData = [[SHDataHandler getInstance] performWorkoutStatement:self.workoutQuery];
    [self.listTableView reloadData];
}

- (SHWorkout *)updateWorkoutWithUserData:(SHWorkout*)workout {
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    Workout *dataWorkout = [dataHandler fetchWorkoutByIdentifier:workout.workoutIdentifier];
    
    if (dataWorkout != nil) {
        workout.lastViewed = dataWorkout.lastViewed;
        workout.liked = dataWorkout.liked;
    }
    
    return workout;
}


/*************************************/
#pragma mark ViewWillDisappear Methods
/*************************************/

//Dismiss all TSMessages when the view disappears.
-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}

//Sets the observers for the notifications that need to be observed for.
- (void)setNotificationObservers {
    //Observe for changes. All just reload the recently
    //iCloud update notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:CLOUD_UPDATE_NOTIFICATION object:nil];
    //Changes in a exercise record, i.e. changes in lastViewed.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:CUSTOM_WORKOUT_DELETE_NOTIFICATION object:nil];
    //Changes in a exercise favorite.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:CUSTOM_WORKOUT_SAVE_NOTIFICATION object:nil];
    //Changes in a exercise favorite.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:CUSTOM_WORKOUT_UPDATE_NOTIFICATION object:nil];
    //Changes in a exercise record, i.e. changes in lastViewed.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:WORKOUT_SAVE_NOTIFICATION object:nil];
    //Changes in a exercise favorite.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:WORKOUT_UPDATE_NOTIFICATION object:nil];
}



@end
