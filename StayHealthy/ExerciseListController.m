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
    
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    //Set the title for the page to the muscle.
    self.title = self.viewTitle;

    
    //Sets the NSUserDefault and displays the TSMessage when page is loaded for the first time.
    [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_FIND_EXERCISE_SEARCHED  viewController:self message:@"I found these exercises for you! Here you can just choose an exercise you like the look of and I'll show you more about it."];
    
    //Get the exercise data.
    exerciseData = [[SHDataHandler getInstance] performExerciseStatement:self.exerciseQuery];
    
    //If the exercise data is nothing then show the message declaring that.
    if (exerciseData.count == 0)
        [CommonSetUpOperations performTSMessage:@"No Exercises Were Found" message:nil viewController:self canBeDismissedByUser:YES duration:60];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:exerciseFavNotification object:nil];
    
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;
}



/***************************************************/
#pragma mark UITableView Delegate/Datasource Methods
/***************************************************/

//Returns the height of the cells inside the tableView.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76.0f;
}

//Sets the number of rows in the tableview.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Equal to the number of exercises for this search.
    return [exerciseData count];
}

//determine everything for each cell, at each indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //write the cell identifier.
    static NSString *simpleTableIdentifier = @"exerciseTableCell";

    //Create the reference for the cell.
    ExerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    //If the cell can't be found then just create one.
    if (cell == nil) {
        cell = [[ExerciseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    SHExercise *exercise = [self updateExerciseWithUserData:[exerciseData objectAtIndex:indexPath.row]];
    
    cell.exerciseName.text = exercise.exerciseName;
    cell.difficulty.text = exercise.exerciseDifficulty;
    cell.difficulty.textColor = [CommonSetUpOperations determineDifficultyColor:exercise.exerciseDifficulty];
    
    cell.equipment.text = exercise.exerciseEquipment;
    NSString *trimmedString = [exercise.exerciseEquipment stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    
    if ([trimmedString isEqualToString:@"null"])
        cell.equipment.text = @"No Equipment";
    else
        cell.equipment.text = exercise.exerciseEquipment;
    
    //Load the exercise image on the background thread.
    [CommonSetUpOperations loadImageOnBackgroundThread:cell.exerciseImage image:[UIImage imageNamed:exercise.exerciseImageFile]];
    
    if ([exercise.liked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        cell.likeExerciseImage.hidden = NO;
        [cell.likeExerciseImage setImage:[UIImage imageNamed:@"likeSelectedColored.png"]];
        cell.likeExerciseImage.tintColor = STAYHEALTHY_BLUE;
    }
    else {
        cell.likeExerciseImage.hidden = YES;
    }
    
    UILabel *timeLabel = (UILabel*)[cell viewWithTag:14];
    timeLabel.text = [CommonUtilities calculateTime:exercise.lastViewed];
    
    //Set the selected cell background.
    [CommonSetUpOperations tableViewSelectionColorSet:cell];
    
    /*
    //configure right buttons
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"" icon:[UIImage imageNamed:@"workout.png"] backgroundColor:STAYHEALTHY_DARKERBLUE callback:^BOOL(MGSwipeTableCell *sender) {
        LogInfo(@"Add to workout");
        //[self performSegueWithIdentifier:@"detailModal" sender:nil];
        return YES;
    }]];
    cell.rightExpansion.fillOnTrigger = YES;
    cell.rightExpansion.threshold = 2.0f;
    cell.rightExpansion.buttonIndex = 0;
    cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;
*/

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
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            SHExercise *exercise = [exerciseData objectAtIndex:indexPath.row];
            ExerciseDetailViewController *destViewController = segue.destinationViewController;
            destViewController.exerciseToDisplay = exercise;
            destViewController.viewTitle = exercise.exerciseName;
            destViewController.modalView = NO;
        }
    
    if ([segue.identifier isEqualToString:@"showQuickFilter"]) {

        QuickFilterViewController *destinationViewController = segue.destinationViewController;
        
        // This is the important part
        UIPopoverPresentationController *popOverPresentationViewController = destinationViewController.popoverPresentationController;
        
        popOverPresentationViewController.delegate = self;
    }
    
    
   }

- (void)updateTableView {
     [self.tableView reloadData];
}

- (SHExercise *)updateExerciseWithUserData:(SHExercise*)exercise {
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    Exercise *dataExercise = [dataHandler fetchExerciseByIdentifier:exercise.exerciseIdentifier];
    
    if (dataExercise != nil) {
        exercise.lastViewed = dataExercise.lastViewed;
        exercise.liked = dataExercise.liked;
    }

    return exercise;
}

/*************************************/
#pragma mark ViewWillDisappear Methods
/*************************************/

//Dismiss all TSMessages when the view disappears.
-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}

@end
