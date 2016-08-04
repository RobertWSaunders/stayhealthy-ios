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
#import "ExerciseCollectionViewCell.h"

@interface ExerciseSelectionViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UIToolbarDelegate, ExerciseListExerciseSelectionDelegate, LikedExercisesExerciseSelectionDelegate, AdvancedSearchExerciseSelectionDelegate,UIScrollViewDelegate> {

    //Segmented Control
    UISegmentedControl *segmentedControl;
    
    //Body Zoning
    //Body Zone Strings
    NSArray *bodyZones;
    //Body Zone Images
    NSArray *bodyZonesImages;
    //Body Zone Images For Exercise Selection Mode
    NSArray *bodyZonesImagesExerciseSelectionMode;
    
    //Array filled with all of the users custom exercises.
    NSMutableArray *customExercises;
    
    //Track whether the user pressed on a body zone.
    BOOL bodyZonePressed;
    //Set to the index of the selected collection view cell for body zone.
    NSIndexPath *selectedBodyZoneIndex;
    //Set to index of swiped cell, used for adding exercises to workouts.
    NSIndexPath *selectedIndex;
}

//User Interface Elements
//Body Zone View
@property (weak, nonatomic) IBOutlet UIView *bodyZoneView;
//Body Zone CollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *bodyZoneCollectionView;

//Categories Viewed View
@property (weak, nonatomic) IBOutlet UIView *categoriesView;
//Categories Exercises CollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *categoriesCollectionView;

//Custom Exercises View
@property (weak, nonatomic) IBOutlet UIView *customExercisesView;
//Custom Exercises CollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *customExercisesCollectionView;

//Segmented Control Toolbar
@property (weak, nonatomic) IBOutlet UIToolbar *segmentedControlToolbar;


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
//What happens when the user presses the add exercise icon.
- (IBAction)addExerciseButtonPressed:(id)sender;

//Exercise Selection Delegate
@property (assign, nonatomic) id <ExerciseSelectionDelegate> delegate;

@end

