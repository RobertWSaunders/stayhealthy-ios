//
//  ExerciseDetailViewController.m
//  StayHealthy
//
//  Created by Student on 12/21/2013.
//  Copyright (c) 2013 Robert Saunders. All rights reserved.
//

#import "ExerciseDetailViewController.h"

@interface ExerciseDetailViewController ()

@end

@implementation ExerciseDetailViewController

/***********************/
#pragma mark ViewDidLoad
/***********************/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBarController.tabBar.hidden = YES;

    if (!self.showActionIcon) {
        self.navigationItem.rightBarButtonItems = @[self.likeButton];
    }

    if (self.modalView) {
        UIBarButtonItem* backButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonTapped:)];
        self.navigationItem.leftBarButtonItem = backButton;
    }
    
    //Sets the NSUserDefault and displays the TSMessage when page is loaded for the first time.
    [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_FIND_EXERCISE_DETAIL  viewController:self message:@"This is a good one, hopefully you will like it! Make sure to scroll down to see more details about the exercise and favourite it by tapping the heart in the top right or by double tapping on the exercise image. You can also find some options that are available to you by tapping the sheet icon beside the heart in the top right."];
    
    /*UIBarButtonItem* actionSheet = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"actionSheet.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[self.likeButton,actionSheet];
    */
    
    differentVariationsExerciseIDs = [self.exerciseToDisplay.exerciseDifferentVariationsExerciseIdentifiers componentsSeparatedByString:@","];
    
    self.title = self.viewTitle;
    
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    NSInteger timesViewed = [self.exerciseToDisplay.exerciseTimesViewed integerValue];
    
    //Save or Update the exercise information.
    if ([SHDataUtilities exerciseHasBeenSaved:self.exerciseToDisplay.exerciseIdentifier exerciseType:self.exerciseToDisplay.exerciseType]) {
        self.exerciseToDisplay.exerciseLastViewed = [NSDate date];
        self.exerciseToDisplay.exerciseTimesViewed = [NSNumber numberWithInteger:timesViewed+1];
        [dataHandler updateExerciseRecord:self.exerciseToDisplay];
    }
    else {
        self.exerciseToDisplay.exerciseTimesViewed = [NSNumber numberWithInteger:1];
        self.exerciseToDisplay.exerciseLastViewed = [NSDate date];
        [dataHandler saveExerciseRecord:self.exerciseToDisplay];
    }
    
    [CommonSetUpOperations styleAlertView:EXERCISES_COLOR];
    
    
    if ([self.exerciseToDisplay.exerciseLiked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
         [self.likeButton setImage:[UIImage imageNamed:@"likeSelected.png"]];
    }
    else {
        [self.likeButton setImage:[UIImage imageNamed:@"like.png"]];
    }
   
    favouriteImageView.alpha = 0.0f;
    
    
    self.exerciseImageView.image = [UIImage imageNamed:self.exerciseToDisplay.exerciseImageFile];
    
    //Load the exercise image on the background thread.
    //[CommonSetUpOperations loadImageOnBackgroundThread:self.exerciseImageView image:[UIImage imageNamed:self.exerciseToDisplay.exerciseImageFile]];
    
     self.descriptionLabel.text = self.exerciseToDisplay.exerciseInstructions;
    
    //Allows user to scroll the UIScrollView
    [scroller setScrollEnabled:YES];


   
    
    //Find the path to the plist containing all the nessescary information.
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"findExercise" ofType:@"plist"];
    NSDictionary *findExerciseData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];

    //Fill exercise types with information from the plist.
    exerciseTypesNames = findExerciseData[@"exerciseTypes"];
    
    //Fill the tableview titles array with the correct titles.
    tableViewTitles = @[@"Sets",@"Reps",@"Primary Muscle",@"Secondary Muscle",@"Equipment",@"Difficulty",@"Force Type",@"Mechanics Type",@"Different Variations",@"Related Stretches"];
    
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;
    //Gets rid on needed TableView seperator lines.
    detailTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    //within cellForRowAtIndexPath (where customer table cell with imageview is created and reused)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleImageTap:)];
    tap.cancelsTouchesInView = YES;
    tap.numberOfTapsRequired = 2;
    tap.delegate = self;
    [self.exerciseImageView addGestureRecognizer:tap];
    
    self.exerciseImageView.userInteractionEnabled = YES;
    
}

/***************************/
#pragma mark Utility Methods
/***************************/

