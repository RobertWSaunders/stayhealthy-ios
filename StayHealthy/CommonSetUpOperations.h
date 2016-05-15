//
//  CommonSetUpOperations.h
//  StayHealthy
//
//  Created by Student on 8/2/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonSetUpOperations : NSObject

//Styles a UICollectionViewCell
+ (void)styleCollectionViewCell:(UICollectionViewCell*)collectionViewCell;

+ (void)styleCollectionViewCellBodyZone:(UICollectionViewCell*)collectionViewCell;

+ (void)styleCollectionViewCellBodyZoneSelected:(UICollectionViewCell*)collectionViewCell;

//Performs a TSMessage, specified message, and other parameters.
+ (void)performTSMessage:(NSString*)titleText message:(NSString*)message viewController:(UIViewController*)controllerForDisplay canBeDismissedByUser:(BOOL)canDismiss duration:(int)duration;

//Sets the initial tutorial TSMessage.
+ (void)setFirstViewTSMessage:(NSString*)key viewController:(UIViewController*)view message:(NSString*)message;

//Styles SIAlertViews.
+ (void)styleAlertView:(UIColor*)color;

//Loads images in the background.
+ (void)loadImageOnBackgroundThread:(UIImageView*)imageView image:(UIImage*)image;

//Sets the selected background color for UITableViews.
+ (UIView *)tableViewSelectionColorSet:(UITableViewCell*)cell;

//Draws the view for the TableView header.
+ (UIView *)drawViewForTableViewHeader:(UITableView*)tableView;

//Returns the color based off of the difficulty passed to it. 
+ (UIColor*)determineDifficultyColor:(NSString*)difficulty;



@end
