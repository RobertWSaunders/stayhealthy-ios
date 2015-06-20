//
//  workoutOptionsViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-03-27.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import "workoutOptionsViewController.h"
#import "FlatUIKit.h"

@implementation workoutOptionsViewController

-(void)viewDidLoad {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.title = self.titleText;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_arrayForTableView count];;
}


//Design and fill the tableview cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Define the identifier.
    static NSString *muscleItem = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleItem];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:muscleItem];
    }
    
    cell.textLabel.text = [_arrayForTableView objectAtIndex:indexPath.row];
    
    //Stlying the cells.
    cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:17];
    cell.textLabel.textColor = [UIColor peterRiverColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //Then the background color view.
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor cloudsColor];
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];
    
    return cell;
}

//Controls what happens when a user presses a cell, i.e. a SIAlertview pops up.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self performSegueWithIdentifier:@"toDetail" sender:nil];
    
    //Then deselect the row once complete touch/select.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
WorkoutsSearchedViewController *destViewController = segue.destinationViewController;
destViewController.titleText =  generatedTitleForPopup;
NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
UITableViewCell *Cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
destViewController.query = [self buildWorkoutQueryForBrowseScreen:Cell.textLabel.text type:self.type];
    destViewController.titleText = [NSString stringWithFormat:@"%@ Workouts", Cell.textLabel.text];
}

-(NSString*)buildWorkoutQueryForBrowseScreen:(NSString*)selectedValue type:(NSString*)typeOfSelection{
    NSString *workoutQuery = @"";
    workoutQuery = [NSString stringWithFormat:@"SELECT * FROM PrebuiltWorkouts WHERE %@ LIKE '%%%@%%'",typeOfSelection,selectedValue];
    NSLog(@"%@",workoutQuery);
    return workoutQuery;
}

@end
