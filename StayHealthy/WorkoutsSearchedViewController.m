//
//  WorkoutsSearchedViewController.m
//  StayHealthy
//
//  Created by Student on 7/20/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import "WorkoutsSearchedViewController.h"

@interface WorkoutsSearchedViewController ()

@end

@implementation WorkoutsSearchedViewController

@synthesize exerciseQuery;

#pragma mark ViewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.automaticallyAdjustsScrollViewInsets = NO;

     workoutsTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
   

    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"WorkoutsFirstLaunch2"])
    {
        [TSMessage showNotificationInViewController:self
                                              title:@"So you have searched for some workouts. Well we found some. This page presents you with all the workouts we found and you can select one to view more details or to start. Tap this message to dismiss."
                                           subtitle:nil
                                              image:nil
                                               type:TSMessageNotificationTypeMessage
                                           duration:TSMessageNotificationDurationEndless
                                           callback:nil
                                        buttonTitle:nil
                                     buttonCallback:nil
                                         atPosition:TSMessageNotificationPositionTop
                                canBeDismisedByUser:YES];

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"WorkoutsFirstLaunch2"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    
    //Set the title to the given titleText.
    self.title = self.titleText;
    
    //The UIBarButtons that toggle list or grid view
    UIBarButtonItem *tableview = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"TableviewIcon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(tableViewUpdate:)];
    NSArray *actionButtonItems = @[tableview];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
    

    //Loading the data into the arrays.
    workoutData = [CommonDataOperations returnWorkoutData:self.query databaseName:STAYHEALTHY_DATABASE database:db];
   
}

#pragma mark CollectionView Methods

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE_6P) {
        return CGSizeMake(186.f, 238.f);
    }
    if (IS_IPHONE_6) {
        return CGSizeMake(165.f, 217.f);
    }
    return CGSizeMake(140.0f, 191.0f);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //Show the amount of items that are in the array.
    return workoutData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier1;
    
    if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
        simpleTableIdentifier1 = @"cell";
    }
    else if (IS_IPHONE_6) {
        simpleTableIdentifier1 = @"cell6";
    }
    else if (IS_IPHONE_6P) {
        simpleTableIdentifier1 = @"cell6P";
    }
    workoutCell *workoutcell = [collectionView dequeueReusableCellWithReuseIdentifier:simpleTableIdentifier1 forIndexPath:indexPath];
    workoutsDataObjects *workoutDataInfo = [workoutData objectAtIndex:indexPath.row];
    
    //Setting the UI elements.
    workoutcell.workoutName.text = workoutDataInfo.name;
    workoutcell.difficulty.text = workoutDataInfo.Difficulty;
    
    UIImageView *workoutImageView = (UIImageView *)[workoutcell viewWithTag:800];
    
    //Now setting the difficuly dot.
    if ([workoutcell.difficulty.text isEqualToString:@"Easy"]) {
        UIImageView *cellImageView = (UIImageView *)[workoutcell viewWithTag:100];
        cellImageView.image = [UIImage imageNamed:@"easy.png"];
        workoutcell.difficulty.textColor = STAYHEALTHY_GREEN;
    }
    else if ([workoutcell.difficulty.text isEqualToString:@"Intermediate"]) {
        UIImageView *cellImageView = (UIImageView *)[workoutcell viewWithTag:100];
        cellImageView.image = [UIImage imageNamed:@"inter.png"];
        workoutcell.difficulty.textColor = STAYHEALTHY_BLUE;
        if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
            workoutcell.difficulty.text = @"Inter.";
        }
        else {
            workoutcell.difficulty.text = @"Intermediate";
        }
    }
    else if ([workoutcell.difficulty.text isEqualToString:@"Hard"]) {
        UIImageView *cellImageView = (UIImageView *)[workoutcell viewWithTag:100];
        cellImageView.image = [UIImage imageNamed:@"hard.png"];
        workoutcell.difficulty.textColor = STAYHEALTHY_RED;
    }
    else {
        UIImageView *cellImageView = (UIImageView *)[workoutcell viewWithTag:100];
        cellImageView.image = [UIImage imageNamed:@"veryhard.png"];
        workoutcell.difficulty.textColor = [UIColor blackColor];
    }

    //Loading the data into the arrays.
    workoutImages = [CommonDataOperations returnExerciseData:[self buildQuery:workoutsCollectionView tableView:nil indexPath:indexPath] databaseName:STAYHEALTHY_DATABASE database:db];
    
    sqlColumns *workoutImageInfo = [workoutImages objectAtIndex:1];
    workoutImageView.image = [UIImage imageNamed:workoutImageInfo.File];
    
    [CommonSetUpOperations styleCollectionViewCell:workoutcell];
    
    return workoutcell;
}

