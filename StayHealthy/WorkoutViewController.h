//
//  WorkoutViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-25.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MZTimerLabel.h"
#import "ExerciseDetailViewController.h"
#import "ExerciseTableViewCell.h"

@interface WorkoutViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (strong, nonatomic) SHWorkout *workoutShown;
@property (strong, nonatomic) NSString *viewTitle;
@property (strong, nonatomic) NSArray *workoutExercises;
@property (weak, nonatomic) IBOutlet MZTimerLabel *timerLabel;
@property (weak, nonatomic) IBOutlet UITableView *exercisesTableView;
- (IBAction)resetTimerPressed:(id)sender;
- (IBAction)timeControlPressed:(id)sender;
- (IBAction)finishWorkoutPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *stopStartButton;

@end
