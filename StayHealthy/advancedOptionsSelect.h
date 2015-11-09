//
//  advancedOptionsSelect.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-03-21.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

//Advanced Options Delegate
@protocol AdvancedOptionsDelegate;

//Specifies the different types of exercise attributes.
typedef enum {
    primaryMuscle,
    secondaryMuscle,
    equipment,
    difficulty,
    exerciseType
} exerciseAttributes;

@interface advancedOptionsSelect : UITableViewController <UITableViewDataSource, UITableViewDelegate>

//Array that is passed to the view controller to display.
@property(strong,retain) NSArray *arrayForTableView;
//Array that holds the information regarding which cells the user selected.
@property(strong,retain) NSMutableArray *selectedCells;
//Title text which is passed to the view controller to display.
@property (strong, nonatomic) NSString *titleText;
//The passed exercise attribute, i.e what the user is searching for.
@property (nonatomic, assign) exerciseAttributes typeOfExerciseAttribute;

//Index path of cell pressed to get to this view controller.
@property (retain,strong) NSIndexPath *indexPathPassed;


//Advanced Options Delegate
@property (assign, nonatomic) id <AdvancedOptionsDelegate>delegate;
@end

@protocol AdvancedOptionsDelegate<NSObject>

//Optional Methods (not neccesary to be implemented unless needed.
@optional

//When the user pressed done at the top right.
- (void)userHasSelected:(NSMutableArray*)selectedValues indexPath:(NSIndexPath*)indexPath passedArrayCount:(NSInteger)passedArrayCount;

@end
