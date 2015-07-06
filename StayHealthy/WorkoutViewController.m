//
//  WorkoutViewController.m
//  StayHealthy
//
//  Created by Student on 4/6/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import "WorkoutViewController.h"

@interface WorkoutViewController ()

@end

@implementation WorkoutViewController

@synthesize timerLabel, query;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"WorkoutsFirstLaunch6"])
    {
        [TSMessage showNotificationInViewController:self
                                              title:@"Ok awesome you have reached your first workout! Now work your way through all the exercises and finish when your done. You can also keep track of your workout time with the timer at the top. Tap this message to dismiss."
                                           subtitle:nil
                                              image:nil
                                               type:TSMessageNotificationTypeMessage
                                           duration:TSMessageNotificationDurationEndless
                                           callback:nil
                                        buttonTitle:nil
                                     buttonCallback:nil
                                         atPosition:TSMessageNotificationPositionBottom
                                canBeDismisedByUser:YES];

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"WorkoutsFirstLaunch6"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    self.navigationItem.hidesBackButton = YES;
    
    [[SIAlertView appearance] setTitleFont:[UIFont fontWithName:@"Avenir-Light" size:20]];
    [[SIAlertView appearance] setTitleColor:STAYHEALTHY_BLUE];
    [[SIAlertView appearance] setMessageColor:STAYHEALTHY_BLUE];
    [[SIAlertView appearance] setCornerRadius:4];
    [[SIAlertView appearance] setShadowRadius:0];
    [[SIAlertView appearance] setViewBackgroundColor:STAYHEALTHY_WHITE];
    [[SIAlertView appearance] setButtonColor:STAYHEALTHY_BLUE];
    [[SIAlertView appearance] setDestructiveButtonColor:STAYHEALTHY_BLUE];
    [[SIAlertView appearance] setCancelButtonColor:STAYHEALTHY_BLUE];
    [[SIAlertView appearance] setButtonFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [[SIAlertView appearance] setMessageFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
    [[SIAlertView appearance] setMessageColor:[UIColor lightGrayColor]];
	
    [timerLabel start];
    timerLabel.timeFormat = @"mm:ss";
    self.title = self.titleText;
    
   // workoutExercisesArray = [CommonDataOperations returnExerciseData:query databaseName:STAYHEALTHY_DATABASE database:db];
    
    [_resetButton setTintColor:STAYHEALTHY_BLUE];
    
    UIImage * __weak image = [_resetButton.currentBackgroundImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    [_resetButton setBackgroundImage:image forState:UIControlStateNormal];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [workoutExercisesArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ourExerciseCells";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    /*
    sqlColumns *exercise = [workoutExercisesArray objectAtIndex:indexPath.row];
    
    UILabel *exerciseName = (UILabel *)[cell viewWithTag:101];
    exerciseName.text = exercise.Name;
    
    UILabel *equipment = (UILabel *)[cell viewWithTag:102];
    equipment.text = exercise.Equipment;
    NSString *string = exercise.Equipment;
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    if ([trimmedString isEqualToString:@"null"]) {
        equipment.text = @"No Equipment";
    }
    
    UILabel *difficulty = (UILabel *)[cell viewWithTag:103];
    difficulty.text = exercise.Difficulty;
    
    if ([difficulty.text isEqualToString:@"Easy"]) {
        difficulty.textColor = STAYHEALTHY_GREEN;
    }
    if ([difficulty.text isEqualToString:@"Intermediate"]) {
        difficulty.textColor = STAYHEALTHY_DARKERBLUE;
    }
    if ([difficulty.text isEqualToString:@"Hard"]) {
        difficulty.textColor = STAYHEALTHY_RED;
    }
    if ([difficulty.text isEqualToString:@"Very Hard"]) {
        difficulty.textColor = STAYHEALTHY_RED;
    }
    
    UIImageView *cellImageView = (UIImageView *)[cell viewWithTag:100];
    cellImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",exercise.File]];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = STAYHEALTHY_WHITE;
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];
    */
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//Now we parse the data from the database, and use our objects stored in sqlcolumns, these are our columns.


- (IBAction)stopStart:(UIButton *)sender{
    if (sender.tag == 0) {
        [timerLabel pause];
        [_stopStartButton setTitle:@"Start" forState:UIControlStateNormal];
        _stopStartButton.tag = 1;
    }
    else if (sender.tag == 1) {
        [timerLabel start];
        [_stopStartButton setTitle:@"Pause" forState:UIControlStateNormal];
        _stopStartButton.tag = 0;
    }
}
- (IBAction)reset:(id)sender {
    [timerLabel reset];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    /*
    if ([segue.identifier isEqualToString:@"exerciseDetail"]) {
         NSIndexPath *indexPath = [_exerciseTableView indexPathForSelectedRow];
        sqlColumns *exercise = [workoutExercisesArray objectAtIndex:indexPath.row];
        ExerciseDetailViewController *destViewController = segue.destinationViewController;
        destViewController.image = [UIImage imageNamed:exercise.File];
        destViewController.text = exercise.Description;
        destViewController.title1 = exercise.Name;
        destViewController.reps = exercise.Reps;
        destViewController.sets = exercise.Sets;
        destViewController.material = exercise.Equipment;
        destViewController.difficulty = exercise.Difficulty;
        destViewController.pri = exercise.PrimaryMuscle;
        destViewController.sec = exercise.SecondaryMuscle;
        destViewController.ident = exercise.ID;
        destViewController.favorite = exercise.isFavorite;
        destViewController.exerciseType = exercise.ExerciseType;
    }
     */
}

-(void)recordWorkoutData {
   
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss"];
    
   // dailyActivity *dailyActivityObject = [dailyActivityForToday objectAtIndex:0];
    
    
   // NSDate *currentWorkoutTime = [dateFormatter dateFromString:dailyActivityObject.workoutTime];
    NSDate *thisWorkoutTime = [dateFormatter dateFromString:timerLabel.text];
    
    // Extract date components into components1
    /*
    NSDateComponents *components1 = [calendar components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
                                                fromDate:currentWorkoutTime];
    */
    // Extract time components into components2
    NSDateComponents *components2 = [calendar components:NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
                                                fromDate:thisWorkoutTime];
    NSInteger currentMin;
    NSInteger currentSec;
    /*
    if ([dailyActivityObject.workoutTime isEqualToString:@"00:00"]) {
        currentMin = 0;
        currentSec = 0;
    }
    else {
        currentMin = [components1 minute];
        currentSec = [components1 second];
    }
*/
    NSInteger thisWorkoutMin = [components2 minute];
    NSInteger thisWorkoutSec = [components2 second];
    
    NSInteger finalMin =  thisWorkoutMin + currentMin;
    NSInteger finalSec = thisWorkoutSec + currentSec;
    
    // Combine date and time into components3
    NSDateComponents *components3 = [[NSDateComponents alloc] init];
    
    [components3 setMinute:finalMin];
    [components3 setSecond:finalSec];
    
    // Generate a new NSDate from components3.
    NSDate *combinedDate = [calendar dateFromComponents:components3];
    NSString *finalTime = [dateFormatter stringFromDate:combinedDate];
    
    
    //[CommonDataOperations performInsertQuery:[NSString stringWithFormat:@"UPDATE PrebuiltWorkoutData SET TimesCompleted = TimesCompleted + 1 WHERE WorkoutID = '%@'",self.workoutID] databaseName:USER_DATABASE database:db];

     }

- (IBAction)finishWorkout:(id)sender {
    [timerLabel pause];
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"title" andMessage:@"Before finishing please state what you would like to do:"];
    [alertView addButtonWithTitle:@"Done"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              [self recordWorkoutData];
                              [self.navigationController popToRootViewControllerAnimated:NO];
                          }];
    [alertView addButtonWithTitle:@"Done and don't record."
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              [self.navigationController popToRootViewControllerAnimated:NO];
                              //[self performSegueWithIdentifier:@"finish" sender:nil];
                          }];
    [alertView addButtonWithTitle:@"Cancel"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              [timerLabel start];
                          }];
    [alertView show];
    alertView.title = @"Are you sure?";
}

//If the user leaves the page then dismiss the all TSMessages.
-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}


@end
