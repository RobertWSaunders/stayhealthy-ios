//
//  SettingsViewController.h
//  StayHealthy
//
//  Created by Student on 1/5/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
//Import "MessageUI.h" for email.
#import "WebViewViewController.h"
//Import "WebViewViewController.h" to show social media sites.

@interface SettingsViewController : UITableViewController <MFMailComposeViewControllerDelegate> {
    //Array with the values for the general settings. (Section 1 in the tableView)
    NSArray *generalSettings;

    //Array with the values for the feedback settings. (Section 2 in the tableView)
    NSArray *feedbackSettings;
    
    //Array with the values for the about settings. (Section 3 in the tableView)
    NSArray *aboutSettings;
    
    //Array with the values for the connect settings. (Section 4 in the tableView)
    NSArray *connectSettings;
    
    //Array with the image names for the connect settings. (Section 4 in the tableView)
    NSArray *connectSettingsImages;
    
    //Array with the values for the legal settings. (Section 5 in the tableView)
    NSArray *legalSettings;
    
    //Index path to identify what cell was pressed for the connect section.
    NSIndexPath *selectedIndexPath;
}

@end
