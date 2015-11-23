//
//  ExerciseDetailViewController.m
//  StayHealthy
//
//  Created by Student on 12/21/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
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
    
    
    
    if (self.modalView) {
        UIBarButtonItem* backButton = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonTapped:)];
        self.navigationItem.leftBarButtonItem = backButton;
    }
    
    //Sets the NSUserDefault and displays the TSMessage when page is loaded for the first time.
    [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_FIND_EXERCISE_DETAIL  viewController:self message:@"This is a good one, hopefully you will like it! Make sure to scroll down to see more details about the exercise and favorite it by tapping the heart in the top right or by double tapping on the exercise image!"];
    
    /*UIBarButtonItem* actionSheet = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"actionSheet.png"] style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItems = @[self.likeButton,actionSheet];
    */
    
    self.title = self.viewTitle;
    
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    NSInteger timesViewed = [self.exerciseToDisplay.timesViewed integerValue];
    
    //Save or Update the exercise information.
    if ([dataHandler exerciseHasBeenSaved:self.exerciseToDisplay.exerciseIdentifier]) {
        self.exerciseToDisplay.lastViewed = [NSDate date];
        self.exerciseToDisplay.timesViewed = [NSNumber numberWithInteger:timesViewed+1];
        [dataHandler updateExerciseRecord:self.exerciseToDisplay];
    }
    else {
        self.exerciseToDisplay.timesViewed = [NSNumber numberWithInteger:1];
        self.exerciseToDisplay.lastViewed = [NSDate date];
        [dataHandler saveExerciseRecord:self.exerciseToDisplay];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:exerciseNotification object:nil];
    
    
    if ([self.exerciseToDisplay.liked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
         [self.likeButton setImage:[UIImage imageNamed:@"likeSelected.png"]];
    }
    else {
        [self.likeButton setImage:[UIImage imageNamed:@"like.png"]];
    }
   
    favouriteImageView.alpha = 0.0f;
    
    
    //Load the exercise image on the background thread.
    [CommonSetUpOperations loadImageOnBackgroundThread:self.exerciseImageView image:[UIImage imageNamed:self.exerciseToDisplay.exerciseImageFile]];
    
     self.descriptionLabel.text = self.exerciseToDisplay.exerciseInstructions;
    
    //Allows user to scroll the UIScrollView
    [scroller setScrollEnabled:YES];


   
    
    //Find the path to the plist containing all the nessescary information.
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"findExercise" ofType:@"plist"];
    NSDictionary *findExerciseData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];

    //Fill exercise types with information from the plist.
    exerciseTypesNames = findExerciseData[@"exerciseTypes"];
    
    //Fill the tableview titles array with the correct titles.
    tableViewTitles = @[@"Sets",@"Reps",@"Primary Muscle",@"Secondary Muscle",@"Equipment",@"Difficulty",@"Times Viewed"];
    
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
    
    if ([self.likeButton.image isEqual:[UIImage imageNamed:@"likeSelected.png"]]) {
        self.exerciseToDisplay.liked = [NSNumber numberWithBool:YES];
    }
    else {
        self.exerciseToDisplay.liked = [NSNumber numberWithBool:NO];
    }
    
    //Save or Update the exercise information.
    if ([dataHandler exerciseHasBeenSaved:self.exerciseToDisplay.exerciseIdentifier]) {
        [dataHandler updateExerciseRecord:self.exerciseToDisplay];
    }
    else {
        [dataHandler saveExerciseRecord:self.exerciseToDisplay];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:exerciseFavNotification object:nil];
    
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
    
    return 7;
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
    
    cell.textLabel.font = tableViewTitleTextFont;
    cell.detailTextLabel.font = tableViewDetailTextFont;
    
    cell.textLabel.textColor = STAYHEALTHY_BLUE;
    cell.detailTextLabel.textColor = STAYHEALTHY_LIGHTGRAYCOLOR;
    
    //Sets
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = self.exerciseToDisplay.exerciseSets;
    }
    
    //Reps
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = self.exerciseToDisplay.exerciseReps;
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
        cell.detailTextLabel.text = [self.exerciseToDisplay.timesViewed stringValue];
    }
    
        return cell;
}

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (popup.tag == 1) {
            if (buttonIndex == 0) {
                LogInfo(@"Add to workout");
            }
            else {
                 LogInfo(@"Share");
            }
    }
}


//If the user leaves the page then dismiss the all TSMessages.
-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}

- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)actionSheetPressed:(id)sender {
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Add to Workout",
                            @"Share",
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}
@end
