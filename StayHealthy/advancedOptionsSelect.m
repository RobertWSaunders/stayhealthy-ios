//
//  advancedOptionsSelect.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-03-21.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import "advancedOptionsSelect.h"

@implementation advancedOptionsSelect

/*********************************/
#pragma mark View Loading Methods
/*********************************/

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

- (void)viewWillDisappear:(BOOL)animated {
    [self.delegate userHasSelected:self.selectedCells indexPath:self.indexPathPassed passedArrayCount:[self.arrayForTableView count]];
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
    
    //Set the accessory type dependant on whether it is in selected cells array.
    if ([self.selectedCells containsObject:[NSString stringWithFormat:@"%@",cell.textLabel.text]]) {
        //Make the checkmark show up.
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else {
        //Make no checkmark.
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    //Set the selected background color.
    [CommonSetUpOperations tableViewSelectionColorSet:cell];
    
    return cell;
}

//Controls what happens when a user presses a cell, i.e. a SIAlertview pops up.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        [self.selectedCells removeObject:[NSString stringWithFormat:@"%@",cell.textLabel.text]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        [self.selectedCells addObject:[NSString stringWithFormat:@"%@",cell.textLabel.text]];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    //Tell the user that it's likely to lead to nothing in the search if they choose two different primary or secondary muscles, we only tell them once though, just so we don't be annoying.
    if (self.selectedCells.count > 1) {
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"advancedOptionsSelect-FirstSelection"]) {
            if (self.typeOfExerciseAttribute == primaryMuscle) {
                [CommonSetUpOperations performTSMessage:@"It's very rare for an exercise to have multiple primary muscles, just saying! But give it a try if you want!" message:nil viewController:self canBeDismissedByUser:YES duration:7];
            }
            else if (self.typeOfExerciseAttribute ==  secondaryMuscle) {
                [CommonSetUpOperations performTSMessage:@"It's very rare for an exercise to have multiple secondary muscle, just saying! But give it a try if you want!" message:nil viewController:self canBeDismissedByUser:YES duration:7];
            }
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"advancedOptionsSelect-FirstSelection"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    
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

@end
