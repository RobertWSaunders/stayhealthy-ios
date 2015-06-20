//
//  TermsViewController.m
//  StayHealthy
//
//  Created by Student on 2014-08-18.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import "TermsViewController.h"

@interface TermsViewController ()

@end

@implementation TermsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self styleView:self.termsOfServiceView];
}

-(void)styleView:(UIView*)viewToStyle {
    viewToStyle.layer.masksToBounds = NO;
    viewToStyle.layer.borderColor = [UIColor whiteColor].CGColor;
    viewToStyle.layer.borderWidth = 2.0f;
    viewToStyle.layer.shadowOpacity = 0.10f;
    viewToStyle.layer.shadowRadius = 4.0f;
    viewToStyle.layer.shadowOffset = CGSizeZero;
    viewToStyle.layer.shadowPath = [UIBezierPath bezierPathWithRect: viewToStyle.bounds].CGPath;
    viewToStyle.layer.cornerRadius = 4.0f;
}

@end
