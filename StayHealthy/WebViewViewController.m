//
//  WebviewViewController.m
//  StayHealthy
//
//  Created by Student on 2014-08-18.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//

#import "WebViewViewController.h"


@interface WebViewViewController ()

@end

@implementation WebViewViewController

/**********************************/
#pragma mark - View Loading Methods
/**********************************/


//What happens right before the view loads.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden=YES;
    
     self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (!self.showClose) {
        self.navigationItem.rightBarButtonItems = nil;
    }
    else {
        UIBarButtonItem *closeButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonTapped:)];
        self.navigationItem.leftBarButtonItems = @[closeButton];
    }

    //Set the title in the navigation bar of the view to the passed title.
    self.title = self.titleText;
    
    //Do this avoid the webview to start way below the navigation bar.
    self.automaticallyAdjustsScrollViewInsets = NO;
 
        if ([CommonUtilities isInternetConnection]) {

        //Create a new NSURL and set the url equal to what is passed to the view controller.
        NSURL *url = [NSURL URLWithString:self.url];
    
        //Create a NSURLRequest with the created NSURL.
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
        self.webView.delegate = self;
    
        //Load the NSURLRequest in the WebView.
        [self.webView loadRequest:requestObj];
            
        [CommonUtilities showCustomActivityIndicator:self.spinnerImage];
            
        }
        else {
            [CommonSetUpOperations performTSMessage:@"No Internet Connection" message:nil viewController:self canBeDismissedByUser:YES duration:6];
        }
    
    
    
}

/*****************************************/
#pragma mark - UIWebView Delegate Methods
/*****************************************/

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    //Start the animation
     self.spinnerImage.hidden = NO;
    [self.spinnerImage startAnimating];
}

//What happens when the webview has loaded the url.
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinnerImage stopAnimating];
    self.spinnerImage.hidden = YES;
}


- (void)webView:(UIWebView *)webView
didFailLoadWithError:(NSError *)error {
    [self.spinnerImage stopAnimating];
    self.spinnerImage.hidden =YES;
    [CommonSetUpOperations performTSMessage:@"Oops, there must have been an error!" message:nil viewController:self canBeDismissedByUser:YES duration:6];
}



- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
