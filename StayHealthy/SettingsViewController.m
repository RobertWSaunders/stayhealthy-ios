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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Style the alerts.
    [CommonSetUpOperations styleAlertView];
    
    //Fill the arrays.
    //Fill the general settings array with the strings.
    generalSettings = [NSArray arrayWithObjects:@"Preferences",@"Backup/Restore Data", nil];
    //Fill the questions and feedback array with strings.
    questionsFeedback = [NSArray arrayWithObjects:@"Support", @"Send Feedback",nil];
    //Fill the legal array with strings.
    legalTerms = [NSArray arrayWithObjects:@"Privacy Policy", @"Terms of Service", nil];
    
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

//Returns the height of the section headers.
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

//Returns the height of the footers.
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

//Returns the number of rows in each section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [generalSettings count];
    }
    else if (section == 1) {
        return [questionsFeedback count];
    }
    else if (section == 2) {
        return [legalTerms count];
    }
    else {
        return 0;
    }
}

//Cell for row at index path for the tableViews.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //The cell identifier for the cells in the tableView.
    static NSString *CellIdentifier = @"settingsCell";
    
    //Create reference to the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //If the cell is equal to nil than create one.
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //Now set the text for the cells dependant on the section.
    if (indexPath.section == 0) {
        cell.textLabel.text = [generalSettings objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.section == 1) {
        cell.textLabel.text = [questionsFeedback objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.section == 2) {
        cell.textLabel.text = [legalTerms objectAtIndex:indexPath.row];
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

//Returns the title for the header in the tableView.
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"General Settings";
    }
    else if (section == 1) {
        return @"Support/Feedback";
    }
    else {
        return @"Legal";
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"preferences" sender:nil];
    }
    /*
    if (indexPath.section == 0 && indexPath.row == 0) {
        if ([MFMailComposeViewController canSendMail]){
            NSArray *recipient = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"stayhealthyapp@gmail.com"], nil];
            MFMailComposeViewController* mailViewController = [[MFMailComposeViewController alloc] init];
            [mailViewController setMailComposeDelegate: self];
            [mailViewController setSubject:@"StayHealthy Feedback"];
            [mailViewController setMessageBody:@""
                                        isHTML:NO];
            [mailViewController setToRecipients:recipient];

            [self presentViewController: mailViewController
                               animated: YES
                             completion: nil];
        }
        else{
            [CommonSetUpOperations performTSMessage:@"Unable to send email." message:@"Cannot send email because you haven't set up your information in the mail app." viewController:self canBeDismissedByUser:YES duration:6];
            
        }
    }
     */
    //Deselect the tableView cell once the user has selected.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
        {
            [CommonSetUpOperations performTSMessage:@"Email Cancelled" message:nil viewController:self canBeDismissedByUser:YES duration:6];
        }
            break;
        case MFMailComposeResultSent:
        {
            [CommonSetUpOperations performTSMessage:@"Email Sent" message:nil viewController:self canBeDismissedByUser:YES duration:6];
        }
            break;
        case MFMailComposeResultFailed:
        {
            [CommonSetUpOperations performTSMessage:@"Email Failed" message:nil viewController:self canBeDismissedByUser:YES duration:6];
        }
            break;
        case MFMailComposeResultSaved:
        {
            [CommonSetUpOperations performTSMessage:@"Email Saved" message:nil viewController:self canBeDismissedByUser:YES duration:6];
        }
            break;
        default:
            break;
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    /*
    if ([segue.identifier isEqualToString:@"facebook"]) {
        WebviewViewController *dest = segue.destinationViewController;
        dest.url = @"https://www.facebook.com/pages/StayHealthy/216493755204288?ref=hl";
        dest.titleText = @"Facebook";
    }
    if ([segue.identifier isEqualToString:@"twitter"]) {
        WebviewViewController *dest = segue.destinationViewController;
        dest.url = @"https://twitter.com/stayhealthyapp";
        dest.titleText = @"Twitter";
    }
     */
}


@end
