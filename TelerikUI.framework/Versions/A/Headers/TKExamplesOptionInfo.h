//
//  TKExamplesOptionInfo.h
//  SVC
//
//  Copyright © 2015 Telerik. All rights reserved.
//

@class TKExamplesExampleViewController;

@interface TKExamplesOptionInfo : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic) SEL selector;

@property (nonatomic, weak) TKExamplesExampleViewController* owner;

@property (nonatomic, readonly) BOOL isSelected;

@property (nonatomic, copy) void (^action)();

- (instancetype)initWithTitle:(NSString*)title selector:(SEL)selector;

- (void)select;

@end
