//
//  advancedOptionsSelect.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-03-21.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

//Advanced Options Delegate
@protocol AdvancedOptionsDelegate;

@interface advancedOptionsSelect : UITableViewController <UITableViewDataSource, UITableViewDelegate>

//Action when cancel is pressed.
- (IBAction)cancelPressed:(id)sender;

//Array that is passed to the view controller to display.
@property(nonatomic,retain) NSArray *arrayForTableView;
//Title text which is passed to the view controller to display.
@property (strong, nonatomic) NSString *titleText;
//number of the cell, used to correspond to the parent viewcontroller, to display correct detail text.
@property (nonatomic, assign) NSInteger num;

//Advanced Options Delegate
@property (assign, nonatomic) id <AdvancedOptionsDelegate>delegate;
@end
@protocol AdvancedOptionsDelegate<NSObject>
@optional
//Delegate methods.
- (void)done:(NSString*)selectedValue num:(NSInteger*)cell;

@end
