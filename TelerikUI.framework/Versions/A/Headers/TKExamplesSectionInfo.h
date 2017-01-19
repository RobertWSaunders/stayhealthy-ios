//
//  TKExamplesSectionInfo.h
//  SVC
//
//  Copyright © 2015 Telerik. All rights reserved.
//

@interface TKExamplesSectionInfo : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSMutableArray *options;

@property (nonatomic) NSInteger selectedOption;

- (instancetype)initWithTitle:(NSString*)title;

@end
