//
//  TKExamplesMasterViewController.h
//  SVC
//
//  Copyright © 2015 Telerik. All rights reserved.
//

@class TKExamplesExampleInfo;
@class TKDataSource;

@interface TKExamplesMasterViewController : UITableViewController

@property (nonatomic, strong) TKExamplesExampleInfo *example;

@property (nonatomic, strong) TKDataSource *dataSource;

- (instancetype)initWithExample:(TKExamplesExampleInfo*)example;

@end
