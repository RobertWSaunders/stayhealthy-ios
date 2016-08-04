//
//  HelpCenterViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-16.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import "HelpCenterViewController.h"

@interface HelpCenterViewController ()

@end

@implementation HelpCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden=YES;
    
    self.title = @"Help Center";
    
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    helpCenterItems = @[@"Email Support"];
    helpCenterItemsImages = @[@"EmailSupport.png"];
    
    self.helpCenterTableView.scrollEnabled = NO;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the height of the cells inside the tableView.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

//Returns the number of rows that should be displayed in the tableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Configures the cells at a specific indexPath.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
        //Define the identifier.
        static NSString *muscleSelectionCellIdentifier = @"helpCell";
        
        //Create reference to the cell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleSelectionCellIdentifier];
    

    cell.textLabel.text = [helpCenterItems objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[helpCenterItemsImages objectAtIndex:indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
     
    
    cell.textLabel.font = TABLE_VIEW_TITLE_FONT;
    cell.textLabel.textColor = JOURNAL_COLOR;
    
        //Return the cell.
        return cell;
        

}


//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

//What happens when the user selects a cell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

        [self showEmailScreen:@"StayHealthy Support" email:SUPPORT_EMAIL];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//Returns the title for footers in the tableView.
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
      return @"Having problems? Reach out to us and we will respond as soon as we can! Note, sometimes we are out of the office breaking a sweat or enjoying the beautiful weather so we may not get back to you right away, we always get back to you within 24 hours though!";
    
}

/*************************************************************************/
#pragma mark - MFMailComposeViewController Delegate and Datasource Methods
/*************************************************************************/

//Give the user feedback as to what happened with their email they sent using the MFMailComposeViewController.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    switch (result) {
        case MFMailComposeResultCancelled:
        {
    //        [CommonSetUpOperations performTSMessage:@"Email Cancelled" message:nil viewController:self canBeDismissedByUser:YES duration:4];
        }
            break;
        case MFMailComposeResultSent:
        {
    //        [CommonSetUpOperations performTSMessage:@"Email Sent" message:nil viewController:self canBeDismissedByUser:YES duration:4];
        }
            break;
        case MFMailComposeResultFailed:
        {
     //       [CommonSetUpOperations performTSMessage:@"Email Failed" message:nil viewController:self canBeDismissedByUser:YES duration:4];
        }
            break;
        case MFMailComposeResultSaved:
        {
    //        [CommonSetUpOperations performTSMessage:@"Email Saved" message:nil viewController:self canBeDismissedByUser:YES duration:4];
        }
            break;
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Creates an email and presents it on the screen, used to email feedback.
-(void)showEmailScreen:(NSString*)emailSubject email:(NSString*)email {
    
    if ([MFMailComposeViewController canSendMail]){
        NSArray *recipient = [[NSArray alloc]initWithObjects:email, nil];
        MFMailComposeViewController* mailViewController = [[MFMailComposeViewController alloc] init];
        [mailViewController setMailComposeDelegate: self];
        [mailViewController setSubject:emailSubject];
        [mailViewController setMessageBody:[NSString stringWithFormat:@"\n\n\n\n StayHealthy Version: %@ (%@)",[CommonUtilities shortAppVersionNumber], [CommonUtilities appBuildNumber]] isHTML:NO];
        [mailViewController setToRecipients:recipient];
        
        [self presentViewController: mailViewController
                           animated: YES
                         completion: nil];
    }
    else{
  //      [CommonSetUpOperations performTSMessage:@"Unable to send email." message:@"Cannot send email because you haven't set up your information in the mail app." viewController:self canBeDismissedByUser:YES duration:6];
    }
    
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"helpWeb"]) {
        WebViewViewController *webViewViewController = [[WebViewViewController alloc] init];
        webViewViewController = segue.destinationViewController;
        webViewViewController.titleText = @"FAQ";
        webViewViewController.url = @"";
        webViewViewController.showClose = NO;
    }
}

//Handles anything we need to clear or reset when the view is about to disappear.
-(void)viewWillDisappear:(BOOL)animated {
    //Dismiss any outstaning notifications.
    [TSMessage dismissActiveNotification];
}

@end
