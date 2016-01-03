//
//  ExerciseSelectionViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-07-05.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

@protocol ExerciseSelectionDelegate;

#import <UIKit/UIKit.h>
#import "ExerciseListController.h"
#import "ExerciseTableViewCell.h"
#import "CustomWorkoutSelectionViewController.h"
#import "ExerciseAdvancedSearchViewController.h"
#import "BodyViewCollectionViewCell.h"
#import "FavoritesViewController.h"

@interface ExerciseSelectionViewController : UIViewController <FavoritesExerciseSelection, UITableViewDataSource, UITableViewDelegate, ExerciseSelectionSearchedDelegate, MGSwipeTableCellDelegate, AdvancedExerciseSelectionDelegate, UICollectionViewDataSource, UICollectionViewDelegate> {
    
    NSArray *collectionViewBodyZones;
    NSArray *collectionViewBodyZonesMuscles;
    NSArray *collectionViewBodyZonesImages;
    
    IBOutlet UISegmentedControl *segmentedControl;
    
    NSMutableDictionary *dataSource;
    NSArray *sections;
    //Array filled with all the front body muscles.
    NSArray *frontBodyMuscles;
    //Array filled with all the front body muscle scientific names.
    NSArray *frontBodyMusclesScientificNames;
    //Array filled with all the back body muscles.
    NSArray *backBodyMuscles;
    //Array filled with all the back body muscle scientific names.
    NSArray *backBodyMusclesScientificNames;
    //Array filled with all the recenlty viewed exercises.
    NSMutableArray *recenltyViewedExercises;
    //Keeps track of the index the user selected in the alert.
    NSUInteger alertIndex;
    //Keeps track of the indexPath of the cell the user selected in the muscleSelectionTableView.
   // NSIndexPath *selectedTableViewIndex;
    //Boolean to track whether the user pressed on the warmup icon or not.
    BOOL warmupPressed;
    BOOL bodyZonePressed;
    BOOL checkIndex;
    exerciseTypes typeSwiped;
    NSMutableArray *selectedWorkoutExercises;
    NSIndexPath *selectedIndex;
    NSIndexPath *selectedCollectionViewIndex;
}
- (IBAction)favListPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *bodyZoneCollectionView;
@property (weak, nonatomic) IBOutlet UIView *bodyZoneView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarTopRecentlyViewed;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toolbarTopMuscleSelection;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) NSIndexPath *selectedTableViewIndex;
@property (weak, nonatomic) IBOutlet UIView *recentlyViewedView;
@property (weak, nonatomic) IBOutlet UIView *muscleSelectionView;
@property (weak, nonatomic) IBOutlet UITableView *recentlyViewedTableView;
@property (weak, nonatomic) IBOutlet UITableView *muscleSelectionTableView;
@property (nonatomic, assign) BOOL exerciseSelectionMode;
@property(strong, retain) NSMutableArray *selectedExercises;

- (IBAction)searchToolbarPressed:(id)sender;

- (IBAction)segmentValueChanged:(id)sender;
- (IBAction)warmupButtonPressed:(id)sender;

//Exercise Seletion Delegate
@property (assign, nonatomic) id <ExerciseSelectionDelegate> delegate;

@end

@protocol ExerciseSelectionDelegate <NSObject>

- (void)selectedExercises:(NSMutableArray*)selectedExercises;

@end