#pragma mark TablevView Methods.


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75.0f;
}
//Start of LIST VIEW
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Show the amount of items that are in the array.
    return workoutData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier;
    simpleTableIdentifier = @"cell";

 
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    workoutsDataObjects *workoutDataInfo = [workoutData objectAtIndex:indexPath.row];
    workoutsDataObjects *objects = [workoutData objectAtIndex:indexPath.row];
    typeArrayDisplay = [objects.workoutType componentsSeparatedByString:@","];
    arrayCountExercises = [objects.exerciseIDs componentsSeparatedByString:@","];
    
    UILabel *name = (UILabel *)[cell viewWithTag:700];
    
    UILabel *type = (UILabel *)[cell viewWithTag:702];
    UILabel *numExercises = (UILabel *)[cell viewWithTag:703];
    
    UIImageView *workoutImageView1 = (UIImageView *)[cell viewWithTag:22];
    UIView *difficultyView = (UIView *)[cell viewWithTag:21];
    
    type.text = [NSString stringWithFormat:@"%@",typeArrayDisplay[0]];
    name.text = workoutDataInfo.name;
    numExercises.text = [NSString stringWithFormat:@"%ld",(long)arrayCountExercises.count];
    
    
    if ([workoutDataInfo.Difficulty isEqualToString:@"Easy"])
        difficultyView.backgroundColor = STAYHEALTHY_GREEN;
    else if ([workoutDataInfo.Difficulty isEqualToString:@"Intermediate"]) {
        difficultyView.backgroundColor = STAYHEALTHY_BLUE;
    }
    else if ([workoutDataInfo.Difficulty isEqualToString:@"Hard"])
        difficultyView.backgroundColor = STAYHEALTHY_RED;
    else
        difficultyView.backgroundColor = [UIColor blackColor];
    
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = STAYHEALTHY_WHITE;
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];
    
    workoutImages = [CommonDataOperations returnExerciseData:[self buildQuery:nil tableView:workoutsTableview indexPath:indexPath] databaseName:STAYHEALTHY_DATABASE database:db];
    
    sqlColumns *workoutImageInfo = [workoutImages objectAtIndex:0];

    workoutImageView1.image = [UIImage imageNamed:workoutImageInfo.File];
    return cell;
}

//DESELECT THE CELL, IF YOU DON"T CALL THIS METHOD THEN IT WON'T DESELECT.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"workoutDetailTable" sender:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"workoutDetail" sender:nil];
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark Query Building

-(NSString*)buildQuery:(UICollectionView*)collectionView tableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath {
    
    exerciseQuery = @"";

    workoutsDataObjects *workoutDataInfo = [workoutData objectAtIndex:indexPath.row];
    exerciseIdentifiers = [workoutDataInfo.exerciseIDs componentsSeparatedByString:@","];
    exerciseType = [workoutDataInfo.exerciseTypes componentsSeparatedByString:@","];
    
    //The for loop that creates the query.
    for (int i=0; i<exerciseIdentifiers.count; i++) {
        exerciseQuery = [[exerciseQuery stringByAppendingString:@" "] stringByAppendingString:[NSString stringWithFormat:@"SELECT * FROM %@exercises WHERE ID = %@", exerciseType[i], exerciseIdentifiers[i]]];
        
        if (i != exerciseIdentifiers.count-1)
            exerciseQuery = [[exerciseQuery stringByAppendingString:@" "] stringByAppendingString:@"UNION ALL"];
        else
            exerciseQuery = [[exerciseQuery stringByAppendingString:@" "]stringByAppendingString:@"ORDER BY Name COLLATE NOCASE"];
    }
    return exerciseQuery;
}

#pragma mark Prepare For Segue

-(void)sendData:(NSIndexPath*)indexPath dataArray:(NSArray*)dataArray segue:(UIStoryboardSegue*)segue query:(NSString*)builtQuery {
    workoutsDataObjects *objects = [dataArray objectAtIndex:indexPath.row];
    typeArrayData = [objects.workoutType componentsSeparatedByString:@","];
    WorkoutDetailViewController *destViewController = segue.destinationViewController;
    destViewController.summary = objects.summary;
    destViewController.titleText = objects.name;
    destViewController.genderText = objects.gender;
    destViewController.difficultyText = objects.Difficulty;
    destViewController.typeArray = typeArrayData;
    destViewController.queryText = builtQuery;
    destViewController.sportText = objects.Sports;
    destViewController.muscleText = objects.targetMuscles;
    destViewController.equipText = objects.equipment;
    destViewController.workoutID = objects.ID;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
     WorkoutDetailViewController *destViewController = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"workoutDetail"]) {
        NSArray *arrayOfIndexPaths = [workoutsCollectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [arrayOfIndexPaths firstObject];
        [self sendData:indexPath dataArray:workoutData segue:segue query:[self buildQuery:workoutsCollectionView tableView:nil indexPath:indexPath]];
        destViewController.hidesBottomBarWhenPushed = YES;
    }
    else if ([segue.identifier isEqualToString:@"workoutDetailTable"]) {
        NSIndexPath *indexPath = [workoutsTableview indexPathForSelectedRow];
        [self sendData:indexPath dataArray:workoutData segue:segue query:[self buildQuery:nil tableView:workoutsTableview indexPath:indexPath]];
        destViewController.hidesBottomBarWhenPushed = YES;
    }
}

#pragma mark Utilities

//These two methods/buttons control the hidding of the views.
-(IBAction)collectionViewUpdate:(id)sender {
    workoutsTableview.hidden = YES;
    workoutsCollectionView.hidden = NO;
    UIBarButtonItem *tableview = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"TableviewIcon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(tableViewUpdate:)];
    NSArray *actionButtonItems = @[tableview];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
}

-(IBAction)tableViewUpdate:(id)sender {
    workoutsTableview.hidden = NO;
    workoutsCollectionView.hidden = YES;
    UIBarButtonItem *collectionview = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"CollectionviewIcon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(collectionViewUpdate:)];
    NSArray *actionButtonItems = @[collectionview];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
}

//If the user leaves the page then dismiss the all TSMessages.
-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}


@end
