//
//  DatabaseUpdateViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-16.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import "DatabaseUpdateViewController.h"

@interface DatabaseUpdateViewController ()

@end

@implementation DatabaseUpdateViewController

/**********************************/
#pragma mark - View Loading Methods
/**********************************/

//What happens right before the view loads.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set the title of the view controller.
    self.title = @"Database Update";
    
    self.activityIndicatorImageView.hidden = NO;
    
    //Fill the information for the tableView.
    databaseUpdatesArray = @[@"Install"];
    
    [CommonUtilities showCustomActivityIndicator:self.activityIndicatorImageView];
    
    self.databaseUpdateTableView.hidden = YES;
    
    SHDataHandler *handler = [SHDataHandler getInstance];
    
    if ([handler isDatabaseUpdate]) {
        self.databaseUpdateTableView.hidden = NO;
        [self.activityIndicatorImageView stopAnimating];
        self.activityIndicatorImageView.hidden = YES;
        
    }
    else {
        self.successFullImageView.hidden = NO;
        [self.activityIndicatorImageView stopAnimating];
        self.activityIndicatorImageView.hidden = YES;
        self.userInformationLabel.text = @"You are all up to date! In preferences you can toggle automatic database updates on or off. We want to provide you with the most up to date information possible.";
        self.userInformationLabel.textColor = [UIColor blackColor];
    }
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
    return [databaseUpdatesArray count];
}

//Cell for row at index path for the tableViews.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Define the identifier.
    static NSString *aboutCell = @"databaseUpdatesCell";
    
    //Create reference to the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aboutCell];
    
    //If the cell can't be found then just create one.
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aboutCell];
    }
    
    //Set the title label.
    cell.textLabel.text = [databaseUpdatesArray objectAtIndex:indexPath.row];
    
    //Return the cell.
    return cell;
}



@end
