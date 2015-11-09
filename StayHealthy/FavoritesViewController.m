//
//  FavoritesViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-10-17.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import "FavoritesViewController.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

/**********************************/
#pragma mark - View Loading Methods
/**********************************/

//Perform any set up for the view once it has loaded.
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     //self.favoritesTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

     [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_FAVORITES  viewController:self message:@"Here you can view all of your favorite exercises, you can toggle between the different types of exercises with the control just under the top bar!"];
}

//Perform any set up for the view once it has loaded.
- (void)viewWillAppear:(BOOL)animated {
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        [self fetchLikedExercises:strength];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 1) {
        [self fetchLikedExercises:stretching];
    }
    else if (self.segmentedControl.selectedSegmentIndex == 2) {
        [self fetchLikedExercises:warmup];
    }
    else {
        [self fetchLikedExercises:strength];
    }
    
}

/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the height of the cells inside the tableView.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    return 85.0f;
    
}

//Returns the number of rows that should be displayed in the tableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [favoritesData count];
    
}

//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
    
}

//Configures the cells at a specific indexPath.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        static NSString *recentlyViewedCellIdentifier = @"exerciseTableCell";
        
        //Create the reference for the cell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recentlyViewedCellIdentifier];
        
        //If the cell can't be found then just create one.
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:recentlyViewedCellIdentifier];
        }
        
        SHExercise *exercise = [favoritesData objectAtIndex:indexPath.row];
        
        //Set the exercise name and style the label.
        UILabel *exerciseName = (UILabel *)[cell viewWithTag:101];
        exerciseName.font = tableViewTitleTextFont;
        exerciseName.text = exercise.exerciseName;
        exerciseName.textColor = STAYHEALTHY_BLUE;
        
        //Set the equipment names and style the label.
        UILabel *equipment = (UILabel *)[cell viewWithTag:102];
        equipment.text = exercise.exerciseEquipment;
        equipment.font = tableViewUnderTitleTextFont;
        equipment.textColor = STAYHEALTHY_LIGHTGRAYCOLOR;
        
        //Set the equipment default and set the style.
        UILabel *equipmentStandard = (UILabel *)[cell viewWithTag:10];
        equipmentStandard.font = tableViewUnderTitleTextFont;
        equipmentStandard.textColor = STAYHEALTHY_LIGHTGRAYCOLOR;
        NSString *trimmedString = [exercise.exerciseEquipment stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        if ([trimmedString isEqualToString:@"null"])
            equipment.text = @"No Equipment";
        else
            equipment.text = exercise.exerciseEquipment;
        
        //Set the difficulty and set the style.
        UILabel *difficulty = (UILabel *)[cell viewWithTag:103];
        difficulty.text = exercise.exerciseDifficulty;
        difficulty.font = tableViewUnderTitleTextFont;
        difficulty.textColor = [CommonSetUpOperations determineDifficultyColor:exercise.exerciseDifficulty];
        
        //Set the difficulty default and set the style.
        UILabel *difficultyStandard = (UILabel *)[cell viewWithTag:11];
        difficultyStandard.font = tableViewUnderTitleTextFont;
        difficultyStandard.textColor = STAYHEALTHY_LIGHTGRAYCOLOR;
        
        //Load the exercise image on the background thread.
        [CommonSetUpOperations loadImageOnBackgroundThread:(UIImageView*)[cell viewWithTag:100] image:[UIImage imageNamed:exercise.exerciseImageFile]];
        
        UIImageView *likedImage = (UIImageView*)[cell viewWithTag:27];
        if ([exercise.liked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
            likedImage.hidden = NO;
            [likedImage setImage:[UIImage imageNamed:@"likeSelectedColored.png"]];
            likedImage.tintColor = STAYHEALTHY_BLUE;
        }
        else {
            likedImage.hidden = YES;
        }
        
        UILabel *timeLabel = (UILabel*)[cell viewWithTag:14];
        timeLabel.text = [CommonUtilities calculateTime:exercise.lastViewed];
        
        //Set the selected cell background.
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
        
        //Return the cell.
        return cell;
}

//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

//What happens when the user selects a cell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
    [self performSegueWithIdentifier:@"exerciseDetail" sender:nil];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*****************************/
#pragma mark - Helper Methods
/*****************************/

//Fetched the recently viewed exercises.
- (void)fetchLikedExercises:(exerciseTypes)exerciseType {
    
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    //Fetches the recently viewed exercises, in Exercise object.
    NSArray *favoriteExercise;
    
    if (exerciseType == strength) {
        favoriteExercise = [[SHDataHandler getInstance] getStrengthLikedExercises];
    }
    else if (exerciseType == stretching) {
        favoriteExercise = [[SHDataHandler getInstance] getStretchLikedExercises];
    }
    else {
        favoriteExercise = [[SHDataHandler getInstance] getWarmupLikedExercises];
    }
    
    favoritesData = [[NSMutableArray alloc] init];
    
    //Converts Exercise object to usable SHExercise object.
    for (int i = 0; i < favoriteExercise.count; i++) {
        [favoritesData addObject:[dataHandler convertExerciseToSHExercise:[favoriteExercise objectAtIndex:i]]];
    }
    
    [self showMessage:exerciseType];
    
    //Reload the recenltyviewed tableview to display the new exercises.
    [self.favoritesTableView reloadData];
}

//Shows a TSMessage if there is no favorites.
- (void)showMessage:(exerciseTypes)exerciseType {
    if (favoritesData.count == 0) {
        NSString *type;
        if (exerciseType == strength) {
            type = @"strength";
        }
        else if (exerciseType == stretching) {
            type = @"stretching";
        }
        else if (exerciseType == warmup) {
            type = @"warmup";
        }
        else {
            type = @"workouts";
        }
       // [CommonSetUpOperations performTSMessage:[NSString stringWithFormat:@"Looks like you don't have any favorite %@ exercises!",type] message:nil viewController:self canBeDismissedByUser:YES duration:6];
    }
}

/*********************/
#pragma mark - Actions
/*********************/

//What happens when the segmented control value changes.
- (IBAction)segmentValueChanged:(UISegmentedControl*)sender {
    if (sender.selectedSegmentIndex == 0) {
        [self fetchLikedExercises:strength];
    }
    else if (sender.selectedSegmentIndex == 1) {
        [self fetchLikedExercises:stretching];
    }
    else if (sender.selectedSegmentIndex == 2) {
        [self fetchLikedExercises:warmup];
    }
    else {
        [self fetchLikedExercises:strength];
    }
    
}

/********************************/
#pragma mark - Prepare For Segue
/********************************/

//Notifies the view controller that a segue is about to be performed.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSIndexPath *indexPath = [self.favoritesTableView indexPathForSelectedRow];
    SHExercise *exercise = [favoritesData objectAtIndex:indexPath.row];
    ExerciseDetailViewController *destViewController = segue.destinationViewController;
    destViewController.exerciseToDisplay = exercise;
    destViewController.viewTitle = exercise.exerciseName;
}

@end
