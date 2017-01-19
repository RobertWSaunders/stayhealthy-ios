//
//  TKExamplesDetailViewController.h
//  SVC
//
//  Copyright © 2015 Telerik. All rights reserved.
//

@class TKExamplesExampleInfo;

@interface TKExamplesDetailViewController : UIViewController

@property (nonatomic, strong) TKExamplesExampleInfo *example;

@property (nonatomic, strong) UIPopoverController *popover;

@end