//Changes the images for the favorite button when the user presses it.
-(void)changeImage {
    if ([self.likeButton.image isEqual:[UIImage imageNamed:@"like.png"]])
        [self.likeButton setImage:[UIImage imageNamed:@"likeSelected.png"]];
    else
        [self.likeButton setImage:[UIImage imageNamed:@"like.png"]];
}

//The mehtod that saves the favorite or takes it away.
- (IBAction)update:(id)sender {
    [self favourite];
 
}

- (void)favourite {
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    [self changeImage];
    
    if ([self.exerciseToDisplay.exerciseLiked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        self.exerciseToDisplay.exerciseLiked = [NSNumber numberWithBool:NO];
    }
    else {
        self.exerciseToDisplay.exerciseLiked = [NSNumber numberWithBool:YES];
    }
    
    //Save or Update the exercise information.
    if ([SHDataUtilities exerciseHasBeenSaved:self.exerciseToDisplay.exerciseIdentifier exerciseType:self.exerciseToDisplay.exerciseType]) {
        [dataHandler updateExerciseRecord:self.exerciseToDisplay];
    }
    else {
        [dataHandler saveExerciseRecord:self.exerciseToDisplay];
    }
    
}

// handle method
- (void) handleImageTap:(UIGestureRecognizer *)gestureRecognizer {
    
    [self favourite];
    
    [UIView animateWithDuration:2.0f
                          delay:0.1f
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^(void) {
                         
                         
                         if ([self.likeButton.image isEqual:[UIImage imageNamed:@"likeSelected.png"]]) {
                             favouriteImageView.image = [UIImage imageNamed:@"LikeFilledShadow.png"];
                         }
                         else {
                             favouriteImageView.image = [UIImage imageNamed:@"LikeShadow.png"];
                         }

                         favouriteImageView.alpha = 1.0f;
                         
                     }
                     completion:NULL];
    
    [self hideFavouriteAnimation];
  

}

- (void)hideFavouriteAnimation {
    
         [UIView animateWithDuration:.4f
                               delay:.6f
                             options:UIViewAnimationOptionCurveEaseIn
                          animations:^(void) {
                              favouriteImageView.alpha = 0.0f;
            }
          completion:NULL];
}


/**************************************/
#pragma mark TableView Delegate Methods
/**************************************/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (([self.exerciseToDisplay.exerciseType isEqualToString:@"strength"]) && ([differentVariationsExerciseIDs count] > 0)) {
        tableViewHeightConstraint.constant = 640.f;
        return 10;
    }
    else if ((([self.exerciseToDisplay.exerciseType isEqualToString:@"strength"]) && ([differentVariationsExerciseIDs count] == 0)) || (([differentVariationsExerciseIDs count] > 0) && (![self.exerciseToDisplay.exerciseType isEqualToString:@"strength"]))) {
        tableViewHeightConstraint.constant = 576.f;
        return 9;
    }
    else {
        tableViewHeightConstraint.constant = 512.f;
        return 8;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0f;
}

//Design and fill the tableview cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

        static NSString *muscleItem = @"detailItem";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleItem];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:muscleItem];
        }
    
    cell.textLabel.text = [tableViewTitles objectAtIndex:indexPath.row];
    [cell setUserInteractionEnabled:NO];
    
    cell.textLabel.font = TABLE_VIEW_TITLE_FONT;
    cell.detailTextLabel.font = tableViewDetailTextFont;
    
    cell.textLabel.textColor = BLUE_COLOR;
    cell.detailTextLabel.textColor = LIGHT_GRAY_COLOR;
    
    //Sets
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = self.exerciseToDisplay.exerciseSets;
        
        // Do any additional setup after loading the view, typically from a nib.
        NSMutableAttributedString *setsText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Sets  (Recommended)"]];
        
        //Red and large
        [setsText setAttributes:@{NSFontAttributeName:TABLE_VIEW_TITLE_FONT, NSForegroundColorAttributeName:BLUE_COLOR} range:NSMakeRange(0, 6)];
        
        //Rest of text -- just futura
        [setsText setAttributes:@{NSFontAttributeName:TABLE_VIEW_TITLE_FONT, NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(5, setsText.length - 5)];
        
        cell.textLabel.attributedText = setsText;
                                  
        
    }
    
    //Reps
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = self.exerciseToDisplay.exerciseReps;
        
        // Do any additional setup after loading the view, typically from a nib.
        NSMutableAttributedString *repsText = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Reps  (Recommended)"]];
        
        //Red and large
        [repsText setAttributes:@{NSFontAttributeName:TABLE_VIEW_TITLE_FONT, NSForegroundColorAttributeName:BLUE_COLOR} range:NSMakeRange(0, 6)];
        
        //Rest of text -- just futura
        [repsText setAttributes:@{NSFontAttributeName:TABLE_VIEW_TITLE_FONT, NSForegroundColorAttributeName:[UIColor lightGrayColor]} range:NSMakeRange(5, repsText.length - 5)];
        
        cell.textLabel.attributedText = repsText;
    }
    
    //Primary Muscle
    if (indexPath.row == 2) {
        cell.detailTextLabel.text = self.exerciseToDisplay.exercisePrimaryMuscle;
    }
    
    //Secondary Muscle
    if (indexPath.row == 3) {
        NSString *trimmedStrings2 = [self.exerciseToDisplay.exerciseSecondaryMuscle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([trimmedStrings2 isEqualToString:@"null"])
                 self.exerciseToDisplay.exerciseSecondaryMuscle = @"No Secondary Muscle";
        cell.detailTextLabel.text = self.exerciseToDisplay.exerciseSecondaryMuscle;
    }
    
    //Equipment
    if (indexPath.row == 4) {
        NSString *trimmedString = [self.exerciseToDisplay.exerciseEquipment stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        if ([trimmedString isEqualToString:@"null"])
            self.exerciseToDisplay.exerciseEquipment = @"No Equipment";
        cell.detailTextLabel.text = self.exerciseToDisplay.exerciseEquipment;
    }
    
    //Difficulty
    if (indexPath.row == 5) {
        cell.detailTextLabel.text = self.exerciseToDisplay.exerciseDifficulty;
        cell.detailTextLabel.textColor = [CommonSetUpOperations determineDifficultyColor:self.exerciseToDisplay.exerciseDifficulty];
    }
    
    if (indexPath.row == 6) {
       cell.detailTextLabel.text = self.exerciseToDisplay.exerciseForceType;
    }
    if (indexPath.row == 7) {
        cell.detailTextLabel.text = self.exerciseToDisplay.exerciseMechanicsType;
    }

    if (indexPath.row >= 8) {
        if (indexPath.row == 8) {
            if ((([self.exerciseToDisplay.exerciseType isEqualToString:@"strength"]) && ([differentVariationsExerciseIDs count] == 0))) {
                cell.textLabel.text = [tableViewTitles objectAtIndex:indexPath.row+1];
            }
            else if ((([differentVariationsExerciseIDs count] > 0) && (![self.exerciseToDisplay.exerciseType isEqualToString:@"strength"]))) {
                cell.textLabel.text = [tableViewTitles objectAtIndex:indexPath.row];
            }
        }
        cell.detailTextLabel.text = @"";
        [cell setUserInteractionEnabled:YES];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //Set the selected cell background.
    [CommonSetUpOperations tableViewSelectionColorSet:cell];
    
        return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"exerciseList" sender:nil];
    //deselect the cell when you select it, makes selected background view disappear.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
//If the user leaves the page then dismiss the all TSMessages.
-(void)viewWillDisappear:(BOOL)animated {
   // [HomeTabBarController showTabBar:self.tabBarController];
    [TSMessage dismissActiveNotification];
}

- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)actionSheetPressed:(id)sender {

    
    //No stretching for bicep, chest, forearms, oblique.
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"title" andMessage:nil];
    [alertView addButtonWithTitle:@"Add Exercise Log"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                            
                          }];
        [alertView addButtonWithTitle:@"Add to Workout"
                                 type:SIAlertViewButtonTypeCancel
                              handler:^(SIAlertView *alertView) {
                                 [self performSegueWithIdentifier:@"addToWorkout" sender:nil];
                              }];
    [alertView addButtonWithTitle:@"Edit Exercise"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              
                          }];
        [alertView addButtonWithTitle:@"Cancel"
                             type:SIAlertViewButtonTypeCancel
                          handler:nil];
    alertView.title = @"Exercise Options";
    [alertView show];

    
    /*
    
    LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:@"Exercise Options"
                                                        message:@"Select the option you would like to proceed with."
                                                          style:LGAlertViewStyleActionSheet
                                                   buttonTitles:@[@"Add to Workout"]
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                                  actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
                                                      
                                                      [self performSegueWithIdentifier:@"addToWorkout" sender:nil];
                                                  }
                                                  cancelHandler:nil
                                             destructiveHandler:nil];
    alertView.titleFont = [UIFont fontWithName:regularFontName size:18.0f];
    alertView.titleTextColor = LIGHT_GRAY_COLOR;
    alertView.messageFont = [UIFont fontWithName:regularFontName size:16.0f];
    alertView.messageTextColor = DARK_GRAY_COLOR;
    alertView.buttonsFont = [UIFont fontWithName:regularFontName size:18.0f];
    alertView.buttonsTitleColor = BLUE_COLOR;
    alertView.buttonsBackgroundColorHighlighted = BLUE_COLOR;
    alertView.cancelButtonFont = [UIFont fontWithName:regularFontName size:18.0f];
    alertView.cancelButtonTitleColor = BLUE_COLOR;
    alertView.cancelButtonBackgroundColorHighlighted = BLUE_COLOR;
    [alertView showAnimated:YES completionHandler:nil];
     */
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addToWorkout"]) {
        UINavigationController *navController = [[UINavigationController alloc] init];
        CustomWorkoutSelectionViewController *customWorkoutSelection = [[CustomWorkoutSelectionViewController alloc] init];
        navController = segue.destinationViewController;
        customWorkoutSelection = navController.viewControllers[0];
        customWorkoutSelection.exerciseToAdd = self.exerciseToDisplay;
    }
    if ([segue.identifier isEqualToString:@"exerciseList"]) {
        
        ExerciseListController *viewExercisesViewController = [[ExerciseListController alloc] init];
        viewExercisesViewController = segue.destinationViewController;
        NSIndexPath *indexPath = [self.infoTableView indexPathForSelectedRow];
        
        if (indexPath.row >= 8) {
            if (indexPath.row == 8) {
                if ((([self.exerciseToDisplay.exerciseType isEqualToString:@"strength"]) && ([differentVariationsExerciseIDs count] == 0))) {
                    NSMutableArray *muscles = [[NSMutableArray alloc] initWithObjects:self.exerciseToDisplay.exercisePrimaryMuscle, self.exerciseToDisplay.exerciseSecondaryMuscle, nil];
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:1 muscles:muscles];
                    viewExercisesViewController.viewTitle = @"Related Stretches";
                }
                else {
                    if ([self.exerciseToDisplay.exerciseType isEqualToString:@"strength"]) {
                          viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQueryFromExerciseIds:[differentVariationsExerciseIDs mutableCopy] table:STRENGTH_DB_TABLENAME];
                    }
                    else if ([self.exerciseToDisplay.exerciseType isEqualToString:@"stretching"]) {
                        viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQueryFromExerciseIds:[differentVariationsExerciseIDs mutableCopy] table:STRETCHING_DB_TABLENAME];
                    }
                    else {
                        viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQueryFromExerciseIds:[differentVariationsExerciseIDs mutableCopy] table:WARMUP_DB_TABLENAME];
                    }
                    viewExercisesViewController.viewTitle = @"Different Variations";
                }
            }
            else if (indexPath.row == 9) {
                if ((([self.exerciseToDisplay.exerciseType isEqualToString:@"strength"]) && ([differentVariationsExerciseIDs count] > 0))) {
                    NSMutableArray *muscles = [[NSMutableArray alloc] initWithObjects:self.exerciseToDisplay.exercisePrimaryMuscle, self.exerciseToDisplay.exerciseSecondaryMuscle, nil];
                    viewExercisesViewController.exerciseQuery = [CommonUtilities createExerciseQuery:1 muscles:muscles];
                    viewExercisesViewController.viewTitle = @"Related Stretches";
            }
            }
        }
    }
}

//-----------------------------
#pragma mark Previewing Actions
//-----------------------------

//Preview actions for exercise previewing.
- (NSArray<id> *)previewActionItems {
    
    //Exercise to preview.
    //SHExercise *exercise = [exerciseData objectAtIndex:selectedPreviewingIndex.row];
    
    //Add to Workout Preview Action
    UIPreviewAction *addToWorkoutAction = [UIPreviewAction actionWithTitle:@"Add to Workout" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        [self performSegueWithIdentifier:@"addToWorkout" sender:nil];
    }];
    
    //Fvourite Action
    UIPreviewAction *favouriteAction;
    
    //Set the favourite action to be selected if the exercise is favourited or not.
    /*
    if ([self.exerciseToDisplay.liked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
        favouriteAction  = [UIPreviewAction actionWithTitle:@"Unfavourite" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
            [self favourite];
        }];
    }
    else {
        favouriteAction  = [UIPreviewAction actionWithTitle:@"Favourite" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
            [self favourite];
        }];
    }
    */
    
    //Add to array.
    NSArray *actions = @[addToWorkoutAction, favouriteAction];
    
    //Return the actions.
    return actions;
}


@end
