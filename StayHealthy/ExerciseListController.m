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
    
    
    /*UIBarButtonItem* backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(closeButtonTapped:)];
    self.navigationItem.leftBarButtonItem = backButton;
    */
    self.navigationController.navigationItem.hidesBackButton = NO;
    
    NSArray *segItemsArray = [NSArray arrayWithObjects: @"All", @"Strength", @"Stretching",@"Liked", nil];
    
   
    segmentedControl = [[UISegmentedControl alloc] initWithItems:segItemsArray];
    segmentedControl.frame = CGRectMake(0, 0, self.view.frame.size.width-20, 30);
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *segmentedControlButtonItem = [[UIBarButtonItem alloc] initWithCustomView:(UIView *)segmentedControl];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *barArray = [NSArray arrayWithObjects: flexibleSpace, segmentedControlButtonItem, flexibleSpace, nil];
    
    
    [self.segmentedControlToolbar setItems:barArray];
    
    for (UIView *subView in [self.navigationController.navigationBar subviews]) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            // Hide the hairline border
            subView.hidden = YES;
        }
    }
    
    for (UIView *subView in [self.segmentedControlToolbar subviews]) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            // Hide the hairline border
            subView.hidden = YES;
        }
    }

    
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    
    //Set the title for the page to the muscle.
    self.title = self.viewTitle;

    //Sets the NSUserDefault and displays the TSMessage when page is loaded for the first time.
    if (!self.exerciseSelectionMode) {
     
    }
    
    //Get the exercise data.
    exerciseData = [[SHDataHandler getInstance] performExerciseStatement:self.exerciseQuery addUserData:YES];

    //Check the users preferences when loading the view.
    [self checkPreferences];
    
    [self setNotificationObservers];
    
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

//Checks user preferences to do various things in the loading of the view.
- (void)checkPreferences {

    
}

//Sets the observers for the notifications that need to be observed for.
- (void)setNotificationObservers {
    //Observe for changes. All just reload the recently
    //iCloud update notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateViews) name:CLOUD_UPDATE_NOTIFICATION object:nil];
    //Changes in a exercise record, i.e. changes in lastViewed.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateViews) name:EXERCISE_UPDATE_NOTIFICATION object:nil];
    //Changes in a exercise favorite.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateViews) name:EXERCISE_SAVE_NOTIFICATION object:nil];
}

- (void)segmentValueChanged:(UISegmentedControl *)sender {
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
    
    
    ExerciseCollectionViewCell *cell = (ExerciseCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"ExerciseCell" forIndexPath:indexPath];
    
    //[CommonSetUpOperations styleCollectionViewCellBodyZone:cell];
    
    SHExercise *exercise = [exerciseData objectAtIndex:indexPath.item];
    
    cell.layer.masksToBounds = NO;
    
    cell.layer.borderColor = LIGHT_GRAY_COLOR.CGColor;
    cell.layer.borderWidth = 0.5f;
    cell.layer.cornerRadius = 5.0f;
    cell.layer.shadowRadius = 10.0f;
    cell.layer.shadowOpacity = 0.75f;
    cell.layer.shadowOffset = CGSizeMake(0.0, 2.0);
    cell.layer.shadowColor = SHADOW_COLOR.CGColor;

    cell.selectedView.hidden = YES;
    cell.exerciseName.font = TABLE_VIEW_TITLE_FONT;
    cell.exerciseName.textColor = EXERCISES_COLOR;
    cell.exerciseDifficultyLabel.font = TABLE_VIEW_DETAIL_FONT;
    cell.exerciseDifficultyLabel.textColor = [CommonUtilities determineDifficultyColor:exercise.exerciseDifficulty];
    cell.exerciseEquipmentLabel.font = TABLE_VIEW_DETAIL_FONT;
    cell.exerciseEquipmentLabel.textColor = DARK_GRAY_COLOR;
    
    cell.exerciseName.text = exercise.exerciseShortName;
    cell.exerciseDifficultyLabel.text =  exercise.exerciseDifficulty;
    cell.exerciseEquipmentLabel.text = exercise.exerciseEquipmentNeeded;
    
    [CommonUtilities loadImageOnBackgroundThread:cell.exerciseImage image:[UIImage imageNamed:exercise.exerciseImageFile]];
    
    return cell;
    
}

//--------------------------------------------------
#pragma mark Collection View Cell Selection Handling
//--------------------------------------------------

//What happens when the user selects a cell in the tableView.
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.exerciseSelectionMode) {
        ExerciseCollectionViewCell *cell = (ExerciseCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        SHExercise *exercise = [exerciseData objectAtIndex:indexPath.row];
        
      /*  if ([CommonUtilities exerciseInArray:self.selectedExercises exercise:exercise]) {
            self.selectedExercises = [CommonUtilities deleteSelectedExercise:self.selectedExercises exercise:exercise];
            cell.selectedImage.hidden = YES;
            if ([exercise.exerciseLiked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                cell.likedImage.hidden = NO;
                [cell.likedImage setImage:[UIImage imageNamed:@"LikeCollectionViewCell.png"]];
            }
            else {
                cell.likedImage.hidden = YES;
            }
        }
        else  {
            cell.likedImage.hidden = NO;
            [self.selectedExercises addObject:exercise];
            if ([exercise.exerciseLiked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                [cell.likedImage setImage:[UIImage imageNamed:@"Checkmark.png"]];
                [cell.selectedImage setImage:[UIImage imageNamed:@"LikeCollectionViewCell.png"]];
                cell.selectedImage.hidden = NO;
            }
            else {
                cell.selectedImage.hidden = YES;
                [cell.likedImage setImage:[UIImage imageNamed:@"Checkmark.png"]];
            }
        }
    }
    else {
        selectedCollectionIndex = indexPath;
        [self performSegueWithIdentifier:@"detail" sender:nil];
    }
*/
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }}

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
        return CGSizeMake(172.0f, 222.0f);
    }
    else {
        return CGSizeMake(160.f, 160.f);
    }

}

/*****************************************/
#pragma mark - UIToolbar Delegate Methods
/*****************************************/

- (UIBarPosition)positionForBar:(id <UIBarPositioning>)bar {
    if (bar == self.segmentedControlToolbar) {
        return UIBarPositionTopAttached;
        
    }
    return UIBarPositionBottom;
}

/********************************************/
#pragma mark - UIScrollView Delegate Methods
/********************************************/

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == self.collectonView) {
        for (UIView *subView in [self.segmentedControlToolbar subviews]) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                [UIView transitionWithView:subView
                                  duration:0.4
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    subView.hidden = NO;
                                }
                                completion:NULL];
            }
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ((scrollView == self.collectonView) && (self.collectonView.contentOffset.y <= 20)) {
        for (UIView *subView in [self.segmentedControlToolbar subviews]) {
            if ([subView isKindOfClass:[UIImageView class]]) {
                [UIView transitionWithView:subView
                                  duration:0.4
                                   options:UIViewAnimationOptionTransitionCrossDissolve
                                animations:^{
                                    subView.hidden = YES;
                                }
                                completion:NULL];
            }
        }
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
}

/**************************/
#pragma mark Helper Methods
/**************************/

- (void)updateViews {
    [self.collectonView reloadData];
}

/*************************************/
#pragma mark View Will Disappear Methods
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
