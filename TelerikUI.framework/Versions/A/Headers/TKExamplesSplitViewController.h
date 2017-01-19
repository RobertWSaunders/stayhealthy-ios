//
//  TKExamplesSplitViewController.h
//  SVC
//
//  Copyright © 2015 Telerik. All rights reserved.
//

@class TKExamplesMasterViewController;
@class TKExamplesDetailViewController;

@interface TKExamplesSplitViewController : UISplitViewController

@property (nonatomic, readonly) TKExamplesMasterViewController *masterController;

@property (nonatomic, readonly) TKExamplesDetailViewController *detailController;

@end
