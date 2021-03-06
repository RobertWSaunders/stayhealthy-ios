//
//  WorkoutSelectionViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-22.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutTableViewCell.h"
#import "WorkoutsAdvancedSearchViewController.h"
#import "WorkoutCreateViewController.h"
#import "WorkoutBrowseOptionsViewController.h"
#import "WorkoutDetailViewController.h"

@interface WorkoutSelectionViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource> {
    NSArray *browseOptions;
    NSArray *browseOptionsImages;
    NSMutableArray *customWorkouts;
    NSIndexPath *selectedIndexPath;
    NSIndexPath *browseIndexPath;
    
}

@property (weak, nonatomic) IBOutlet UITableView *yourWorkoutsTableView;

@property (weak, nonatomic) IBOutlet UIView *yourWorkoutsView;
@property (weak, nonatomic) IBOutlet UITableView *browseOptionsTableView;

@property (weak, nonatomic) IBOutlet UIView *browseWorkoutsView;
@property (weak, nonatomic) IBOutlet UIScrollView *browseScroller;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)segmentValueChanged:(id)sender;
- (IBAction)addCustomWorkout:(id)sender;
- (IBAction)workoutSearch:(id)sender;

@end
