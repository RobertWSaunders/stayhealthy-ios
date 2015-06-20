//
//  WorkoutSelectionViewController.h
//  StayHealthy
//
//  Created by Student on 1/9/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//

/***************************************************HEADER FILE***************************************/
/*************************************************REVISIT FOR VERSION 2.0.0************************************/
//Make sure to always have all imports in here.
//Link both delegates and datasources of the collectionview and tableview.
//Might need to create outlets to change CGRECT options.
/*NOTES: For the future, i.e. version 2.0.0, make it so you can update the content collection views remotly
 from the internet, and also make it so that the arrays are stowed in the database, so it allows for easier updating.
*/
#import <UIKit/UIKit.h>
//^^^^^^Standard UIKit
#import "workoutCell.h"
//^^^^^^The collectionview cell requirments/class
//^^^^^^Slide out menu.
#import "UIColor+FlatUI.h"
//^^^^^^Our colors.
#import "TSMessage.h"
//^^^^^^The alerts.
#import "workoutsDataObjects.h"
//^^^^^^^The workoutObjects in database.
#import <sqlite3.h>
//Mandatory database implementation.
#import "WorkoutDetailViewController.h"
//The next page for a workout, this is the page that actually outlines the workouts.
#import "sqlColumns.h"
//The objects to retreive the exercises in a workout.

//The view controller for the popup when you select.
#import "WorkoutsSearchedViewController.h"
//The workouts searched viewcontroller, shows the list of workouts that result of what you selected.
#import "CommonDataOperations.h"
#import "CommonSetUpOperations.h"
#import "workoutOptionsViewController.h"


//The @interface with delegate and datasources inheritance.
@interface WorkoutSelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate> {
    //inherite the popup delegate to perform the segue to the next viewcontroller.
    
    IBOutlet UITableView *categoriesTableView;
    //Our table views.

    
    __weak IBOutlet UILabel *popularLabel;
    __weak IBOutlet UILabel *favoriteLabel;
    IBOutlet UICollectionView *popularCollectionView;
    //The array that holds the workout data.
    NSMutableArray *workoutData;
    
    //The array that holds our hand selected favorites workouts.
    NSMutableArray *favoritesWorkoutData;
    NSMutableArray *popularWorkoutData;
    
    //The array that holds the workouts exercise images, this is for images.
    NSMutableArray *workoutImagesForCollection;
    NSMutableArray *workoutImagesForTableView;
    
    
    //The database declaration. The database.
    sqlite3 * db;
    
    //Our arrays that store data for the numerous contentviews.
    NSArray *categories;
    //The categories images, the little icons.
    NSArray *categoriesImage;
    
    //My array for the exerciseIDs, I need to fetch from the database.
    NSArray *exerciseIdentifiers;
    NSArray *exerciseType;
    NSArray *typeArray1;
    NSArray *typeArrayDisplay;
    NSArray *arrayCountExercises;

    
    //The query to fetch from the database.
    NSString *exerciseQuery;
    
    NSString *specialNameSearchQuery;
    NSString *specialNameSearchTitle;
    
    NSString *selectedForPopup;
    NSString *generatedTitleForPopup;
    NSString *typeOfSelected;
    
    NSArray *workoutDifficulty;
    NSArray *sports;
    NSArray *muscles;
    NSArray *workoutType;
    NSArray *equip;
}


//The scroller that holds the browse view.
@property (weak, nonatomic) IBOutlet UIScrollView *scroller;

//The textField for the search by name segment.
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

//Here are my three main views, the segmented control toggles between them.
@property (weak, nonatomic) IBOutlet UIView *preBuiltWorkouts;
@property (weak, nonatomic) IBOutlet UIView *browseView;

//The segmented control that controls toggle of views.
@property (weak, nonatomic) IBOutlet UISegmentedControl *segementedControl;

//Our collectionviews inside the browse view.
@property (weak, nonatomic) IBOutlet UICollectionView *ourFavoritesView;
@property (weak, nonatomic) IBOutlet UITableView *allWorkoutsTableView;

//The page scroller inside the browse view, this allows for the page to be bigger than default.
//@property (weak, nonatomic) IBOutlet UIScrollView *scroller;
//^^^^This is if we decide to add more content to the page and want to enable scrolling.

//Search button, for search by name.
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

//The uibarbutton that toggles the sidebar.
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

//Start of method inheritance.
//The sgemented control method, i.e. what happens if the index is changed.
- (IBAction)segmentValueChanged:(id)sender;



@end
