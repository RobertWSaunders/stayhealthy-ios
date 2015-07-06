//
//  FavoritesViewController.h
//  StayHealthy
//
//  Created by Student on 1/20/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

/***************************************************HEADER FILE***************************************/
//This file displays the favorites, through the use of collection views.

#import <UIKit/UIKit.h>
//^^^^^^^^^^The standard UIKit.
#import "FavoritesCell.h"


//^^^^^^^^^^Our FlatUI colors.
#import "ExerciseDetailViewController.h"
//^^^^^^^^^^The detail view controller so we can push to it.
#import <sqlite3.h>
//^^^^^^^^^^The database library.
#import "UIViewController+MJPopupViewController.h"
#import "PopupViewController.h"
#import "workoutCell.h"

#import "WorkoutDetailViewController.h"

//Have to inherit the UICollectionview Delegates and Datasource.
@interface FavoritesViewController : UIViewController <UICollectionViewDelegate,UICollectionViewDataSource,MJSecondPopupDelegate, backDelegate> {
    
    NSMutableArray *favoriteStrengthExercises;
    NSMutableArray *favoriteStrengthExercisesData;
    //favoriteStrengthExercises array.
    NSMutableArray *favoriteStretchExercises;
    NSMutableArray *favoriteStretchExercisesData;
    //favoriteStretchExercise array.
    NSMutableArray *favoriteWarmupExercises;
    NSMutableArray *favoriteWarmupExercisesData;
    
    NSMutableArray *favoriteWorkouts;
    NSMutableArray *favoriteWorkoutsData;
    NSArray *workoutImages;
    //favoriteWarmupExercises array.
    
    sqlite3 * db;
    //then the database.
    
    NSString *favoriteQuery;
    NSArray *exerciseIdentifiers;
    NSArray *exerciseType;
    
    IBOutlet UICollectionView *stretchingCollectionView;
    IBOutlet UICollectionView *workoutsCollectionView;
    IBOutlet UICollectionView *strengthCollectionView;
    IBOutlet UICollectionView *warmupCollectionView;
    
    IBOutlet UIBarButtonItem *sidebarIcon;
    
    IBOutlet UISegmentedControl *segmentedControl;

    IBOutlet UIScrollView *scroller;
}

//Then what happens when the segment changes.
- (IBAction)segmentValueChanged:(id)sender;

@end
