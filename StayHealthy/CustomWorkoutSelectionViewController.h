//
//  CustomWorkoutSelectionViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-12-26.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutTableViewCell.h"

@interface CustomWorkoutSelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *customWorkouts;
}
@property (weak, nonatomic) IBOutlet UITableView *customWorkoutsTableView;
- (IBAction)closeButtonPressed:(id)sender;
@property (strong, nonatomic) SHExercise *exerciseToAdd;

@end
