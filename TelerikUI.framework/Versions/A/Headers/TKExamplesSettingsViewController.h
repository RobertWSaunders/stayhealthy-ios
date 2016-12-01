//
//  TKExamplesSettingsViewController.h
//  SVC
//
//  Copyright © 2015 Telerik. All rights reserved.
//

@class TKExamplesExampleViewController;

@interface TKExamplesSettingsViewController : UIViewController

@property (nonatomic, weak) UIPopoverController *popover;

@property (nonatomic, assign) NSInteger selectedOption;

@property (nonatomic, strong) TKExamplesExampleViewController *exampleViewController;

@property (nonatomic, strong) UITableView *table;

- (instancetype)initWithExample:(TKExamplesExampleViewController*)exampleViewController;

@end
