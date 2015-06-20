//
//  SettingsViewController.m
//  StayHealthy
//
//  Created by Student on 1/5/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import "SettingsViewController.h"
#import "UIColor+FlatUI.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController {
    NSArray *generalSettings;
    NSArray *questionsFeedback;
    NSArray *legalTerms;
    NSArray *aboutUs;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[SIAlertView appearance] setTitleFont:[UIFont fontWithName:@"Avenir-Light" size:20]];
    [[SIAlertView appearance] setTitleColor:[UIColor peterRiverColor]];
    [[SIAlertView appearance] setMessageColor:[UIColor peterRiverColor]];
    [[SIAlertView appearance] setCornerRadius:4];
    [[SIAlertView appearance] setShadowRadius:0];
    [[SIAlertView appearance] setViewBackgroundColor:[UIColor cloudsColor]];
    [[SIAlertView appearance] setButtonColor:[UIColor peterRiverColor]];
    [[SIAlertView appearance] setDestructiveButtonColor:[UIColor peterRiverColor]];
    [[SIAlertView appearance] setCancelButtonColor:[UIColor peterRiverColor]];
    [[SIAlertView appearance] setButtonFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [[SIAlertView appearance] setMessageFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
    [[SIAlertView appearance] setMessageColor:[UIColor lightGrayColor]];

    
    self.title = @"Settings";
   
    // Set the gesture
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    // Initialize table data
    //generalSettings = [NSArray arrayWithObjects:@"Push Notifications", nil];
    // Initialize table data
    questionsFeedback = [NSArray arrayWithObjects:@"Send Feedback", nil];
    // Initialize table data
    legalTerms = [NSArray arrayWithObjects:@"Privacy Policy", @"Terms of Service", nil];
    // Initialize table data
    aboutUs = [NSArray arrayWithObjects:@"Acknowledgments",@"Like Us on Facebook", @"Follow Us on Twitter", nil];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [questionsFeedback count];
    }
    if (section == 1) {
        return [legalTerms count];
    }
    if (section == 2) {
        return [aboutUs count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    /*
    // creat uiswitch
	UISwitch *switchController = [[UISwitch alloc] initWithFrame:CGRectZero];
	[switchController setOn:YES animated:YES];
	
	NSInteger row;
	row = [indexPath row];
	switchController.tag = row;
	*/
	//[switchController addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];

    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [questionsFeedback objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        /*
        if (indexPath.row == 0) {
           // cell.accessoryView = switchController;
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
         */
    }
    
    if (indexPath.section == 1) {
        cell.textLabel.text = [legalTerms objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    
    
    if (indexPath.section == 2) {
        cell.textLabel.text = [aboutUs objectAtIndex:indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row == 0) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    /*
    if (indexPath.section == 3) {
        cell.textLabel.text = [aboutUs objectAtIndex:indexPath.row];
    }
   */
    cell.textLabel.textColor = [UIColor peterRiverColor];
    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16];
    
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor cloudsColor];
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];
    
    if ([cell.textLabel.text isEqualToString:@"Follow Us on Twitter"]) {
        cell.accessoryView = nil;
    }
    
    return cell;
}

/*
-(void) switchChanged:(id)sender{
	UISwitch *switchController = sender;
	
	if (switchController.on) {
		NSLog(@"Switch is ON");
	}
	else {
		NSLog(@"Switch is OFF");
	}
    
}
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (tableView.tag==2)
    {
        if (section == 0)
        {
            return @"Questions/Feedback";
        }
        if (section == 1)
        {
            return @"Legal";
        }
        if (section == 2)
        {
            return @"About Us";
        }
    }
    return @"";
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (tableView.tag==2) {
        if (section == 4) {
            return @"fitnessillustrated.co.uk";
        }
    }
    return @"";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && indexPath.row == 0) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"title" andMessage:@"Images provided by: fitnessillustrated.co.uk\rIcons provided by: icons8.com"];
        [alertView addButtonWithTitle:@"Done"
                                 type:SIAlertViewButtonTypeCancel
                              handler:nil];
        [alertView show];
        alertView.title = @"Acknowledgments";
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        [self performSegueWithIdentifier:@"facebook" sender:nil];
    }
        if (indexPath.section == 2 && indexPath.row == 2) {
        [self performSegueWithIdentifier:@"twitter" sender:nil];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"privacyPolicy" sender:nil];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        [self performSegueWithIdentifier:@"terms" sender:nil];
    }
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
            [CommonSetUpOperations performTSMessage:@"Unable to send email." message:@"Cannot send email because you haven't set up your information in the mail app." viewController:self];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result) {
        case MFMailComposeResultCancelled:
        {
            [CommonSetUpOperations performTSMessage:@"Email Cancelled" message:nil viewController:self];
        }
            break;
        case MFMailComposeResultSent:
        {
            [CommonSetUpOperations performTSMessage:@"Email Sent" message:nil viewController:self];
        }
            break;
        case MFMailComposeResultFailed:
        {
            [CommonSetUpOperations performTSMessage:@"Email Failed" message:nil viewController:self];
        }
            break;
        case MFMailComposeResultSaved:
        {
            [CommonSetUpOperations performTSMessage:@"Email Saved" message:nil viewController:self];
        }
            break;
        default:
            break;
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
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
}


@end
