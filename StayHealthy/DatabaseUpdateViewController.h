//
//  DatabaseUpdateViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-16.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatabaseUpdateViewController : UIViewController {
    NSArray *databaseUpdatesArray;
}
@property (weak, nonatomic) IBOutlet UILabel *userInformationLabel;
@property (weak, nonatomic) IBOutlet UIImageView *successFullImageView;

@property (weak, nonatomic) IBOutlet UIImageView *activityIndicatorImageView;

@property (weak, nonatomic) IBOutlet UITableView *databaseUpdateTableView;

@end
