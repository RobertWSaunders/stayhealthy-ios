//
//  ExerciseListController.h
//  StayHealthy
//
//  Created by Student on 3/23/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseDetailViewController.h"
#import "ExerciseCollectionCell.h"
#import "SHDataHandler.h"
#import "SHExercise.h"
#import "QuickFilterViewController.h"
#import "ExerciseTableViewCell.h"
#import "HomeTabBarController.h"

@interface ExerciseListController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate, UIViewControllerPreviewingDelegate> {
    NSMutableArray *exerciseData;
    NSIndexPath *selectedIndex;
    //Set index of peek preview cell.
    NSIndexPath *selectedPreviewingIndex;
    
    //The exercise detail view that is used in the peek preview.
    ExerciseDetailViewController *previewingExerciseDetailViewController;
    
}


//PASSED PROPERTIES
//Query which is passed to the view.
@property (strong, nonatomic) NSString *exerciseQuery;
//Title which is passed to the view.
@property (strong, nonatomic) NSString *viewTitle;


//COLLECTION VIEW AND TABLEVIEW
//Exercise CollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *collectonView;
//Exercise TableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, assign) BOOL exerciseSelectionMode;

//Array that holds the information regarding which exercises the user selected.
@property(strong, retain) NSMutableArray *selectedExercises;

//Exercise Seletion Delegate
@property (assign, nonatomic) id <ExerciseListExerciseSelectionDelegate> delegate;

@end

