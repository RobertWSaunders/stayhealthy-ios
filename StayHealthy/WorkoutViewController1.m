//
//  WorkoutViewController.m
//  StayHealthy
//
//  Created by Student on 4/6/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import "WorkoutViewController1.h"

@interface WorkoutViewController1 ()

@end

@implementation WorkoutViewController1

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

    [timerLabel start];
    timerLabel.timeFormat = @"mm:ss";
    self.title = self.titleText;
    

    
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

}


- (IBAction)finishWorkout:(id)sender {
    [timerLabel pause];
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"Before finishing please state what you would like to do:"];
    [alertView addButtonWithTitle:@"Done"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {

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
