//
//  WebviewViewController.h
//  StayHealthy
//
//  Created by Student on 2014-08-18.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewViewController : UIViewController <UIWebViewDelegate>

//Passed url to load in the webView.
@property (weak,nonatomic) NSString *url;
//Title to be displayed in the navigation bar.
@property (weak,nonatomic) NSString *titleText;
@property (nonatomic,assign) BOOL showClose;
//WebView that loads the passed url.
@property (weak, nonatomic) IBOutlet UIWebView *webView;
//Activity indicator that spins while the webview is loading the url.
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)closeButtonTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *spinnerImage;

@end
