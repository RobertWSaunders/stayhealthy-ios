//
//  WalkThoughOneViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-02.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import "WalkThoughOneViewController.h"

@interface WalkThoughOneViewController ()

@end

@implementation WalkThoughOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    tableViewItems = @[@"Terms of Use",@"Privacy Policy"];
    self.tableView.scrollEnabled = NO;
    
    if (IS_IPHONE_6) {
        self.topDistanceConstraint.constant = 84;
    }
    else if (IS_IPHONE_6P) {
        self.topDistanceConstraint.constant = 124;
    }
    else if (IS_IPHONE_5) {
         self.topDistanceConstraint.constant = 46;
    }
    else {
        self.topDistanceConstraint.constant = 15;
    }
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
    selectedIndexPath = indexPath;
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
    
    UINavigationController *navController = segue.destinationViewController;
    
    WebViewViewController *webViewViewController = [[WebViewViewController alloc] init];
    webViewViewController = navController.viewControllers[0];
    
    if (selectedIndexPath.row == 0) {
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
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:USER_FIRST_VIEW_FIND_EXERICSE];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:USER_FIRST_LAUNCH];
    [[NSUserDefaults standardUserDefaults] synchronize];
    /*
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    */
    [self dismissViewControllerAnimated:YES completion:nil];

    
}
@end
