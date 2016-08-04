//
//  WorkoutBrowseOptionsViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-25.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutListViewController.h"

@interface WorkoutBrowseOptionsViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    
    NSArray *tableViewArray;
    
}

@property (strong, nonatomic) NSString *viewTitle;

@property (nonatomic, assign) workoutBrowseOptions passedOption;

@property (weak, nonatomic) IBOutlet UITableView *browseOptionsTableView;


@end
