//
//  ImprovedExerciseController.m
//  StayHealthy
//
//  Created by Student on 3/23/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//

#import "ImprovedExerciseController.h"

@interface ImprovedExerciseController ()
{
    //Boolean used to see if there are any exercises to display
    Boolean noResultsToDisplay;
    //Database
    sqlite3 * db;
}
@end

@implementation ImprovedExerciseController

@synthesize exerciseData;

/***********************/
#pragma mark ViewDidLoad
/***********************/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set the title for the page to the muscle.
    self.title = self.titleText;
    //Hide the tableView to hidden onload.
    self.tableViewList.hidden = YES;
    //Shows the navigation buttons.
    [self setUINavBarButtons];
    
    //Sets the NSUserDefault and displays the TSMessage when page is loaded for the first time.
    [CommonSetUpOperations setFirstViewTSMessage:@"FirstViewForPage" viewController:self message:@"Now that you have chosen a muscle and a exercise type you can view all the exercises. You can toggle between grid and list view with the button in the top right. Tap this message to dismiss."];
    
    //Get the exercise data.
    self.exerciseData = [CommonDataOperations returnExerciseData:self.query databaseName:STAYHEALTHY_DATABASE database:db];
    
    //If no data set BOOL to yes.
    if (self.exerciseData.count == 0)
        noResultsToDisplay = YES;
    
    //If the exercise data is nothing then show the message declaring that.
    if (self.exerciseData.count == 0)
        [CommonSetUpOperations performTSMessage:@"No Exercises Were Found" message:nil viewController:self canBeDismissedByUser:YES duration:60];
    
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

/*********************************************/
#pragma mark UICollectionView Delegate Methods
/*********************************************/

//Sets the cell size for the collectionview cell.
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //If iPhone 6 Plus use the large cell for the collectionview.
    if (IS_IPHONE_6P)
        return LARGECELL;
    //If iPhone 6 use the medium cell for the collectionview.
    if (IS_IPHONE_6)
        return MEDIUMCELL;
    //If iPhone 5/4 Plus use the small cell for the collectionview.
    else
        return SMALLCELL;
}

//Set the cell insets for the collectionview cell.
- (UIEdgeInsets)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    //Use the large insets if its a iPhone 6/6P/
    if (IS_IPHONE_6 || IS_IPHONE_6P)
        return LARGEINSETS;
    //Else use the small insets.
    else
        return SMALLINSETS;
}

//Set the minimum item spacing for the cells.
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5)
        return 0.0;
    else if (IS_IPHONE_6)
        return 5.0;
    else
        return 10.0;
}

//Set the number of items in the collectionview.
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        //equal to the number of exercises.
        return [self.exerciseData count];
}

//determine everything for each cell, at each indexPath
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Our ExerciseCollectionViewCell, subclass of UICollectionViewCell.
    ExerciseCollectionCell *exerciseCell;
    
    //Set the identifier for the cell.
    exerciseCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"exerciseCollectionCell" forIndexPath:indexPath];
    
    //Get the exercise objects.
    sqlColumns *exercise = [self.exerciseData objectAtIndex:indexPath.row];
    
    //Set the exercise name and style the label.
    exerciseCell.exerciseName.text = exercise.Name;
    exerciseCell.exerciseName.font = tableViewTitleTextFont;
    exerciseCell.exerciseName.textColor = STAYHEALTHY_BLUE;
    
    //Set the difficulty and style the label.
    if (IS_IPHONE_6P || IS_IPHONE_6)
        exerciseCell.difficulty.text = exercise.Difficulty;
    else if ([exercise.Difficulty isEqualToString:@"Intermediate"])
        exerciseCell.difficulty.text = @"Inter.";
    exerciseCell.difficulty.font = tableViewUnderTitleTextFont;
    exerciseCell.difficulty.textColor = [CommonSetUpOperations determineDifficultyColor:exercise.Difficulty];
    
    //Set the difficulty default label style.
    exerciseCell.difficultyStandards.font = tableViewUnderTitleTextFont;
    exerciseCell.difficultyStandards.textColor = STAYHEALTHY_LIGHTGRAYCOLOR;
    
    //Set the equipment label text and style it.
    NSString *trimmedString = [exercise.Equipment stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    if ([trimmedString isEqualToString:@"null"])
        exerciseCell.equipment.text = @"None";
    else
        exerciseCell.equipment.text = exercise.Equipment;
    exerciseCell.equipment.font = tableViewUnderTitleTextFont;
    exerciseCell.equipment.textColor = STAYHEALTHY_LIGHTGRAYCOLOR;
    
    //Set the equipment default label style.
    exerciseCell.equipmentStandards.font = tableViewUnderTitleTextFont;
    exerciseCell.equipmentStandards.textColor = STAYHEALTHY_LIGHTGRAYCOLOR;
    
    //Load the exercise image on the background thread.
    [CommonSetUpOperations loadImageOnBackgroundThread:exerciseCell.exerciseImage image:[UIImage imageNamed:exercise.File]];
    
    //Style the cell, adding shadows and rounding corners.
    [CommonSetUpOperations styleCollectionViewCell:exerciseCell];

    return exerciseCell;
}

/****************************************/
#pragma mark UITableView Delegate Methods
/****************************************/

//Sets the number of rows in the tableview.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //equal to the number of exercises for this search.
    return [self.exerciseData count];
}

