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
    if (!self.exerciseSelectionMode) {
        [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_FIND_EXERCISE_SEARCHED  viewController:self message:@"I found these exercises for you! Here you can just choose an exercise you like the look of and I'll show you more about it."];
    }
    
    
    //Get the exercise data.
    exerciseData = [[SHDataHandler getInstance] performExerciseStatement:self.exerciseQuery addUserData:YES];

    //If the exercise data is nothing then show the message declaring that.
    /*if (exerciseData.count == 0)
        [CommonSetUpOperations performTSMessage:@"No Exercises Were Found" message:nil viewController:self canBeDismissedByUser:YES duration:60];*/
    
    [self setNotificationObservers];
    
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self register3DTouch];
}

//Sets the observers for the notifications that need to be observed for.
- (void)setNotificationObservers {
    //Observe for changes. All just reload the recently
    //iCloud update notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:CLOUD_UPDATE_NOTIFICATION object:nil];
    //Changes in a exercise record, i.e. changes in lastViewed.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:EXERCISE_UPDATE_NOTIFICATION object:nil];
    //Changes in a exercise favorite.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableView) name:EXERCISE_SAVE_NOTIFICATION object:nil];
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
    
    SHExercise *exercise = [exerciseData objectAtIndex:indexPath.row];
    
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
    
    if ([exercise.exerciseLiked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        cell.likeExerciseImage.hidden = NO;
        if (self.exerciseSelectionMode) {
            [cell.likeExerciseImageSelection setImage:[UIImage imageNamed:@"likeSelectedColored.png"]];
            cell.likeExerciseImageSelection.tintColor = BLUE_COLOR;
        }
        else {
            [cell.likeExerciseImage setImage:[UIImage imageNamed:@"likeSelectedColored.png"]];
            cell.likeExerciseImage.tintColor = BLUE_COLOR;
        }
    
    }
    else {
        cell.likeExerciseImage.hidden = YES;
    }
    
    
    //Set the selected cell background.
    [CommonSetUpOperations tableViewSelectionColorSet:cell];
    
    
    //configure right buttons
    cell.rightButtons = @[[MGSwipeButton buttonWithTitle:nil icon:[UIImage imageNamed:@"AddToWorkout.png"] backgroundColor:BLUE_COLOR callback:^BOOL(MGSwipeTableCell *sender) {
        selectedIndex = indexPath;
        [self performSegueWithIdentifier:@"addToWorkout" sender:nil];
        return YES;
    }]];
    cell.rightExpansion.fillOnTrigger = YES;
    cell.rightExpansion.threshold = 2.0f;
    cell.rightExpansion.buttonIndex = 0;
    cell.rightSwipeSettings.transition = MGSwipeTransitionDrag;


    if (self.exerciseSelectionMode) {
        //Set the accessory type dependant on whether it is in selected cells array.
        if ([CommonUtilities exerciseInArray:self.selectedExercises exercise:exercise]) {
            //Make the checkmark show up.
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            cell.likeDistanceToEdge.constant = 0.0f;
        }
        else {
            //Make no checkmark.
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.likeDistanceToEdge.constant = 21.0f;
        }
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.exerciseSelectionMode) {
        if (self.exerciseSelectionMode) {
            ExerciseTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            SHExercise *exercise = [exerciseData objectAtIndex:indexPath.row];
            if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
                 self.selectedExercises = [CommonUtilities deleteSelectedExercise:self.selectedExercises exercise:exercise];
                cell.likeDistanceToEdge.constant = 21.0f;
                cell.accessoryType = UITableViewCellAccessoryNone;
            } else {
                [self.selectedExercises addObject:exercise];
                cell.likeDistanceToEdge.constant = 0.0f;
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
        }
    }
    else {
        [self performSegueWithIdentifier:@"detail" sender:nil];
    }
    
    //deselect the cell when you select it, makes selected background view disappear.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/***************************************************/
#pragma mark UICollectionView Delegate/Datasource Methods
/***************************************************/


//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//Returns the number of rows in a section that should be displayed in the tableView.
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [exerciseData count];
}

//Configures the cells at a specific indexPath.
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ExerciseCollectionViewCell *cell = (ExerciseCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"exercisecell" forIndexPath:indexPath];
    
    [CommonSetUpOperations styleCollectionViewCellBodyZone:cell];
    
     SHExercise *exercise = [exerciseData objectAtIndex:indexPath.item];
    
    cell.exerciseName.text = exercise.exerciseName;
    
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableAttributedString *difficultyText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Difficulty: %@",exercise.exerciseDifficulty]];
    
    //Red and large
    [difficultyText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:14.0f], NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(0, 11)];
    
    //Rest of text -- just futura
    [difficultyText setAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Avenir-Light" size:14.0f], NSForegroundColorAttributeName:[CommonSetUpOperations determineDifficultyColor:exercise.exerciseDifficulty]} range:NSMakeRange(11, difficultyText.length - 11)];

    cell.exerciseDifficultyLabel.attributedText = difficultyText;
    
    //Load the exercise image on the background thread.
    [CommonSetUpOperations loadImageOnBackgroundThread:cell.exerciseImage image:[UIImage imageNamed:exercise.exerciseImageFile]];
    
    if ([exercise.exerciseLiked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        cell.likedImage.hidden = NO;
        if (self.exerciseSelectionMode) {
            [cell.likedImage setImage:[UIImage imageNamed:@"likeSelectedColored.png"]];
            //cell.likeExerciseImageSelection.tintColor = BLUE_COLOR;
        }
        else {
            [cell.likedImage setImage:[UIImage imageNamed:@"likeSelectedColored.png"]];
            //cell.likedImage.tintColor = BLUE_COLOR;
        }
        
    }
    else {
        cell.likedImage.hidden = YES;
    }

    
    return cell;
    
}

//--------------------------------------------------
#pragma mark Collection View Cell Selection Handling
//--------------------------------------------------

//What happens when the user selects a cell in the tableView.
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    selectedCollectionIndex = indexPath;
    [self performSegueWithIdentifier:@"detail" sender:nil];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

//-------------------------------------------
#pragma mark Collection Layout Configuration
//-------------------------------------------

//Controls the size of the collection view cells for different phones.
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
        if (IS_IPHONE_6P) {
            return CGSizeMake(207.f, 207.f);
        }
        else if (IS_IPHONE_6) {
            return CGSizeMake(187.5f, 240.5f);
        }
        else {
            return CGSizeMake(160.f, 160.f);
        }
}


