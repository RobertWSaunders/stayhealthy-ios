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
    
    //Set the background for both the navigation controller so that we don't get the weird dark tinges sometimes.
    //Set navigation controller background to white.
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    //Set tabBar controller background to white.
    self.tabBarController.view.backgroundColor = [UIColor whiteColor];
    
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
    return 4;
}

//Returns the number of rows in each section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [generalSettings count];
    }
    else if (section == 1) {
        return [feedbackSettings count];
    }
    else if (section == 2) {
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
   if (indexPath.section == 0) {
        cell.textLabel.text = [generalSettings objectAtIndex:indexPath.row];
       cell.imageView.image = [UIImage imageNamed:[generalSettingsImages objectAtIndex:indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.section == 1) {
        cell.textLabel.text = [feedbackSettings objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[feedbackSettingsImages objectAtIndex:indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.section == 2) {
        cell.textLabel.text = [connectSettings objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[connectSettingsImages objectAtIndex:indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if (indexPath.section == 3) {
        cell.textLabel.text = [legalSettings objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[legalSettingsImages objectAtIndex:indexPath.row]];
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
    if (section == 3) {
        return 20;
    }
        return 5;
}

//Returns the title for the header in the tableView.
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"General";
    }
    else if (section == 1) {
        return @"Support";
    }
    else if (section == 2) {
        return @"Connect";
    }
    else {
        return @"Legal";
    }

    return nil;
}

//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

//What happens when a user presses on a tableViewCell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    selectedIndexPath = indexPath;
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"about" sender:nil];
    }
    else if (indexPath.section == 0 && indexPath.row == 1) {
        [self performSegueWithIdentifier:@"database" sender:nil];
    }
    else if (indexPath.section == 0 && indexPath.row == 2) {
        [self performSegueWithIdentifier:@"preferences" sender:nil];
    }
    else if (indexPath.section == 1 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"helpcenter" sender:nil];
    }
    else if (indexPath.section == 1 && indexPath.row == 1) {
        [self performSegueWithIdentifier:@"feedbackcenter" sender:nil];
    }
    else if (indexPath.section == 2 || (indexPath.section == 3 && indexPath.row != 2)) {
        [self performSegueWithIdentifier:@"toWebView" sender:nil];
    }
    else if (indexPath.section == 3 && indexPath.row == 2) {
        [self performSegueWithIdentifier:@"acknowledgments" sender:nil];
    }
    
    //Deselect the tableView cell once the user has selected.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/****************************/
#pragma mark - Helper Methods
/****************************/

//Fills the arrays for the sections in the tableView.
-(void)setTableViewData {
    generalSettings = [NSArray arrayWithObjects:@"About", @"Database Update", @"Preferences", nil];
    generalSettingsImages = [NSArray arrayWithObjects:@"About.png", @"DatabaseUpdate.png", @"Preferences.png", nil];
    
    feedbackSettings = [NSArray arrayWithObjects:@"Help Center", @"Feedback Center", nil];
    feedbackSettingsImages = [NSArray arrayWithObjects:@"HelpCenter.png", @"FeedbackCenter.png", nil];
    
    connectSettings = [NSArray arrayWithObjects:@"Facebook",@"Twitter",@"Tumblr", nil];
    connectSettingsImages = [NSArray arrayWithObjects:@"Facebook.png",@"Twitter.png",@"Tumblr.png", nil];
    
    legalSettings = [NSArray arrayWithObjects:@"Terms of Use", @"Privacy Policy", @"Acknowledgments", nil];
    legalSettingsImages = [NSArray arrayWithObjects:@"TermsUse.png", @"PrivacyPolicy.png", @"Acknowledgments.png", nil];
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
