//
//  SettingsViewController.h
//  StayHealthy
//
//  Created by Student on 1/5/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "WebviewViewController.h"

@interface SettingsViewController : UITableViewController <MFMailComposeViewControllerDelegate> {
    //Array for the general settings section in the tableView.
    NSArray *generalSettings;
    //
    NSArray *questionsFeedback;
    //Array for the legal section in the tableView.
    NSArray *legalTerms;

}

@end
