//
//  MuscleSelectionViewController.h
//  StayHealthy
//
//  Created by Student on 12/7/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImprovedExerciseController.h"
#import "advancedOptionsSelect.h"

@interface MuscleSelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, AdvancedOptionsDelegate> {
    
    IBOutlet UITableView *selectMuscleTableView;
    //^^^^^^^This is the tableview for the muscle selection page.
    IBOutlet UITableView *advancedSearchTableView;
    
    NSArray *titleText;
    //^^^^^^^The titleText for the parent view controller.
    NSArray *queries;
    //^^^^^^^The queries I pass to the view controller.
    
    //My Arrays for the tableview. Muscle names and scientific names.
    NSArray *musclesForTableview;
    NSArray *scientificMuscleNames;
    NSArray *musclesForTableview2;
    NSArray *scientificMuscleNames2;
    
    NSArray *advancedOptions;
    NSArray *advancedOptionsSelections;
    
    //Advanced Search Setup/Utilities
    //These are the arrays that hold the drop-down items in the advanced search pop-ups.
    NSArray *primaryMuscleList;
    //^^^^^^^Primary Muscle Lists
    NSArray *secondaryMuscleList;
    //^^^^^^^Secondary Muscle Lists
    NSArray *equipmentList;
    //^^^^^^^Equipment List
    NSArray *difficultyList;
    //^^^^^^^Difficulty List
    
    NSMutableArray *selectedTypes;
    NSMutableArray *selectedColumns;
    NSMutableArray *selectedValues;
    
    //These are the strings for the advanced search.
    NSString *primaryText;
    NSString *secondaryText;
    NSString *difficultyText;
    NSString *equipmentText;
    NSString *searchQuery;
    NSString *searchName;
    
    //Our SIAlertview strings.
    NSString *strength;
    NSString *stretching;
    NSString *cancel;
    NSString *title;
    

}

//The segement 
- (IBAction)segmentValueChanged:(id)sender;

//My views
@property (weak, nonatomic) IBOutlet UIView *advancedSearch;
@property (strong, nonatomic) IBOutlet UIView *muscleList;


//Segmented Control for view navigation
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

//My warmup uibarbutton.
@property (weak, nonatomic) IBOutlet UIBarButtonItem *warmup;
- (IBAction)warmup:(id)sender;
//^^^^^^^^^^And its action handler.

- (IBAction)searchButton:(id)sender;

//Property of the search button for styling.
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

//The mutable array.
-(NSMutableArray *) selectedTypes;

@end
