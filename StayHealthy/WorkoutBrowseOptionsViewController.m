//
//  WorkoutBrowseOptionsViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-25.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import "WorkoutBrowseOptionsViewController.h"

@interface WorkoutBrowseOptionsViewController ()

@end

@implementation WorkoutBrowseOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = self.viewTitle;
    
      self.automaticallyAdjustsScrollViewInsets = NO;
    
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.browseOptionsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self setTableViewArray];
}

- (void)setTableViewArray {
    switch (self.passedOption) {
        case targetSports:
            tableViewArray = [CommonUtilities returnGeneralPlist][@"sports2"];
            break;
        case targetMuscles:
            tableViewArray = [CommonUtilities returnGeneralPlist][@"muscleList"];
            break;
        case workoutEquipment:
            tableViewArray = [CommonUtilities returnGeneralPlist][@"workoutEquipment"];
            break;
        case workoutType:
            tableViewArray = [CommonUtilities returnGeneralPlist][@"workoutType"];
            break;
        case workoutDifficulty:
            tableViewArray = [CommonUtilities returnGeneralPlist][@"workoutDifficulty"];
            break;
        default:
            break;
    }
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
    return [tableViewArray count];
}

//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Configures the cells at a specific indexPath.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    //Define the identifier.
    static NSString *muscleSelectionCellIdentifier = @"cell";
    
    //Create reference to the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleSelectionCellIdentifier];
    
    cell.textLabel.text = [tableViewArray objectAtIndex:indexPath.row];
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
    [self performSegueWithIdentifier:@"list" sender:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"list"]) {
        WorkoutListViewController *listView = [[WorkoutListViewController alloc] init];
        listView = segue.destinationViewController;
         NSIndexPath *indexPath = [self.browseOptionsTableView indexPathForSelectedRow];
        
         UITableViewCell *cell = [self.browseOptionsTableView cellForRowAtIndexPath:indexPath];
        
        switch (self.passedOption) {
            case targetSports:
                listView.workoutQuery = [NSString stringWithFormat:@"SELECT * FROM StayHealthyWorkouts WHERE workoutTargetSports LIKE '%%%@%%'",cell.textLabel.text];
                listView.viewTitle = [NSString stringWithFormat:@"%@ Workouts",cell.textLabel.text];
                break;
            case targetMuscles:
                listView.workoutQuery = [NSString stringWithFormat:@"SELECT * FROM StayHealthyWorkouts WHERE workoutTargetMuscles LIKE '%%%@%%'",cell.textLabel.text];
                listView.viewTitle = [NSString stringWithFormat:@"%@ Workouts",cell.textLabel.text];
                break;
            case workoutEquipment:
                listView.workoutQuery = [NSString stringWithFormat:@"SELECT * FROM StayHealthyWorkouts WHERE workoutEquipment LIKE '%%%@%%'",cell.textLabel.text];
                listView.viewTitle = [NSString stringWithFormat:@"%@ Workouts",cell.textLabel.text];
                break;
            case workoutType:
                listView.workoutQuery = [NSString stringWithFormat:@"SELECT * FROM StayHealthyWorkouts WHERE workoutType LIKE '%%%@%%'",cell.textLabel.text];
                listView.viewTitle = [NSString stringWithFormat:@"%@ Workouts",cell.textLabel.text];
                break;
            case workoutDifficulty:
                listView.workoutQuery = [NSString stringWithFormat:@"SELECT * FROM StayHealthyWorkouts WHERE workoutDifficulty LIKE '%@'",cell.textLabel.text];
                listView.viewTitle = [NSString stringWithFormat:@"%@ Workouts",cell.textLabel.text];
                break;
            default:
                break;
        }

        
    }
}


@end
