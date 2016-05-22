//
//  ExerciseAdvancedSearchViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-07-05.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
//Import the advanced options selection view controller.
//#import "advancedOptionsSelect.h"
//Import our custom TableView cell with the text field for the exercise name search.
#import "TextFieldTableViewCell.h"
#import "ExerciseListController.h"

//Incorporate the Advanced options delegate and the TableView delegate and data source, UITextField delegate for the custom cell used to search exercise name.
@interface ExerciseAdvancedSearchViewController : UIViewController <UITableViewDataSource,UITableViewDelegate, UITextFieldDelegate> {
    
    //Array filled with the advanced search options.
    NSArray *exerciseAdvancedSearchOptions;
    //Array filled with the TableViews sections headers.
    NSArray *tableViewSectionHeaders;
    //Array filled with the advanced search selections by the user, defaults are 'Any'.
    NSMutableArray *exerciseAdvancedSearchOptionsSelections;
    //Array filled with the advanced search selections by the user, defaults are 'Any', specifc array used to add the space between comma.
    NSMutableArray *tableViewAttributeSelectionsUserInterface;
    
    //Array filled with all the primary muscles.
    NSMutableArray *primaryMuscles;
    //Array filled with all the secondary muscles.
    NSMutableArray *secondaryMuscles;
    //Array filled with all the different equipment.
    NSMutableArray *equipmentList;
    //Array filled with all the different difficulties.
    NSMutableArray *difficultyList;
    //Array filled with all the different force types.
    NSMutableArray *forceTypeList;
    //Array filled with all the different mechanic types.
    NSMutableArray *mechanicsTypeList;

    //Arrays for the advanced search.
    //Array filled with the exercises types the user selected.
    NSArray *selectedPrimaryMuscles;
    NSArray *selectedSecondaryMuscles;
    NSArray *selectedEquipment;
    NSArray *selectedDifficulty;
    NSArray *selectedForceType;
    NSArray *selectedMechanicsType;
    //The selected exercise types.
    NSMutableArray *selectedExerciseTypes;
    //The selected exercise name.
    NSString *selectedName;
    
    //The final search query.
    NSString *searchQuery;
}

//IBOutlets
//The segmented control that toggles between StayHealthy Exercises and user created exercises.
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
//The TableView that has the specificationd for the exercise to search.
@property (weak, nonatomic) IBOutlet UITableView *exerciseSpecificationTableView;
//Our search button at the bottom of the page.
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (nonatomic, assign) BOOL exerciseSelectionMode;
@property(strong, retain) NSMutableArray *selectedExercises;

//Actions
//What happens when the user presses on the search button.
- (IBAction)searchButtonPressed:(id)sender;
//What happens when the user presses the 'X' in the top left corner of the page.
- (IBAction)dismissButtonPressed:(id)sender;

@property (assign, nonatomic) id <AdvancedSearchExerciseSelectionDelegate> delegate;

@end

