//
//  AboutTableViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-16.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import "AboutTableViewController.h"

@interface AboutTableViewController ()

@end

@implementation AboutTableViewController

/**********************************/
#pragma mark - View Loading Methods
/**********************************/

//What happens right before the view loads.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set title of view controller.
    self.title = @"About";
    
    //Users cannot interact or scroll with the table view.
    self.tableView.userInteractionEnabled = NO;
    self.tableView.scrollEnabled = NO;
    
    //Fill the arrays to be displayed in the tableView.
    aboutArray = @[@"App Version",@"App Build",@"Database Version"];
    aboutArrayDetail = @[[CommonUtilities shortAppVersionNumber], [CommonUtilities hexBuildNumber], [CommonUtilities installedDatabaseVersion]];
}

/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the number of sections for the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Returns the number of rows in a section for the tableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [aboutArray count];
}

//Cell for row at index path for the tableViews.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Define the identifier.
    static NSString *aboutCell = @"aboutCell";
    
    //Create reference to the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aboutCell];
    
    //If the cell can't be found then just create one.
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aboutCell];
    }

    //Set the title label.
    cell.textLabel.text = [aboutArray objectAtIndex:indexPath.row];
    //Set the detail text label.
    cell.detailTextLabel.text = [aboutArrayDetail objectAtIndex:indexPath.row];
    
    //Return the cell.
    return cell;
}

@end
