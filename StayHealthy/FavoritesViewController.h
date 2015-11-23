//
//  FavoritesViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-10-17.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseDetailViewController.h"
#import "ExerciseTableViewCell.h"

@interface FavoritesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *favoritesData;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;

- (IBAction)segmentValueChanged:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *favoritesTableView;

@end