/*****************************/
#pragma mark Prepare For Segue
/*****************************/

//What happens just before a segue is performed.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

        if ([segue.identifier isEqualToString:@"detail"]) {
            SHExercise *exercise = [exerciseData objectAtIndex:selectedCollectionIndex.item];
            ExerciseDetailViewController *detailView = [[ExerciseDetailViewController alloc] init];
            detailView = segue.destinationViewController;
            detailView.exerciseToDisplay = exercise;
            detailView.viewTitle = exercise.exerciseName;
            detailView.modalView = NO;
            detailView.showActionIcon = YES;
    }
       
    else if ([segue.identifier isEqualToString:@"addToWorkout"]) {
        UINavigationController *navController = [[UINavigationController alloc] init];
        CustomWorkoutSelectionViewController *customWorkoutSelection = [[CustomWorkoutSelectionViewController alloc] init];
        navController = segue.destinationViewController;
        customWorkoutSelection = navController.viewControllers[0];
        customWorkoutSelection.exerciseToAdd = [exerciseData objectAtIndex:selectedIndex.row];
    }
    
    
   }

- (void)updateTableView {
     [self.tableView reloadData];
}

/*************************************************/
#pragma mark - 3D Touch Peek and Pop Configuration
/*************************************************/

//-----------------
#pragma mark Set Up
//-----------------

//Checks to see if 3D Touch is enabled on device, registers alternative if not.
- (void)register3DTouch {
    //Register for 3D Touch (if available)
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:(id)self sourceView:self.view];
    }
}

//Called when a user turns the 3D touch feature on or off.
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    //Check to see if 3D touch is enabled.
    [self register3DTouch];
}

//---------------
#pragma mark Peek
//---------------

//Set up the view controller for peeking.
/*- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    
    // check if we're not already displaying a preview controller
    if ([self.presentedViewController isKindOfClass:[ExerciseDetailViewController class]]) {
        return nil;
    }
    
    CGPoint cellPostion = [self.tableView convertPoint:location fromView:self.view];
    selectedPreviewingIndex = [self.tableView indexPathForRowAtPoint:cellPostion];
    
    //Shallow press, return the preview controller here. (peek)
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_Storyboard" bundle:nil];
    previewingExerciseDetailViewController = [storyboard instantiateViewControllerWithIdentifier:@"ExerciseDetailViewController"];

    //Get the exercise to display in the peek and set the peeks attributes.
    SHExercise *exercise = [exerciseData objectAtIndex:selectedPreviewingIndex.row];
    previewingExerciseDetailViewController.exerciseToDisplay = exercise;
    previewingExerciseDetailViewController.viewTitle = exercise.exerciseName;
    previewingExerciseDetailViewController.showActionIcon = YES;
    
    return previewingExerciseDetailViewController;
}
*/
//---------------
#pragma mark Pop
//---------------

//Show the view controller, pop.
/*- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:previewingExerciseDetailViewController sender:self];
}
*/


/*************************************/
#pragma mark ViewWillDisappear Methods
/*************************************/

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [TSMessage dismissActiveNotification];
    
    // check if the back button was pressed
    if (self.isMovingFromParentViewController) {
        if (self.exerciseSelectionMode) {
            [self.delegate selectedExercises:self.selectedExercises];
        }
    }
}

@end
