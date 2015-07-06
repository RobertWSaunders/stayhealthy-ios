//
//  WorkoutsSearchedViewController.h
//  StayHealthy
//
//  Created by Student on 7/20/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

/***************************************************HEADER FILE***************************************/

#import <UIKit/UIKit.h>

//^^^^^^^The workoutObjects in database.
#import <sqlite3.h>
//^^^^^^^Mandatory database implementation.

//^^^^^^^The Flat UI kit that is used for ui.
#import "workoutCell.h"

//^^^^^^^Our exercise database objects.
#import "WorkoutDetailViewController.h"
//^^^^^^^The detailViewController for the workouts.
#import "CommonSetUpOperations.h"

//Call all the delegates.
@interface WorkoutsSearchedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate> {
    
    __weak IBOutlet UIView *tableViewView;
    __weak IBOutlet UIView *collectionViewView;
    //The array that holds the workout data.
    NSMutableArray *workoutData;
    
    //The array that holds the workout exercises data images.
    NSMutableArray *workoutImages;
    
    //The database declaration. The database.
    sqlite3 * db;
    
    //My array for the exerciseIDs, I need to fetch from the database.
    NSArray *exerciseIdentifiers;
    NSArray *exerciseType;
    NSArray *typeArrayData;
    NSArray *typeArrayDisplay;
    NSArray *arrayCountExercises;
    
    //The tableview and collectionview.
    __weak IBOutlet UITableView *workoutsTableview;
    __weak IBOutlet UICollectionView *workoutsCollectionView;
    
    NSString *exerciseQuery;
}

//The title thats all ready generated in the previous ViewController.
@property (strong, nonatomic) NSString *titleText;

//THe query for the database fetch.
@property (strong, nonatomic) NSString *query;

//THe query for the exercise database fetch.
@property (strong, nonatomic) NSString *exerciseQuery;

@end
