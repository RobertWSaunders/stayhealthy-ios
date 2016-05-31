//
//  ExerciseSelectionViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-07-05.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseListController.h"
#import "FavoritesViewController.h"
#import "ExerciseAdvancedSearchViewController.h"
#import "CustomWorkoutSelectionViewController.h"
#import "BodyViewCollectionViewCell.h"
#import "ExerciseTableViewCell.h"
#import "ExerciseCollectionViewCell.h"
#import "UIScrollView+EmptyDataSet.h"

@interface ExerciseSelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, ExerciseListExerciseSelectionDelegate, LikedExercisesExerciseSelectionDelegate, AdvancedSearchExerciseSelectionDelegate, MGSwipeTableCellDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate> {

    //Body Zoning
    //Body Zone Strings
    NSArray *bodyZones;
    //Body Zone Images
    NSArray *bodyZonesImages;
    //Body Zone Images For Exercise Selection Mode
    NSArray *bodyZonesImagesExerciseSelectionMode;
    
    //Recently Viewed
    //Array filled with all the recenlty viewed exercises.
    NSMutableArray *sortedRecenltyViewedExercises;
    NSMutableArray *recentlyViewedExercisesSections;
    NSMutableDictionary *recentlyViewedExercises;
    //Array filled with all of the users custom exercises.
    NSMutableArray *customExercises;
    
    //Track whether the user pressed on a body zone.
    BOOL bodyZonePressed;
    //Set to what button is pressed in SIAlertView, for prepareForSegue.
    NSUInteger alertButtonIndex;
    //Set to the index of the selected collection view cell for body zone.
    NSIndexPath *selectedBodyZoneIndex;
    //Set to index of swiped cell, used for adding exercises to workouts.
    NSIndexPath *selectedIndex;
    //Set index to the selected tableView row.
    NSIndexPath *selectedTableViewIndex;
    //Selected index for the recently viewed collectionview.
    NSIndexPath *selectedRecentCollectionViewIndex;
    //Long Press Gesture For Non 3D Touch Devices
    UIGestureRecognizer *longPress;
    //The exercise detail view that is used in the peek preview.
    ExerciseDetailViewController *previewingExerciseDetailViewController;
}

//User Interface Elements
//Body Zone View
@property (weak, nonatomic) IBOutlet UIView *bodyZoneView;
//Body Zone CollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *bodyZoneCollectionView;

//Recently Viewed View
@property (weak, nonatomic) IBOutlet UIView *recentlyViewedView;
//Recently Viewed TableView
@property (weak, nonatomic) IBOutlet UITableView *recentlyViewedTableView;
//Recent Exercises CollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *recentExercisesCollectionView;

//Custom Exercises View
@property (weak, nonatomic) IBOutlet UIView *customExercisesView;
//Custom Exercises TableView
@property (weak, nonatomic) IBOutlet UITableView *customExercisesTableView;
//Custom Exercises CollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *customExercisesCollectionView;

//Segmented Control
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
//Exercise Selection Mode Toolbar
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

//Contraints
//Constraint that controls distance the toolbar is from the recently viewed view.
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarTopRecentlyViewed;
//Constraint that controls distance the toolbar is from the custom exercises.
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarTopCustomExercises;


//View Controller Properties
//Set to YES for view to load as exercise selection mode.
@property (nonatomic, assign) BOOL exerciseSelectionMode;
//The selected exercises that the users selects.
@property(strong, retain) NSMutableArray *selectedExercises;
//The module that the view should be rendered.
@property (nonatomic, assign) modules moduleRender;

//Actions
//What happens when the user selects advanced search.
- (IBAction)advancedSearchPressed:(id)sender;
//What happens when the user selects the favourites icon from the toolbar.
- (IBAction)likedExerciseSelectionPressed:(id)sender;
//What happens when the user changes segments on the segmented control.
- (IBAction)segmentValueChanged:(id)sender;
//What happens when the user presses the add exercise icon.
- (IBAction)addExerciseButtonPressed:(id)sender;

//Exercise Selection Delegate
@property (assign, nonatomic) id <ExerciseSelectionDelegate> delegate;

@end

