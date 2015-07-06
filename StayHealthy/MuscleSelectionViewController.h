//
//  MuscleSelectionViewController.h
//  StayHealthy
//
//  Created by Student on 12/7/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImprovedExerciseController.h"
#import "ExerciseAdvancedSearchViewController.h"

//Include the UITableView delegat and datasource methods because we are using a UITableView.
@interface MuscleSelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate> {
    //Array filled with all the front body muscles.
    NSArray *frontBodyMuscles;
    //Array filled with all the front body muscle scientific names.
    NSArray *frontBodyMusclesScientificNames;
    //Array filled with all the back body muscles.
    NSArray *backBodyMuscles;
    //Array filled with all the back body muscle scientific names.
    NSArray *backBodyMusclesScientificNames;
}

//View for the muscle lists.
@property (weak, nonatomic) IBOutlet UIView *muscleListView;
//View for the recently viewed exercises.
@property (weak, nonatomic) IBOutlet UIView *recentlyViewedExercisesView;

//TableView for the muscle list.
@property (weak, nonatomic) IBOutlet UITableView *selectMuscleTableView;
//TableView for the recently viewed list.
@property (weak, nonatomic) IBOutlet UITableView *recentlyViewedTableView;

//Segmented control to toggle between the views.
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

//Search navigation button.
@property (weak, nonatomic) IBOutlet UIBarButtonItem *search;
//Add exercise button.
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addExercise;
//Add exercise button.
@property (weak, nonatomic) IBOutlet UIBarButtonItem *warmup;

//Action that gets fired when the user changes the segmented control.
- (IBAction)segmentValueChanged:(id)sender;


@end
