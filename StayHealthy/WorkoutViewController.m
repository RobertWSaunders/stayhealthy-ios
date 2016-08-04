//
//  WorkoutViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-25.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import "WorkoutViewController.h"

@interface WorkoutViewController ()

@end

@implementation WorkoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.timerLabel start];
    self.timerLabel.timeFormat = @"mm:ss";
    self.title = self.viewTitle;
    
    self.navigationItem.hidesBackButton = YES;
    
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;

   // [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_WORKOUTS_PERFORM  viewController:self message:@"Here you can work through all of the exercises at your own pace and finish the workout when you would like. To finish the workout just tap the button at the bottom of your screen."];
    
    [self setNotificationObservers];
}


/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the height of the cells inside the tableView.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

        return 76.0f;
    
    
}

//Returns the number of rows that should be displayed in the tableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return [self.workoutExercises count];

}

//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Configures the cells at a specific indexPath.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        //Define the identifier.
        static NSString *exerciseListCellIdentifier = @"exerciseTableCell";
        
        //Create reference to the cell.
        ExerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:exerciseListCellIdentifier];
        
    SHExercise *exercise =nil;// [self updateExerciseWithUserData:[self.workoutExercises objectAtIndex:indexPath.row]];
        
        cell.exerciseName.text = exercise.exerciseName;
        cell.difficulty.text = exercise.exerciseDifficulty;
  /*      cell.difficulty.textColor = [CommonSetUpOperations determineDifficultyColor:exercise.exerciseDifficulty];
        
        cell.equipment.text = exercise.exerciseEquipment;
        NSString *trimmedString = [exercise.exerciseEquipment stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        
        if ([trimmedString isEqualToString:@"null"])
            cell.equipment.text = @"No Equipment";
        else
            cell.equipment.text = exercise.exerciseEquipment;
        
        //Load the exercise image on the background thread.
        [CommonSetUpOperations loadImageOnBackgroundThread:cell.exerciseImage image:[UIImage imageNamed:exercise.exerciseImageFile]];
    */
    /*
        if ([exercise.liked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            cell.likeExerciseImage.hidden = NO;
            [cell.likeExerciseImage setImage:[UIImage imageNamed:@"likeSelectedColored.png"]];
            cell.likeExerciseImage.tintColor = EXERCISES_COLOR;
        }
        else {
            cell.likeExerciseImage.hidden = YES;
        }
        */
        
        //Set the selected cell background.
        
        
        //Return the cell.
        return cell;

}


//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

//What happens when the user selects a cell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"exerciseDetail" sender:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*
- (SHExercise *)updateExerciseWithUserData:(SHExercise*)exercise {
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    Exercise *dataExercise = [dataHandler fetchExerciseByIdentifier:exercise.exerciseIdentifier];
    
    if (dataExercise != nil) {
        exercise.lastViewed = dataExercise.lastViewed;
        exercise.liked = dataExercise.liked;
    }
    
    return exercise;
}*/

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
if ([segue.identifier isEqualToString:@"exerciseDetail"]) {
        NSIndexPath *indexPath = [self.exercisesTableView indexPathForSelectedRow];
        SHExercise *exercise = [self.workoutExercises objectAtIndex:indexPath.row];
        ExerciseDetailViewController *destViewController = segue.destinationViewController;
        destViewController.exerciseToDisplay = exercise;
        destViewController.viewTitle = exercise.exerciseName;
        destViewController.modalView = NO;
        destViewController.showActionIcon = YES;
    }
}


- (IBAction)resetTimerPressed:(id)sender {
    [self.timerLabel reset];
}

- (IBAction)timeControlPressed:(UIButton*)sender {
    if (sender.tag == 0) {
        [self.timerLabel pause];
        [_stopStartButton setTitle:@"Start" forState:UIControlStateNormal];
        _stopStartButton.tag = 1;
    }
    else if (sender.tag == 1) {
        [self.timerLabel start];
        [_stopStartButton setTitle:@"Pause" forState:UIControlStateNormal];
        _stopStartButton.tag = 0;
    }
}

- (IBAction)finishWorkoutPressed:(id)sender {
    [self.timerLabel pause];
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"title" andMessage:nil];
    [alertView addButtonWithTitle:@"Done"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              
                              SHDataHandler *dataHandler = [SHDataHandler getInstance];
                              /*
                              //Save or Update the exercise information.
                              if (self.customWorkoutMode) {
                                  if ([dataHandler customWorkoutHasBeenSaved:self.customWorkoutToDisplay.workoutID]) {
                                      
                                      if ([self.customWorkoutToDisplay.timesCompleted isEqualToNumber:[NSNumber numberWithInteger:0]]) {
                                          self.customWorkoutToDisplay.timesCompleted = [NSNumber numberWithInteger:1];
                                      }else {
                                          NSNumber *number;
                                          if (self.customWorkoutToDisplay.timesCompleted == nil) {
                                              number = [NSNumber numberWithInteger:0];
                                          }
                                          else {
                                              number = self.customWorkoutToDisplay.timesCompleted;
                                          }
                                          int value = [number intValue];
                                          self.customWorkoutToDisplay.timesCompleted = [NSNumber numberWithInteger:value + 1];
                                      }
                                      
                                      self.customWorkoutToDisplay.lastDateCompleted = [NSDate date];
                                      
                                      [dataHandler updateCustomWorkoutRecord:self.customWorkoutToDisplay];
                                  }
                                   [self.navigationController popViewControllerAnimated:YES];
                              }
                              else {
                                  if ([dataHandler workoutHasBeenSaved:self.workoutShown.workoutIdentifier]) {
                                      
                                      if ([self.workoutShown.timesCompleted isEqualToNumber:[NSNumber numberWithInteger:0]]) {
                                          self.workoutShown.timesCompleted = [NSNumber numberWithInteger:1];
                                      }else {
                                          NSNumber *number;
                                          if (self.workoutShown.timesCompleted == nil) {
                                              number = [NSNumber numberWithInteger:0];
                                          }
                                          else {
                                              number = self.workoutShown.timesCompleted;
                                          }
                                          int value = [number intValue];
                                          self.workoutShown.timesCompleted = [NSNumber numberWithInteger:value + 1];
                                      }
                                      
                                      [dataHandler updateWorkoutRecord:self.workoutShown];
                                  }
                                   [self.navigationController popViewControllerAnimated:YES];
                              }
    */
                
                          }];
    [alertView addButtonWithTitle:@"Done and don't record."
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              [self.navigationController popViewControllerAnimated:YES];
                          }];
    [alertView addButtonWithTitle:@"Cancel"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              [self.timerLabel start];
                          }];
    [alertView show];
    alertView.title = @"Are you sure?";

}

- (void)updateTableView {
    [self.exercisesTableView reloadData];
}

//If the user leaves the page then dismiss the all TSMessages.
-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}

//Sets the observers for the notifications that need to be observed for.
- (void)setNotificationObservers {
    //Observe for changes. All just reload the recently
    //iCloud update notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:CLOUD_UPDATE_NOTIFICATION object:nil];
    //Changes in a exercise record, i.e. changes in lastViewed.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:EXERCISE_UPDATE_NOTIFICATION object:nil];
    //Changes in a exercise favorite.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:EXERCISE_SAVE_NOTIFICATION object:nil];
}



@end
