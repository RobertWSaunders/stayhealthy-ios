//
//  MuscleSelectionViewController.h
//  StayHealthy
//
//  Created by Student on 12/7/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
//

/***************************************************HEADER FILE***************************************/
//Make sure to always have all imports in here.

#import <UIKit/UIKit.h>
//^^^^^^^^^^^^Standard UIKit.

//^^^^^^^^^^^^Our FlatUI colors.
//^^^^^^^^^^^^DropDown List view for the advanced search.
#import "TSMessage.h"

//^^^^^^^^^^^^SWRevealViewController for the sidemenu.
#import "ImprovedExerciseController.h"
//^^^^^^^^^^^^For the exercise data representation tableview/collectionview.
#import "SIAlertView.h"
//^^^^^^^^^^^^For the popup messages for choosing strength or stretching.
#import "advancedOptionsSelect.h"




@interface MuscleSelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, AdvancedOptionsDelegate> {
    
    
    IBOutlet UITableView *selectMuscleTableView;
    //^^^^^^^This is the tableview for the muscle selection page.
    IBOutlet UITableView *advancedSearchTableView;
    
    NSArray *titleText;
    //^^^^^^^The titleText for the parent view controller.
    NSArray *queries;
    //^^^^^^^The queries I pass to the view controller.
    
    __weak IBOutlet UISearchBar *searchBar;
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
    
    
    IBOutlet UIScrollView *scroller;
}

//The segement 
- (IBAction)segmentValueChanged:(id)sender;

//My views
@property (weak, nonatomic) IBOutlet UIView *advancedSearch;
@property (weak, nonatomic) IBOutlet UIView *bodyView;
@property (strong, nonatomic) IBOutlet UIView *muscleList;

//These are the views for the body view, front and back.
@property (weak, nonatomic) IBOutlet UIView *frontBodyView;
@property (weak, nonatomic) IBOutlet UIView *backBodyView;

//Segmented Control for view navigation
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

//Sidebar button to toggle the sidebar.
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

//My warmup uibarbutton.
@property (weak, nonatomic) IBOutlet UIBarButtonItem *warmup;
- (IBAction)warmup:(id)sender;
//^^^^^^^^^^And its action handler.


//Body view utilites/buttons
- (IBAction)switchViews:(id)sender;

//Muscle buttons in body view.
- (IBAction)abdominalButton:(id)sender;
- (IBAction)biceps:(id)sender;
- (IBAction)pectoralisButton:(id)sender;
- (IBAction)forearms:(id)sender;
- (IBAction)groin:(id)sender;
- (IBAction)oblique:(id)sender;
- (IBAction)traps:(id)sender;
- (IBAction)quadriceps:(id)sender;
- (IBAction)shoulder:(id)sender;
- (IBAction)tricep:(id)sender;
- (IBAction)wrist:(id)sender;
- (IBAction)calf:(id)sender;
- (IBAction)glutes:(id)sender;
- (IBAction)hamstring:(id)sender;
- (IBAction)lats:(id)sender;
- (IBAction)lowerback:(id)sender;


//Advanced Search Setup
//My Advanced search buttons to toggle drop down lists.
- (IBAction)PrimaryMuscle:(id)sender;
- (IBAction)SecondaryMuscle:(id)sender;
- (IBAction)Difficulty:(id)sender;
- (IBAction)Equipment:(id)sender;
- (IBAction)searchButton:(id)sender;

//Property of the search button for styling.
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

//The labels for selections.
@property (strong, nonatomic) IBOutlet UILabel *primaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *secondaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *difficultLabel;
@property (strong, nonatomic) IBOutlet UILabel *equipmentLabel;

//Textfield to search for a name.
@property (weak, nonatomic) IBOutlet UITextField *nameSearch;

//The switches that toggle the exercise type.
@property (weak, nonatomic) IBOutlet UISwitch *warmUpCheck;
@property (weak, nonatomic) IBOutlet UISwitch *stretchingCheck;
@property (weak, nonatomic) IBOutlet UISwitch *strengthCheck;

//Boolean for advanced search.
@property (nonatomic) BOOL exerciseTypePressed;
@property (nonatomic) BOOL primaryPressed;
@property (nonatomic) BOOL secondaryPressed;
@property (nonatomic) BOOL equipmentPressed;
@property (nonatomic) BOOL difficultyPressed;

//The mutable array.
-(NSMutableArray *) selectedTypes;

@end
