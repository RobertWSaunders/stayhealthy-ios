//
//  advancedOptionsSelect.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-03-21.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface advancedOptionsSelect : UITableViewController <UITableViewDataSource, UITableViewDelegate>

//Array that is passed to the view controller to display.
@property(strong,retain) NSArray *arrayForTableView;
//Array that holds the information regarding which cells the user selected.
@property(strong,retain) NSMutableArray *selectedCells;
//Title text which is passed to the view controller to display.
@property (strong, nonatomic) NSString *titleText;
//The passed exercise attribute, i.e what the user is searching for.
@property (nonatomic, assign) exerciseAttributes typeOfExerciseAttribute;
@property (nonatomic, assign) BOOL singleSelectionMode;
@property (nonatomic, assign) BOOL viewMode;

//Index path of cell pressed to get to this view controller.
@property (retain,strong) NSIndexPath *indexPathPassed;

//Advanced Options Delegate
@property (assign, nonatomic) id <MultiPurposeListViewDelegate> delegate;
@end
