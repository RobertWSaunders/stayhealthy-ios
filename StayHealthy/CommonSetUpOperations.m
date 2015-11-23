//
//  CommonSetUpOperations.m
//  StayHealthy
//
//  Created by Student on 8/2/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import "CommonSetUpOperations.h"

@implementation CommonSetUpOperations

//Styles a UICollectionViewCell
+ (void)styleCollectionViewCell:(UICollectionViewCell*)collectionViewCell {
     collectionViewCell.layer.masksToBounds = NO;
     collectionViewCell.layer.borderColor = [UIColor whiteColor].CGColor;
     collectionViewCell.layer.borderWidth = 2.0f;
     collectionViewCell.layer.shadowOpacity = 0.10f;
     collectionViewCell.layer.shadowRadius = 4.0f;
     collectionViewCell.layer.shadowOffset = CGSizeZero;
     collectionViewCell.layer.shadowPath = [UIBezierPath bezierPathWithRect: collectionViewCell.bounds].CGPath;
     collectionViewCell.layer.cornerRadius = 4.0f;
}

//Performs a TSMessage, specified message, and other parameters.
+ (void)performTSMessage:(NSString*)titleText message:(NSString*)message viewController:(UIViewController*)controllerForDisplay canBeDismissedByUser:(BOOL)canDismiss duration:(int)duration; {
    [TSMessage showNotificationInViewController:controllerForDisplay
                                          title:titleText
                                       subtitle:message
                                          image:nil
                                           type:TSMessageNotificationTypeMessage
                                       duration:duration
                                       callback:nil
                                    buttonTitle:nil
                                 buttonCallback:nil
                                     atPosition:TSMessageNotificationPositionTop
                            canBeDismisedByUser:canDismiss];
}

//Sets the initial tutorial TSMessage.
+ (void)setFirstViewTSMessage:(NSString *)key viewController:(UIViewController *)view message:(NSString *)message {
    //If the user has allowed tutorial messages from the settings page, perform the tutorial message. By default the key is NO, which is actually YES.
    if (![[NSUserDefaults standardUserDefaults] boolForKey:PREFERENCE_TUTORIAL_MESSAGES]) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:key])
            {
                [self performTSMessage:message message:nil viewController:view
                  canBeDismissedByUser:YES duration:1000];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
                [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

//Styles SIAlertViews.
+ (void)styleAlertView {
    //Style the SIAlertView asking what exercise type.
    [[SIAlertView appearance] setTitleFont:alertViewTitleFont];
    [[SIAlertView appearance] setTitleColor:STAYHEALTHY_BLUE];
    [[SIAlertView appearance] setMessageColor:STAYHEALTHY_BLUE];
    [[SIAlertView appearance] setCornerRadius:4];
    [[SIAlertView appearance] setShadowRadius:0];
    [[SIAlertView appearance] setViewBackgroundColor:STAYHEALTHY_WHITE];
    [[SIAlertView appearance] setButtonColor:STAYHEALTHY_BLUE];
    [[SIAlertView appearance] setDestructiveButtonColor:STAYHEALTHY_BLUE];
    [[SIAlertView appearance] setCancelButtonColor:STAYHEALTHY_BLUE];
    [[SIAlertView appearance] setButtonFont:alertViewButtonFont];
    [[SIAlertView appearance] setMessageFont:alertViewMessageFont];
    [[SIAlertView appearance] setMessageColor:STAYHEALTHY_LIGHTGRAYCOLOR];
}

//Loads images in the background.
+ (void)loadImageOnBackgroundThread:(UIImageView *)imageView image:(UIImage *)image {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            imageView.image = image;
            /*imageView.alpha = 0.0;
            [UIView animateWithDuration:0.8 animations:^{
                imageView.alpha = 1.0;
            }];
             */
        });
    });
}

//Sets the selected background color for UITableViews.
+ (UIView*)tableViewSelectionColorSet:(UITableViewCell *)cell {
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = STAYHEALTHY_WHITE;
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];
    return bgColorView;
}

//Draws the view for the TableView header.
+ (UIView *)drawViewForTableViewHeader:(UITableView*)tableView {
    //Create a view for the header.
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    [view setBackgroundColor:STAYHEALTHY_WHITE];
    return view;
}

//Returns the color based off of the difficulty passed to it.
+ (UIColor*)determineDifficultyColor:(NSString *)difficulty {
    if ([difficulty isEqualToString:@"Easy"])
        return STAYHEALTHY_GREEN;
    else if ([difficulty isEqualToString:@"Intermediate"])
        return STAYHEALTHY_DARKERBLUE;
    else if ([difficulty isEqualToString:@"Hard"])
        return STAYHEALTHY_RED;
    else if ([difficulty isEqualToString:@"Very Hard"])
        return [UIColor blackColor];
    return [UIColor blackColor];
}

@end
