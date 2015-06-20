//
//  WebviewViewController.m
//  StayHealthy
//
//  Created by Student on 2014-08-18.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import "WebviewViewController.h"


@interface WebviewViewController ()

@end

@implementation WebviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
 
    self.title = self.titleText;

    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [self.facebookWebview loadRequest:requestObj];
    self.facebookWebview.delegate=self;
}



@end
