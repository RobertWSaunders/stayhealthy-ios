//
//  SettingsViewController.m
//  StayHealthy
//
//  Created by Student on 1/5/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController  


/**********************************/
#pragma mark - View Loading Methods
/**********************************/

//What happens right before the view loads.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Fills the arrays for the sections in the tableView.
    [self setTableViewData];
    
}

/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the height for the tableViews cells.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

//Returns the number of sections for the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

//Returns the number of rows in each section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   /* if (section == 0) {
        return [generalSettings count];
    }*/
    if (section == 0) {
        return [feedbackSettings count];
    }
    /*else if (section == 1) {
        return [aboutSettings count];
    }*/
    else if (section == 1) {
        return [connectSettings count];
    }
    else {
        return [legalSettings count];
    }
}

//Cell for row at index path for the tableViews.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //The cell identifier for the cells in the tableView.
    static NSString *CellIdentifier = @"settingsCell";
    
    //Create reference to the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //If the cell is equal to nil than create one.
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //Now set the text for the cells dependant on the section.
   /* if (indexPath.section == 0) {
        cell.textLabel.text = [generalSettings objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }*/
    else if (indexPath.section == 0) {
        cell.textLabel.text = [feedbackSettings objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    /*else if (indexPath.section == 1) {
        cell.textLabel.text = [aboutSettings objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }*/
    else if (indexPath.section == 1) {
        cell.textLabel.text = [connectSettings objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[connectSettingsImages objectAtIndex:indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.section == 2) {
        cell.textLabel.text = [legalSettings objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //Set the text color and the font for the cell textLabels.
    cell.textLabel.textColor = STAYHEALTHY_BLUE;
    cell.textLabel.font = tableViewTitleTextFont;
    
    //Set the tableView selection color.
    [CommonSetUpOperations tableViewSelectionColorSet:cell];

    //Finally return the cell.
    return cell;
}

//----------------------------------------------------
#pragma mark TableView Header and Footer Configuration
//----------------------------------------------------

//Returns the height of the section headers.
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

//Returns the height of the footers.
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 30;
    }
    else {
        return 5;
    }
}

//Returns the title for the header in the tableView.
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    /*if (section == 0) {
        return @"General";
    }*/
    if (section == 0) {
        return @"Support";
    }
    /*else if (section == 1) {
        return @"About";
    }*/
    else if (section == 1) {
        return @"Connect";
    }
    else {
        return @"Legal";
    }

    return nil;
}

- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return [CommonUtilities shortAppVersionNumber];
    }
    else {
        return nil;
    }
}

//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

//What happens when a user presses on a tableViewCell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    selectedIndexPath = indexPath;
    
    /*if (indexPath.section == 0 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"preferences" sender:nil];
    }
    */
    if (indexPath.section == 0 && indexPath.row == 1) {
        [self showEmailScreen:@"StayHealthy Feedback" email:@"feedback@stayhealthyapp.com"];
    }
    else if (indexPath.section == 0 && indexPath.row == 0) {
        [self showEmailScreen:@"StayHealthy Support" email:@"support@stayhealthyapp.com"];

    }
    else if (indexPath.section == 2 || indexPath.section == 3) {
        [self performSegueWithIdentifier:@"toWebView" sender:nil];
    }
    /*else if (indexPath.section == 1 || indexPath.row == 0) {
        [self performSegueWithIdentifier:@"acknowledgements" sender:nil];
    }
    else if (indexPath.section == 1 || indexPath.row == 1) {
        [self performSegueWithIdentifier:@"versionHistory" sender:nil];
    }
    */
    
    //Deselect the tableView cell once the user has selected.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*************************************************************************/
#pragma mark - MFMailComposeViewController Delegate and Datasource Methods
/*************************************************************************/

//Give the user feedback as to what happened with their email they sent using the MFMailComposeViewController.
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    switch (result) {
        case MFMailComposeResultCancelled:
        {
            [CommonSetUpOperations performTSMessage:@"Email Cancelled" message:nil viewController:self canBeDismissedByUser:YES duration:4];
        }
            break;
        case MFMailComposeResultSent:
        {
            [CommonSetUpOperations performTSMessage:@"Email Sent" message:nil viewController:self canBeDismissedByUser:YES duration:4];
        }
            break;
        case MFMailComposeResultFailed:
        {
            [CommonSetUpOperations performTSMessage:@"Email Failed" message:nil viewController:self canBeDismissedByUser:YES duration:4];
        }
            break;
        case MFMailComposeResultSaved:
        {
            [CommonSetUpOperations performTSMessage:@"Email Saved" message:nil viewController:self canBeDismissedByUser:YES duration:4];
        }
            break;
        default:
            break;
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

/****************************/
#pragma mark - Helper Methods
/****************************/

//Fills the arrays for the sections in the tableView.
-(void)setTableViewData {
    generalSettings = [NSArray arrayWithObjects:@"Preferences", nil];
    feedbackSettings = [NSArray arrayWithObjects:@"Email Support", @"Send Feedback", nil];
    aboutSettings = [NSArray arrayWithObjects:@"Acknowledgements", @"Version History", nil];
    connectSettings = [NSArray arrayWithObjects:@"Facebook",@"Twitter",@"Tumblr", nil];
    connectSettingsImages = [NSArray arrayWithObjects:@"Facebook.png",@"Twitter.png",@"Tumblr.png", nil];
    legalSettings = [NSArray arrayWithObjects:@"Terms of Use", @"Privacy Policy", nil];
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
        [CommonSetUpOperations performTSMessage:@"Unable to send email." message:@"Cannot send email because you haven't set up your information in the mail app." viewController:self canBeDismissedByUser:YES duration:6];
        
    }

}

/********************************/
#pragma mark - Prepare For Segue
/********************************/

//Notifies the view controller that a segue is about to be performed. Do any additional setup before going to the next view.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toWebView"]) {
        
        WebViewViewController *webViewViewController = [[WebViewViewController alloc] init];
        webViewViewController = segue.destinationViewController;
    
        if (selectedIndexPath.row == 0 && selectedIndexPath.section == 2) {
            webViewViewController.titleText = @"Facebook";
            webViewViewController.url = FACEBOOK_URL;
            webViewViewController.showClose = NO;
        }
        else if (selectedIndexPath.row == 1 && selectedIndexPath.section == 2) {
            webViewViewController.titleText = @"Twitter";
            webViewViewController.url = TWITTER_URL;
            webViewViewController.showClose = NO;
        }
        else if (selectedIndexPath.row == 2 && selectedIndexPath.section == 2) {
            webViewViewController.titleText = @"Tumblr";
            webViewViewController.url = TUMBLR_URL;
            webViewViewController.showClose = NO;
        }
        else if (selectedIndexPath.row == 0 && selectedIndexPath.section == 3) {
            webViewViewController.titleText = @"Terms of Use";
            webViewViewController.url = TERMS_URL;
            webViewViewController.showClose = NO;
        }
        else if (selectedIndexPath.row == 1 && selectedIndexPath.section == 3) {
            webViewViewController.titleText = @"Privacy Policy";
            webViewViewController.url = PRIVACY_URL;
            webViewViewController.showClose = NO;
        }
        
    }
}

@end
