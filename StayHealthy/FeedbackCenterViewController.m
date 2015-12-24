//
//  FeedbackCenterViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-16.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import "FeedbackCenterViewController.h"

@interface FeedbackCenterViewController ()

@end

@implementation FeedbackCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Feedback Center";
    
    feedbackItems = @[@"Email Feedback"];
    feedbackItemsImages = @[@"EmailFeedback.png"];
    
    self.feedbackCenterTableView.scrollEnabled = NO;
    
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
    return [feedbackItems count];
}

//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Configures the cells at a specific indexPath.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Define the identifier.
    static NSString *muscleSelectionCellIdentifier = @"feedbackCell";
    
    //Create reference to the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleSelectionCellIdentifier];
    
    cell.textLabel.text = [feedbackItems objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[feedbackItemsImages objectAtIndex:indexPath.row]];
    cell.textLabel.font = tableViewTitleTextFont;
    cell.textLabel.textColor = STAYHEALTHY_BLUE;
    
     [CommonSetUpOperations tableViewSelectionColorSet:cell];
    
    //Return the cell.
    return cell;
}



//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

//What happens when the user selects a cell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self showEmailScreen:@"StayHealthy Feedback" email:STAYHEALTHY_FEEDBACK_EMAIL];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//Returns the title for footers in the tableView.
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {

        return @"Your feedback is what makes StayHealthy better. Get in contact with us to tell us about your experience using our app. Feel free to tell us about problems, features you think would be cool, design thoughts and pretty much anything else. We really love connecting with our users and learning their needs to make the user experience better. Thank you so much in advance and we will be sure to respond back to you as soon as we possibly can!";
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
