//
//  ExerciseListController.h
//  StayHealthy
//
//  Created by Student on 3/23/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseDetailViewController.h"
#import "SHDataHandler.h"
#import "SHExercise.h"
#import "ExerciseTableViewCell.h"
#import "HomeTabBarController.h"
#import "ExerciseCollectionViewCell.h"

@interface ExerciseListController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate,UIScrollViewDelegate,UIToolbarDelegate> {
    NSMutableArray *exerciseData;
    NSIndexPath *selectedCollectionIndex;
    //Segmented Control
    UISegmentedControl *segmentedControl;
}


//PASSED PROPERTIES
//Query which is passed to the view.
@property (strong, nonatomic) NSString *exerciseQuery;
//Title which is passed to the view.
@property (strong, nonatomic) NSString *viewTitle;

//Segmented Control Toolbar
@property (weak, nonatomic) IBOutlet UIToolbar *segmentedControlToolbar;

//COLLECTION VIEW AND TABLEVIEW
//Exercise CollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *collectonView;


@property (nonatomic, assign) BOOL exerciseSelectionMode;

//Array that holds the information regarding which exercises the user selected.
@property(strong, retain) NSMutableArray *selectedExercises;

//Exercise Seletion Delegate
@property (assign, nonatomic) id <ExerciseListExerciseSelectionDelegate> delegate;

@end

