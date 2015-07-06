//
//  workoutOptionsViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-03-27.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkoutsSearchedViewController.h"

@interface workoutOptionsViewController : UITableViewController {
    NSString *generatedTitleForPopup;
}

@property(nonatomic,retain) NSArray *arrayForTableView;
@property (strong, nonatomic) NSString *titleText;
@property (strong, nonatomic) NSString *type;


@end
