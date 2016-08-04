//
//  SelectionViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2016-05-18.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "SelectionViewController.h"

@interface SelectionViewController ()

@end

@implementation SelectionViewController

/********************************/
#pragma mark View Loading Methods
/********************************/

//Called when the view loads.
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectionTableView.alwaysBounceVertical = NO;
    
    //Don't adjust the scroll view insets.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

//Called when the view appears.
- (void)viewWillAppear:(BOOL)animated {
    //Set the title for the view controller.
    self.title = self.titleText;
    //Make sure the navigation bar is displayed.
    self.navigationController.navigationBarHidden = NO;
    //Get rid of the unneeded tableview divider lines.
    self.selectionTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    //If it is rendered in read-only mode.
    if (self.readOnlyMode) {
        //Disallow selection.
        self.selectionTableView.allowsSelection = NO;
    }
}

/*****************************************************/
#pragma mark TableView Delegate and Datasource Methods
/*****************************************************/

//Returns the height of the cells inside the tableView.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48.0f;
}

//Sets the number of rows in the tableview.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.selectionArray count];
}

//Design and fill the tableview cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Define the identifier.
    static NSString *selectionCellIdentifier = @"selectionCellIdentifier";
    
    //Set the cell identifier.
    SelectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectionCellIdentifier];
    
    //Set the text label equal to the items in the array which is passed.
    cell.label.text = [self.selectionArray objectAtIndex:indexPath.row];
    
    //Set the font and text color of the text label.
    cell.label.font = TABLE_VIEW_TITLE_FONT;
    
    //Set the accessory type dependant on whether it is in selected cells array.
    if (!self.readOnlyMode && [self.selectedItems containsObject:[NSString stringWithFormat:@"%@",cell.label.text]]) {
        cell.label.textColor = [CommonUtilities returnModuleColor:self.moduleRender];
        cell.accessoryImage.image = [UIImage imageNamed:@"CheckmarkJ.png"];
    }
    else {
        cell.label.textColor = LIGHT_GRAY_COLOR;
        cell.accessoryImage.image = nil;
    }
    
    //Set the selected background color.
    
    
    return cell;
}

//Controls what happens when a user presses a cell, i.e. a SIAlertview pops up.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SelectionTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (!self.readOnlyMode) {
        if (self.multipleSelectionMode) {
            if ([cell.accessoryImage.image isEqual:[UIImage imageNamed:@"Checkmark.png"]]) {
                [self.selectedItems removeObject:[self.selectionArray objectAtIndex:indexPath.row]];
                cell.accessoryImage.image = nil;
            } else {
                [self.selectedItems addObject:[self.selectionArray objectAtIndex:indexPath.row]];
            }
        }
        else {
            self.selectedItems = [[NSMutableArray alloc] init];
            [self.selectedItems addObject:[self.selectionArray objectAtIndex:indexPath.row]];
            [self.selectionTableView reloadData];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*****************************/
#pragma mark Prepare For Segue
/*****************************/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}

/************************************/
#pragma mark View Terminating Methods
/************************************/

- (void)viewWillDisappear:(BOOL)animated {
    [self.selectionDelegate selectedItemsWithCount:self.selectedItems indexPath:self.selectedIndexPath passedArrayCount:[self.selectionArray count]];

}

@end
