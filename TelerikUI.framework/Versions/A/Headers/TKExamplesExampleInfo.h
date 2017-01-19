//
//  TKEKExampleInfo.h
//  SVC
//
//  Copyright © 2015 TR. All rights reserved.
//

@interface TKExamplesExampleInfo : NSObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *exampleClass;

@property (nonatomic, strong) NSArray *examples;

- (instancetype)initWithTitle:(NSString*)title examples:(NSArray*)examples;

- (UIViewController*)viewControllerForExample;

@end