//determine everything for each cell, at each indexPath
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //write the cell identifier.
    static NSString *simpleTableIdentifier = @"exerciseTableCell";

    //Set the cell identifier.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    //Get the exercise objects.
    sqlColumns *exercise = [self.exerciseData objectAtIndex:indexPath.row];
    
    //Set the exercise name and style the label.
    UILabel *exerciseName = (UILabel *)[cell viewWithTag:101];
    exerciseName.font = tableViewTitleTextFont;
    exerciseName.text = exercise.Name;
    exerciseName.textColor = STAYHEALTHY_BLUE;
    
    //Set the equipment names and style the label.
    UILabel *equipment = (UILabel *)[cell viewWithTag:102];
    equipment.text = exercise.Equipment;
    equipment.font = tableViewUnderTitleTextFont;
    equipment.textColor = STAYHEALTHY_LIGHTGRAYCOLOR;
    
    //Set the equipment default and set the style.
    UILabel *equipmentStandard = (UILabel *)[cell viewWithTag:10];
    equipmentStandard.font = tableViewUnderTitleTextFont;
    equipmentStandard.textColor = STAYHEALTHY_LIGHTGRAYCOLOR;
    NSString *trimmedString = [exercise.Equipment stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    if ([trimmedString isEqualToString:@"null"])
        equipment.text = @"No Equipment";
    else
        equipment.text = exercise.Equipment;
    
    //Set the difficulty and set the style.
    UILabel *difficulty = (UILabel *)[cell viewWithTag:103];
    difficulty.text = exercise.Difficulty;
    difficulty.font = tableViewUnderTitleTextFont;
    difficulty.textColor = [CommonSetUpOperations determineDifficultyColor:exercise.Difficulty];
    
    //Set the difficulty default and set the style.
    UILabel *difficultyStandard = (UILabel *)[cell viewWithTag:11];
    difficultyStandard.font = tableViewUnderTitleTextFont;
    difficultyStandard.textColor = STAYHEALTHY_LIGHTGRAYCOLOR;

    //Load the exercise image on the background thread.
    [CommonSetUpOperations loadImageOnBackgroundThread:(UIImageView*)[cell viewWithTag:100] image:[UIImage imageNamed:exercise.File]];
    
    //Set the selected cell background.
    [CommonSetUpOperations tableViewSelectionColorSet:cell];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //deselect the cell when you select it, makes selected background view disappear.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*****************************/
#pragma mark Prepare For Segue
/*****************************/

//What happens just before a segue is performed.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //What happens when you press a cell in the collectionviewcell.
    if (self.tableViewList.hidden == YES) {
        if ([segue.identifier isEqualToString:@"detail"]) {
            NSArray *arrayOfIndexPaths = [self.groupCollection indexPathsForSelectedItems];
            NSIndexPath *indexPath = [arrayOfIndexPaths firstObject];
            sqlColumns *exercise = [self.exerciseData objectAtIndex:indexPath.row];
            ExerciseDetailViewController *destViewController = segue.destinationViewController;
            destViewController.image = [UIImage imageNamed:exercise.File];
            destViewController.text = exercise.Description;
            destViewController.title1 = exercise.Name;
            destViewController.reps = exercise.Reps;
            destViewController.sets = exercise.Sets;
            destViewController.material = exercise.Equipment;
            destViewController.difficulty = exercise.Difficulty;
            destViewController.pri = exercise.PrimaryMuscle;
            destViewController.sec = exercise.SecondaryMuscle;
            destViewController.ident = exercise.ID;
            destViewController.exerciseType = exercise.ExerciseType;
            destViewController.favorite = exercise.isFavorite;
            destViewController.hidesBottomBarWhenPushed = YES;
        }
    }
    else {
        //What happens when you press a cell in the tableview.
        if ([segue.identifier isEqualToString:@"detail"]) {
            NSIndexPath *indexPath = [self.list indexPathForSelectedRow];
            sqlColumns *exercise = [self.exerciseData objectAtIndex:indexPath.row];
            ExerciseDetailViewController *destViewController = segue.destinationViewController;
            destViewController.image = [UIImage imageNamed:exercise.File];
            destViewController.text = exercise.Description;
            destViewController.title1 = exercise.Name;
            destViewController.reps = exercise.Reps;
            destViewController.sets = exercise.Sets;
            destViewController.material = exercise.Equipment;
            destViewController.difficulty = exercise.Difficulty;
            destViewController.pri = exercise.PrimaryMuscle;
            destViewController.sec = exercise.SecondaryMuscle;
            destViewController.ident = exercise.ID;
            destViewController.favorite = exercise.isFavorite;
            destViewController.exerciseType = exercise.ExerciseType;
            destViewController.hidesBottomBarWhenPushed = YES;
        }
     }
   }

/*********************************************************/
#pragma mark Change Display Methods/Set Navigation Buttons
/*********************************************************/

//called when the nav items are pressed.
-(IBAction)collectionViewUpdate:(id)sender {
    self.tableViewList.hidden = YES;
    self.collectionViewGroup.hidden = NO;
    UIBarButtonItem *tableview = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"TableviewIcon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(tableViewUpdate:)];
    NSArray *actionButtonItems = @[tableview];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
}
-(IBAction)tableViewUpdate:(id)sender {
    self.collectionViewGroup.hidden = YES;
    self.tableViewList.hidden = NO;
    UIBarButtonItem *collectionview = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"CollectionviewIcon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(collectionViewUpdate:)];
    NSArray *actionButtonItems = @[collectionview];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
}
//sets the navigation buttons.
-(void)setUINavBarButtons {
    UIBarButtonItem *tableview = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"TableviewIcon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(tableViewUpdate:)];
    NSArray *actionButtonItems = @[tableview];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
}

/*************************************/
#pragma mark ViewWillDisappear Methods
/*************************************/

//Dismiss all TSMessages when the view disappears.
-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}

@end
