//
//  SettingsViewController.m
//  StayHealthy
//
//  Created by Student on 1/5/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
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
    return 48;
}

//Returns the number of sections for the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

//Returns the number of rows in each section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [generalSettings count];
    }
    else if (section == 1) {
        return [feedbackSettings count];
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
        cell.textLabel.text = [legalSettings objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[legalSettingsImages objectAtIndex:indexPath.row]];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //Set the text color and the font for the cell textLabels.
    cell.textLabel.textColor = JOURNAL_COLOR;
    cell.textLabel.font = TABLE_VIEW_TITLE_FONT;
    
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
        return 20;
    }
        return 5;
}

//Returns the title for the header in the tableView.
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"GENERAL";
    }
    else if (section == 1) {
        return @"SUPPORT";
    }
    else {
        return @"LEGAL";
    }

    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(15, 18, self.view.frame.size.width, 20);
    myLabel.font = TABLE_VIEW_SECTION_TITLE_FONT;
    myLabel.textColor = DARK_GRAY_COLOR;
    myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:myLabel];
    
    return headerView;
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
        [self performSegueWithIdentifier:@"preferences" sender:nil];
    }
    else if (indexPath.section == 1 && indexPath.row == 0) {
        [self performSegueWithIdentifier:@"helpCenter" sender:nil];
    }
    else if (indexPath.section == 1 && indexPath.row == 1) {
        [self performSegueWithIdentifier:@"feedbackCenter" sender:nil];
    }
    else if (indexPath.section == 2 || (indexPath.section == 3 && indexPath.row != 2)) {
        [self performSegueWithIdentifier:@"toWebView" sender:nil];
    }
    
    //Deselect the tableView cell once the user has selected.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/****************************/
#pragma mark - Helper Methods
/****************************/

//Fills the arrays for the sections in the tableView.
-(void)setTableViewData {
    generalSettings = [NSArray arrayWithObjects:@"About", @"Preferences", nil];
    generalSettingsImages = [NSArray arrayWithObjects:@"About.png", @"Preferences.png", nil];
    feedbackSettings = [NSArray arrayWithObjects:@"Help Center", @"Feedback Center", nil];
    feedbackSettingsImages = [NSArray arrayWithObjects:@"HelpCenter.png", @"FeedbackCenter.png", nil];
    legalSettings = [NSArray arrayWithObjects:@"Terms of Use", @"Privacy Policy", nil];
    legalSettingsImages = [NSArray arrayWithObjects:@"TermsUse.png", @"PrivacyPolicy.png", nil];
}

/**********************/
#pragma mark - Actions
/**********************/

//What happens when the user presses close.
- (IBAction)closePressed:(id)sender {
    //Dismiss the view controller.
    [self dismissViewControllerAnimated:YES completion:nil];
}

/********************************/
#pragma mark - Prepare For Segue
/********************************/

//Notifies the view controller that a segue is about to be performed. Do any additional setup before going to the next view.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //Load specific content onto the webview depending on what button they press on.
    if ([segue.identifier isEqualToString:@"toWebView"]) {
        WebViewViewController *webViewViewController = [[WebViewViewController alloc] init];
        webViewViewController = segue.destinationViewController;
        if (selectedIndexPath.row == 0 && selectedIndexPath.section == 2) {
            webViewViewController.titleText = @"Terms of Use";
            webViewViewController.url = TERMS_URL;
            webViewViewController.showClose = NO;
            webViewViewController.navigationEnabled = NO;
        }
        else if (selectedIndexPath.row == 1 && selectedIndexPath.section == 2) {
            webViewViewController.titleText = @"Privacy Policy";
            webViewViewController.url = PRIVACY_URL;
            webViewViewController.showClose = NO;
            webViewViewController.navigationEnabled = NO;
        }
    }
}

//Handles anything we need to clear or reset when the view is about to disappear.
-(void)viewWillDisappear:(BOOL)animated {
    //Dismiss any outstaning notifications.
    [TSMessage dismissActiveNotification];
}

@end
