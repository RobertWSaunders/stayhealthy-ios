//
//  WalkThoughOneViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-02.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import "WalkThoughOneViewController.h"

@interface WalkThoughOneViewController ()

@end

@implementation WalkThoughOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableViewItems = @[@"Terms of Use",@"Privacy Policy"];
    self.tableView.scrollEnabled = NO;
}


//Returns the number of rows that should be displayed in the tableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableViewItems.count;
}

//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Configures the cells at a specific indexPath.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        //Define the identifier.
        static NSString *muscleSelectionCellIdentifier = @"legalCell";
        
        //Create reference to the cell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleSelectionCellIdentifier];
        
        //If the cell can't be found then just create one.
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:muscleSelectionCellIdentifier];
        }
    
        cell.textLabel.text = [tableViewItems objectAtIndex:indexPath.row];
    
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
    
    return cell;
}

//What happens when the user selects a cell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
        [self performSegueWithIdentifier:@"toWebView" sender:nil];

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



        
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    UINavigationController *navController = segue.destinationViewController;
    
    WebViewViewController *webViewViewController = [[WebViewViewController alloc] init];
    webViewViewController = navController.viewControllers[0];
    
    if (indexPath.row == 0) {
        webViewViewController.titleText = @"Terms of Use";
        webViewViewController.url = TERMS_URL;
        webViewViewController.showClose = YES;
        
    }
    else {
        webViewViewController.titleText = @"Privacy Policy";
        webViewViewController.url = PRIVACY_URL;
        webViewViewController.showClose = YES;
    }



    
}


- (IBAction)doneTapped:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_FIRST_LAUNCH];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
