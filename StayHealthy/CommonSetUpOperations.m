//
//  CommonSetUpOperations.m
//  StayHealthy
//
//  Created by Student on 8/2/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//

#import "CommonSetUpOperations.h"

@implementation CommonSetUpOperations


+ (void)styleCollectionViewCellBodyZone:(UICollectionViewCell*)collectionViewCell {
    collectionViewCell.layer.masksToBounds = NO;
    collectionViewCell.layer.borderColor = LIGHT_GRAY_COLOR_COLLECTION.CGColor;
    collectionViewCell.layer.borderWidth = 0.50f;
}

+ (void)styleCollectionViewCellBodyZoneSelected:(UICollectionViewCell*)collectionViewCell {
    collectionViewCell.layer.masksToBounds = NO;
    collectionViewCell.layer.borderColor = BLUE_COLOR.CGColor;
    collectionViewCell.layer.borderWidth = 2.0f;
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
        }
    }
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//Styles SIAlertViews.
+ (void)styleAlertView:(UIColor*)color {
    //Style the SIAlertView asking what exercise type.
    [[SIAlertView appearance] setTitleFont:alertViewTitleFont];
    [[SIAlertView appearance] setTitleColor:color];
    [[SIAlertView appearance] setMessageColor:color];
    [[SIAlertView appearance] setCornerRadius:4];
    [[SIAlertView appearance] setShadowRadius:0];
    [[SIAlertView appearance] setViewBackgroundColor:WHITE_COLOR_OLD];
    [[SIAlertView appearance] setButtonColor:color];
    [[SIAlertView appearance] setDestructiveButtonColor:color];
    [[SIAlertView appearance] setCancelButtonColor:color];
    [[SIAlertView appearance] setButtonFont:alertViewButtonFont];
    [[SIAlertView appearance] setMessageFont:alertViewMessageFont];
    [[SIAlertView appearance] setMessageColor:LIGHT_GRAY_COLOR];
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
    bgColorView.backgroundColor = WHITE_COLOR;
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];
    return bgColorView;
}

//Draws the view for the TableView header.
+ (UIView *)drawViewForTableViewHeader:(UITableView*)tableView {
    //Create a view for the header.
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    [view setBackgroundColor:WHITE_COLOR];
    return view;
}

//Returns the color based off of the difficulty passed to it.
+ (UIColor*)determineDifficultyColor:(NSString *)difficulty {
    if ([difficulty isEqualToString:@"Easy"])
        return GREEN_COLOR;
    else if ([difficulty isEqualToString:@"Intermediate"])
        return DARK_BLUE_COLOR;
    else if ([difficulty isEqualToString:@"Hard"])
        return RED_COLOR;
    else if ([difficulty isEqualToString:@"Very Hard"])
        return [UIColor blackColor];
    return LIGHT_GRAY_COLOR;
}

@end
