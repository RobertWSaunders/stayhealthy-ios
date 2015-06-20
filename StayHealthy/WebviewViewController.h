//
//  WebviewViewController.h
//  StayHealthy
//
//  Created by Student on 2014-08-18.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebviewViewController : UIViewController <UIWebViewDelegate>

@property (weak,nonatomic) NSString *url;
@property (weak,nonatomic) NSString *titleText;
@property (weak, nonatomic) IBOutlet UIWebView *facebookWebview;

@end
