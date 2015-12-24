//
//  WorkoutsAdvancedSearchViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-25.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "advancedOptionsSelect.h"
#import "TextFieldTableViewCell.h"
#import "WorkoutListViewController.h"

@interface WorkoutsAdvancedSearchViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, AdvancedOptionsDelegate> {
    
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
    
    //The final search query.
    NSString *searchQuery;
    
}

//The TableView that has the specificationd for the exercise to search.
@property (weak, nonatomic) IBOutlet UITableView *workoutSpecificationTableView;
//Our search button at the bottom of the page.
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

//Actions
//What happens when the user presses on the search button.
- (IBAction)searchButtonPressed:(id)sender;
//What happens when the user presses the 'X' in the top left corner of the page.
- (IBAction)dismissButtonPressed:(id)sender;


@end
