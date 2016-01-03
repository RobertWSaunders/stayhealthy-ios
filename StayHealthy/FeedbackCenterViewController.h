//
//  FeedbackCenterViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-16.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
//Import "MessageUI.h" for email.

@interface FeedbackCenterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate> {
    
    NSArray *feedbackItems;
    NSArray *feedbackItemsImages;
}
@property (weak, nonatomic) IBOutlet UITableView *feedbackCenterTableView;

@end
