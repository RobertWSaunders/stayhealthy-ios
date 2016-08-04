//
//  HelpCenterViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-16.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "WebViewViewController.h"

@interface HelpCenterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate> {
    NSArray *helpCenterItems;
    NSArray *helpCenterItemsImages;
}
@property (weak, nonatomic) IBOutlet UITableView *helpCenterTableView;

@end
