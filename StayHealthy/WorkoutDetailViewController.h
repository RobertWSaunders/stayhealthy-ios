//
//  WorkoutDetailViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-25.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutViewController.h"
#import "ExerciseDetailViewController.h"
#import "ExerciseTableViewCell.h"

@interface WorkoutDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *workoutExercises;
    NSArray *workoutAnalysis;
    NSArray *workoutAnalysisContent;
}


@property (weak, nonatomic) IBOutlet UIBarButtonItem *likeButton;
@property (strong, nonatomic) SHWorkout *workoutToDisplay;

- (IBAction)summaryButtonPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

@property (weak, nonatomic) IBOutlet UIButton *startWorkoutButton;
- (IBAction)startWorkoutButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *workoutAnalysisView;
@property (weak, nonatomic) IBOutlet UIView *exerciseListView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *workoutAnalysisTableView;
@property (weak, nonatomic) IBOutlet UITableView *exerciseListTableView;
- (IBAction)segmentValueChanged:(id)sender;

@end
