//
//  DetailViewController.h
//  StayHealthy
//
//  Created by Student on 12/7/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
