//
//  ExampleViewController.h
//  SVC
//
//  Copyright © 2015 Telerik. All rights reserved.
//

@class TKExamplesOptionInfo;

@interface TKExamplesExampleViewController : UIViewController

@property (nonatomic, strong, readonly) NSArray *options;

@property (nonatomic, strong, readonly) NSArray *sections;

@property (nonatomic) NSUInteger selectedOption;

- (TKExamplesOptionInfo*)addOption:(NSString*)title selector:(SEL)selector;

- (TKExamplesOptionInfo*)addOption:(NSString*)title selector:(SEL)selector inSection:(NSString*)sectionName;

- (TKExamplesOptionInfo*)addOption:(NSString*)title action:(void (^)())action;

- (TKExamplesOptionInfo*)addOption:(NSString*)title inSection:(NSString*)sectionName withAction:(void (^)())action;

- (void)didSelectOption:(TKExamplesOptionInfo*)option atIndex:(NSUInteger)index;

- (void)setSelectedOption:(NSInteger)selectedOption inSection:(NSInteger)section;

@end
