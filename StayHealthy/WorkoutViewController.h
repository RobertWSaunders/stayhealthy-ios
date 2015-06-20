//
//  WorkoutViewController.h
//  StayHealthy
//
//  Created by Student on 4/6/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"
#import <sqlite3.h>
#import "sqlColumns.h"

#import "ExerciseDetailViewController.h"
#import "SIAlertView.h"
#import "CommonDataOperations.h"
#import "dailyActivity.h"

@interface WorkoutViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MZTimerLabelDelegate> {
    NSMutableArray *workoutExercisesArray;
    sqlite3 * db;
    NSArray *dailyActivityForToday;
    }
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

- (IBAction)reset:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *exerciseTableView;
- (IBAction)stopStart:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet MZTimerLabel *timerLabel;
@property (weak, nonatomic) IBOutlet NSString *titleText;
@property (weak, nonatomic) IBOutlet NSString *query;
@property (weak, nonatomic) NSString *workoutID;

@property (weak, nonatomic) IBOutlet UIButton *stopStartButton;
- (IBAction)finishWorkout:(id)sender;

@end
