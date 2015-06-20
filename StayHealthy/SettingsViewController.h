//
//  SettingsViewController.h
//  StayHealthy
//
//  Created by Student on 1/5/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "CommonSetUpOperations.h"
#import "WebviewViewController.h"
#import "SIAlertView.h"

@interface SettingsViewController : UITableViewController <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

@end
