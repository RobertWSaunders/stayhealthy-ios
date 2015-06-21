//
//  ImprovedExerciseController.h
//  StayHealthy
//
//  Created by Student on 3/23/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//

/***************************************************HEADER FILE***************************************/
//Make sure to always have all imports in here.
//Link both delegates and datasources of the collectionview and tableview.
//Might need to create outlets to change CGRECT options.

#import <UIKit/UIKit.h>
//^^^^^^^^^^^^Standard UIKit.
#import <sqlite3.h>
#import "ExerciseDetailViewController.h"
#import "sqlColumns.h"
#import "ExerciseCollectionCell.h"
#import "MGSwipeTableCell.h"
#import "MGSwipeButton.h"


//Incorporate all delegates.
@interface ImprovedExerciseController : UIViewController < UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate> {
    NSMutableArray *exerciseData;
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^The array that will hold all the exercise data.
    sqlite3 * db;
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^The database declaration./the database.
    NSString *exerciseType;
    NSArray *checkIfFavorite;
}

//The views, toggle, new!
//Try to keep propeties together.
@property (weak, nonatomic) IBOutlet UIView *tableViewList;
@property (weak, nonatomic) IBOutlet UIView *collectionViewGroup;

@property (strong, nonatomic) NSString *query;
@property (strong, nonatomic) NSString *titleText;
//We receive this string from muscle selection viewcontroller, to then print to the viewcontroller.

@property(nonatomic,retain) NSMutableArray *exerciseData;

@property (nonatomic) BOOL noResultsToDisplay;
//The boolean value that checks if any results show up for the advanced search.

@property (weak, nonatomic) IBOutlet UICollectionView *groupCollection;
//Our collection view, this is used for the NSIndexPath, when we send data to detail.

@property (weak, nonatomic) IBOutlet UITableView *list;
//Our table view, this is used for the NSIndexPath, when we send data to detail.

//The mutable array.
-(NSMutableArray *) exerciseData;


@end
