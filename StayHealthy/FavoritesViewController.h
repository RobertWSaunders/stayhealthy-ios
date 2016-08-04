//
//  FavoritesViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-10-17.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseDetailViewController.h"
#import "ExerciseTableViewCell.h"
#import "WorkoutTableViewCell.h"
#import "WorkoutDetailViewController.h"
#import "CustomWorkoutSelectionViewController.h"

@interface FavoritesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSIndexPath *selectedIndex;
    NSMutableArray *favoritesData;
    BOOL workoutData;
    
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)segmentValueChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *favoritesTableView;

@property (nonatomic, assign) BOOL exerciseSelectionMode;

//Array that holds the information regarding which exercises the user selected.
@property(strong, retain) NSMutableArray *selectedExercises;

@property (assign, nonatomic) id <LikedExercisesExerciseSelectionDelegate> delegate;

@end

