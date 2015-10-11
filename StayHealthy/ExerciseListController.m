//
//  ExerciseListController.h
//  StayHealthy
//
//  Created by Student on 3/23/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//

#import "ExerciseListController.h"

@interface ExerciseListController ()

@end

@implementation ExerciseListController


/********************************/
#pragma mark View Loading Methods
/********************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //Set the title for the page to the muscle.
    self.title = self.viewTitle;

    
    //Sets the NSUserDefault and displays the TSMessage when page is loaded for the first time.
    [CommonSetUpOperations setFirstViewTSMessage:@"FirstViewForPage" viewController:self message:@"Now that you have chosen a muscle and a exercise type you can view all the exercises. You can toggle between grid and list view with the button in the top right. Tap this message to dismiss."];
    
    //Get the exercise data.
    exerciseData = [[SHDataHandler getInstance] performExerciseStatement:self.exerciseQuery];;
    
    //If the exercise data is nothing then show the message declaring that.
    if (exerciseData.count == 0)
        [CommonSetUpOperations performTSMessage:@"No Exercises Were Found" message:nil viewController:self canBeDismissedByUser:YES duration:60];
    
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

/***************************************************/
#pragma mark UITableView Delegate/Datasource Methods
/***************************************************/

//Sets the number of rows in the tableview.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Equal to the number of exercises for this search.
    return [exerciseData count];
}

//determine everything for each cell, at each indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //write the cell identifier.
    static NSString *simpleTableIdentifier = @"exerciseTableCell";

    //Set the cell identifier.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    /*
    //Get the exercise objects.
    exerciseObject *exercise = [self.exerciseData objectAtIndex:indexPath.row];
    
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
    */
    //Set the selected cell background.
    [CommonSetUpOperations tableViewSelectionColorSet:cell];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //deselect the cell when you select it, makes selected background view disappear.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*****************************/
#pragma mark Prepare For Segue
/*****************************/

//What happens just before a segue is performed.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

        if ([segue.identifier isEqualToString:@"detail"]) {
            /*
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            exerciseObject *exercise = [self.exerciseData objectAtIndex:indexPath.row];
            ExerciseDetailViewController *destViewController = segue.destinationViewController;
             */
        }
    
   }


/*************************************/
#pragma mark ViewWillDisappear Methods
/*************************************/

//Dismiss all TSMessages when the view disappears.
-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}

@end
