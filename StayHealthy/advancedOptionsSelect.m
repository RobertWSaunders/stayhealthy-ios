//
//  advancedOptionsSelect.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-03-21.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import "advancedOptionsSelect.h"

@implementation advancedOptionsSelect

/*************************************************/
#pragma mark viewDidLoad Method and viewWillAppear
/*************************************************/

-(void)viewDidLoad {
    //Sets the navigation buttons in the navigation bar.
    [self setNavigationButtons];
}

-(void)viewWillAppear:(BOOL)animated {
    //Set the title for the view controller.
    self.title = self.titleText;
    //Make sure the navigation bar is displayed.
    self.navigationController.navigationBarHidden = NO;
    //Get rid of the unneeded tableview divider lines.
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

/**************************************/
#pragma mark TableView Delegate Methods
/**************************************/

//Sets the number of rows in the tableview.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //equal to the amount of items in the array which is passed to controller.
    return [self.arrayForTableView count];
}

//Design and fill the tableview cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Define the identifier.
    static NSString *muscleItem = @"cell";
    
    //Set the cell identifier.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleItem];
    
    //Set the text label equal to the items in the array which is passed.
    cell.textLabel.text = [self.arrayForTableView objectAtIndex:indexPath.row];
    
    //Set the font and text color of the text label.
    cell.textLabel.font = tableViewTitleTextFont;
    cell.textLabel.textColor = STAYHEALTHY_BLUE;
    
    //Set the selected background color.
    [CommonSetUpOperations tableViewSelectionColorSet:cell];
    
    return cell;
}

//Controls what happens when a user presses a cell, i.e. a SIAlertview pops up.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Dismiss the view.
    [self dismissViewControllerAnimated:YES completion:nil];
    //Fire the delegat method so that the next view can be updated with the new results.
    [self.delegate done:[self.arrayForTableView objectAtIndex:indexPath.row] num:&(_num)];
    //Then deselect the row once complete touch/select.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/***********************************************/
#pragma mark Utility Methods and Action Methods
/***********************************************/

//Set the navigation buttons making sure that they display in the navigation button.
- (void)setNavigationButtons {
    //Create dictionary and set font and display the buttons.
    NSDictionary *attrDict = [NSDictionary dictionaryWithObject:STAYHEALTHY_NAVBARBUTTONFONT forKey:NSFontAttributeName];
    [[UIBarButtonItem appearance] setTitleTextAttributes: attrDict
                                                forState: UIControlStateDisabled];
    [[UIBarButtonItem appearance] setTitleTextAttributes: attrDict
                                                forState: UIControlStateNormal];
}

//What happens when the cancel button is pressed.
- (IBAction)cancelPressed:(id)sender {
    //Dismiss the view.
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
