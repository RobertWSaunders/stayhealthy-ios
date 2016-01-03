//
//  WalkThoughOneViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-02.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewViewController.h"

@interface WalkThoughOneViewController : UIViewController <UITableViewDataSource,UITableViewDelegate> {
    NSArray *tableViewItems;
    NSIndexPath *selectedIndexPath;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topDistanceConstraint;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)doneTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *legalTableView;

@end
