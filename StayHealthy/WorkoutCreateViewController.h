//
//  WorkoutCreateViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-25.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextFieldTableViewCell.h"
#import "ExerciseTableViewCell.h"

@interface WorkoutCreateViewController : UIViewController <UITableViewDataSource, UITableViewDataSource, UITextFieldDelegate> {
    //Array filled with the advanced search options.
    NSArray *workoutAdvancedSearchOptions;
    //Array filled with the TableViews sections headers.
    NSArray *tableViewSectionHeaders;
    //Array filled with the advanced search selections by the user, defaults are 'Any'.
    NSMutableArray *workoutAdvancedSearchOptionsSelections;
    //Array filled with the advanced search selections by the user, defaults are 'Any', specifc array used to add the space between comma.
    NSMutableArray *tableViewAttributeSelectionsUserInterface;
    
    //Array filled with all the primary muscles.
    NSMutableArray *targetMuscles;
    //Array filled with all the different equipment.
    NSMutableArray *equipmentList;
    //Array filled with all the different difficulties.
    NSMutableArray *difficultyList;
    //Array filled with all the different difficulties.
    NSMutableArray *sportsList;
    
    //Array that holds the workout exercises that have been selected
    NSMutableArray *workoutExercises;
    
    //Arrays for the advanced search.
    //Array filled with the exercises types the user selected.
    NSArray *selectedTargetMuscles;
    NSArray *selectedEquipment;
    NSArray *selectedDifficulty;
    NSArray *selectedSports;
    //The selected workout types.
    NSArray *selectedWorkoutTypes;
    
    //The selected workout name.
    NSString *selectedName;
}

@property (weak, nonatomic) IBOutlet UITableView *createWorkoutTableView;

- (IBAction)doneButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed:(id)sender;

@end
