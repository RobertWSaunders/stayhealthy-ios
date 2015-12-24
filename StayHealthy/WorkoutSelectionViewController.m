//
//  WorkoutSelectionViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-22.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import "WorkoutSelectionViewController.h"

@interface WorkoutSelectionViewController ()

@end

@implementation WorkoutSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.browseScroller setScrollEnabled:YES];
    [self.browseOptionsTableView setScrollEnabled:NO];
    
    browseOptions = @[@"Sport Specific",@"Muscle Specific",@"Equipment Specific",@"Type Specific",@"Difficulty Specific"];
    browseOptionsImages = @[@"Sports.png",@"Muscles.png",@"Equipment.png",@"WorkoutType.png",@"Difficulty.png"];
    
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;
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
    if (tableView == self.yourWorkoutsTableView) {
        return 95.0f;
    }
    else {
        return 44.0f;
    }
    
}

//Returns the number of rows that should be displayed in the tableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.yourWorkoutsTableView) {
        return [customWorkouts count];
    }
    else {
        return [browseOptions count];
    }
}

//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Configures the cells at a specific indexPath.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.yourWorkoutsTableView) {
        //Define the identifier.
        static NSString *muscleSelectionCellIdentifier = @"workoutCell";
        
        //Create reference to the cell.
        WorkoutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleSelectionCellIdentifier];
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
        
        //Return the cell.
        return cell;

    }
    else {
        //Define the identifier.
        static NSString *muscleSelectionCellIdentifier = @"browseOptionCell";
        
        //Create reference to the cell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleSelectionCellIdentifier];
        
        cell.textLabel.text = [browseOptions objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[browseOptionsImages objectAtIndex:indexPath.row]];
        
        cell.textLabel.textColor = STAYHEALTHY_BLUE;
        cell.textLabel.font = tableViewTitleTextFont;
        
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
        //Return the cell.
        return cell;

    }
}


//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

//What happens when the user selects a cell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.browseOptionsTableView) {
        [self performSegueWithIdentifier:@"browseOptions" sender:nil];
    }
       [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"advancedSearch"]) {
        UINavigationController *navController = segue.destinationViewController;
        WorkoutsAdvancedSearchViewController *advancedSearchController = [[WorkoutsAdvancedSearchViewController alloc] init];
        advancedSearchController = navController.viewControllers[0];
        
    }
    else if ([segue.identifier isEqualToString:@"createWorkout"]) {
        UINavigationController *navController = segue.destinationViewController;
        WorkoutCreateViewController *createWorkoutController = [[WorkoutCreateViewController alloc] init];
        createWorkoutController = navController.viewControllers[0];
    }
    else if ([segue.identifier isEqualToString:@"browseOptions"]) {
        WorkoutBrowseOptionsViewController *browseOptionsView = [[WorkoutBrowseOptionsViewController alloc] init];
        NSIndexPath *indexPath = [self.browseOptionsTableView indexPathForSelectedRow];
        browseOptionsView = segue.destinationViewController;
        
        if (indexPath.row == 0) {
            browseOptionsView.passedOption = targetSports;
            browseOptionsView.viewTitle = @"Target Sport";
        }
        else if (indexPath.row == 1) {
            browseOptionsView.passedOption = targetMuscles;
            browseOptionsView.viewTitle = @"Target Muscle";
        }
        else if (indexPath.row == 2) {
            browseOptionsView.passedOption = workoutEquipment;
            browseOptionsView.viewTitle = @"Workout Equipment";
        }
        else if (indexPath.row == 3) {
            browseOptionsView.passedOption = workoutType;
            browseOptionsView.viewTitle = @"Workout Type";
        }
        else {
            browseOptionsView.passedOption = workoutDifficulty;
            browseOptionsView.viewTitle = @"Workout Difficulty";
        }
    }
}


- (IBAction)segmentValueChanged:(UISegmentedControl*)sender {
    if (sender.selectedSegmentIndex == 0) {
        self.browseWorkoutsView.hidden = NO;
        self.yourWorkoutsView.hidden = YES;
    }
    else {
        self.browseWorkoutsView.hidden = YES;
        self.yourWorkoutsView.hidden = NO;
    }
}

- (IBAction)addCustomWorkout:(id)sender {
    [self performSegueWithIdentifier:@"createWorkout" sender:nil];
}

- (IBAction)workoutSearch:(id)sender {
    [self performSegueWithIdentifier:@"advancedSearch" sender:nil];
}

@end
