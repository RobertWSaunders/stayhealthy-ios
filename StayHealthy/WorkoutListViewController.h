//
//  WorkoutListViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-25.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutTableViewCell.h"
#import "WorkoutDetailViewController.h"

@interface WorkoutListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *workoutData;
    NSIndexPath *selectedIndex;
}

//PASSED PROPERTIES
//Query which is passed to the view.
@property (strong, nonatomic) NSString *workoutQuery;
//Title which is passed to the view.
@property (strong, nonatomic) NSString *viewTitle;

@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end
