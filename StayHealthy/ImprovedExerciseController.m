//
//  ImprovedExerciseController.m
//  StayHealthy
//
//  Created by Student on 3/23/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//

/*************************************************IMPLEMENTATION FILE************************************/
/*************************************************REVISIT FOR VERSION 2.0.0************************************/
//Incorporate better and more effective code. When bored. Think abput looking into lazy laoding.
//Also look at the updating problem, that dose not allow the user to keep their data, or favorites.

//Handle all imports in header file.
#import "ImprovedExerciseController.h"

@interface ImprovedExerciseController ()

@end

@implementation ImprovedExerciseController

//Synthesize.
@synthesize tableViewList,collectionViewGroup, exerciseData, list, groupCollection;

//Start of viewDidLoad, any thing that needs to be initiated.
- (void)viewDidLoad
{
    [super viewDidLoad];


    self.automaticallyAdjustsScrollViewInsets = NO;
    


    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunchOfPage"])
    {
        [TSMessage showNotificationInViewController:self
                                              title:@"Now that you have chosen a muscle and a exercise type you can view all the exercises. You can toggle between grid and list view with the button in the top right. Tap this message to dismiss."
                                           subtitle:nil
                                              image:nil
                                               type:TSMessageNotificationTypeMessage
                                           duration:TSMessageNotificationDurationEndless
                                           callback:nil
                                        buttonTitle:nil
                                     buttonCallback:nil
                                         atPosition:TSMessageNotificationPositionTop
                                canBeDismisedByUser:YES];

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLaunchOfPage"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    
    /*The UIBarButtons that toggle list or grid view*/
    //Note: Have to incorporate the save, and active stage.
    UIBarButtonItem *tableview = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"TableviewIcon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(tableViewUpdate:)];
        NSArray *actionButtonItems = @[tableview];
        self.navigationItem.rightBarButtonItems = actionButtonItems;
    
    //Loading arrays.And counting them for debugging.
    exerciseData = [CommonDataOperations returnExerciseData:self.query databaseName:@"Stayhealthyexercises.sqlite" database:db];
    
    //Checking if we have anything in the array, can let users know if we found anything.
    if (exerciseData.count == 0)
        _noResultsToDisplay = YES;
    
    for (int i=0; i < self.exerciseData.count; i++) {
        [self.groupCollection deselectItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:YES];
    }
    
    //Setting title text and logging query for search in database.
    self.title = self.titleText;
        
    //Have to set the tableview list to hidden or else the collectionview select dosen't work.
    self.tableViewList.hidden = YES;
    
    if (exerciseData.count == 0) {
        [TSMessage showNotificationInViewController:self
                                              title:@"No Exercises Were Found"
                                           subtitle:nil
                                              image:nil
                                               type:TSMessageNotificationTypeMessage
                                           duration:TSMessageNotificationDurationEndless
                                           callback:nil
                                        buttonTitle:nil
                                     buttonCallback:nil
                                         atPosition:TSMessageNotificationPositionTop
                                canBeDismisedByUser:YES];
    }

}

/******************************************COLLECTION VIEW METHODS*****************************************/
//Start of GRID VIEW

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE_6P) {
        return CGSizeMake(180.f, 246.f);
    }
    if (IS_IPHONE_6) {
        return CGSizeMake(160.f, 215.f);
    }
    return CGSizeMake(137.0f, 200.0f);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
        //Show the amount of items that are in the array.
        return [exerciseData count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ExerciseCollectionCell *exerciseCell;
    
    if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
        exerciseCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"exerciseCollectionCell" forIndexPath:indexPath];
    }
    else if (IS_IPHONE_6P) {
        exerciseCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"exerciseCollectionCell6P" forIndexPath:indexPath];
    }
    else if (IS_IPHONE_6) {
        exerciseCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"exerciseCollectionCell6" forIndexPath:indexPath];
    }

    sqlColumns *exercise = [self.exerciseData objectAtIndex:indexPath.row];
    
    exerciseCell.exerciseName.text = exercise.Name;
    exerciseCell.difficulty.text = exercise.Difficulty;
    exerciseCell.equipment.text = exercise.Equipment;
    
    //Load the exercise images in the background.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        UIImage *image = [UIImage imageNamed:exercise.File];
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            UIImageView* cellImageView = exerciseCell.exerciseImage;
            cellImageView.image = image;
            cellImageView.alpha = 0.0;
            [UIView animateWithDuration:0.8 animations:^{
                cellImageView.alpha = 1.0;
            }];
        });
    });
    
    NSString *string = exercise.Equipment;
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    if ([trimmedString isEqualToString:@"null"]) {
        exerciseCell.equipment.text = @"None";
    }
    if ([exerciseCell.difficulty.text isEqualToString:@"Easy"]) {
        exerciseCell.difficulty.textColor = STAYHEALTHY_GREEN;
    }
    if ([exerciseCell.difficulty.text isEqualToString:@"Intermediate"]) {
        exerciseCell.difficulty.textColor = STAYHEALTHY_DARKERBLUE;
        if (IS_IPHONE_6P || IS_IPHONE_6) {
              exerciseCell.difficulty.text = @"Intermediate";
        }
        else {
              exerciseCell.difficulty.text = @"Inter.";
        }
      
    }
    if ([exerciseCell.difficulty.text isEqualToString:@"Hard"]) {
        exerciseCell.difficulty.textColor = STAYHEALTHY_RED;
    }
    if ([exerciseCell.difficulty.text isEqualToString:@"Very Hard"]) {
        exerciseCell.difficulty.textColor = [UIColor blackColor];
    }
    
    [CommonSetUpOperations styleCollectionViewCell:exerciseCell];
    

    return exerciseCell;
}

/******************************************TABLE VIEW METHODS*****************************************/
//Start of LIST VIEW
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Show the amount of items that are in the array.
    return [exerciseData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"exerciseTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    sqlColumns *exercise = [self.exerciseData objectAtIndex:indexPath.row];
    
    UILabel *exerciseName = (UILabel *)[cell viewWithTag:101];
    exerciseName.text = exercise.Name;
    
    UILabel *equipment = (UILabel *)[cell viewWithTag:102];
    equipment.text = exercise.Equipment;
    NSString *string = exercise.Equipment;
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    if ([trimmedString isEqualToString:@"null"]) {
        equipment.text = @"No Equipment";
    }
    
    UILabel *difficulty = (UILabel *)[cell viewWithTag:103];
    difficulty.text = exercise.Difficulty;
    
    if ([difficulty.text isEqualToString:@"Easy"]) {
        difficulty.textColor = STAYHEALTHY_GREEN;
    }
    if ([difficulty.text isEqualToString:@"Intermediate"]) {
        difficulty.textColor = STAYHEALTHY_DARKERBLUE;
        
    }
    if ([difficulty.text isEqualToString:@"Hard"]) {
        difficulty.textColor = STAYHEALTHY_RED;
    }
    if ([difficulty.text isEqualToString:@"Very Hard"]) {
        difficulty.textColor = [UIColor blackColor];
    }

    //Load the exercise images in the background, then fade them in.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        UIImage *image = [UIImage imageNamed:exercise.File];
        
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            UIImageView* cellImageView = (UIImageView*)[cell viewWithTag:100];
            cellImageView.image = image;
            cellImageView.alpha = 0.0;
            [UIView animateWithDuration:0.5 animations:^{
                cellImageView.alpha = 1.0;
            }];
        });
    });
    
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = STAYHEALTHY_WHITE;
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];

    return cell;
}

-(void)performFavoriteSearch:(NSString*)exerciseType1 exerciseID:(NSString*)ID {
    NSString *query;
    NSString *type;
    if ([exerciseType1 isEqualToString:@"strength"])
        type = @"strengthexercises";
    else if ([exerciseType1 isEqualToString:@"warmup"])
        type = @"warmup";
    else if ([exerciseType1 isEqualToString:@"stretching"])
        type = @"stretchingexercises";
    query = [NSString stringWithFormat:@"SELECT * FROM FavoriteExercises WHERE ExerciseID = '%@' AND ExerciseType = '%@'",ID,type];
    checkIfFavorite = [CommonDataOperations checkIfExerciseIsFavorite:query databaseName:@"UserDB1.sqlite" database:db];
}

//Change the exercise type to something that is readable.
-(void)changeToReadable:(sqlColumns*)exercise {
    //Fetching all the arrays data from the findExercise.plist
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"findExercise" ofType:@"plist"];
    NSDictionary *findExerciseData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];

    NSArray *exerciseTypes = findExerciseData[@"exerciseTypes"];

    if ([exercise.ExerciseType isEqualToString:@"strength"])
        exerciseType = exerciseTypes[0];
    else if ([exercise.ExerciseType isEqualToString:@"stretching"])
        exerciseType = exerciseTypes[1];
    else if ([exercise.ExerciseType isEqualToString:@"warmup"])
        exerciseType = exerciseTypes[2];
}

//DESELECT THE CELL, IF YOU DON"T CALL THIS METHOD THEN IT WON'T DESELECT.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/***************************************SENDING DATA TO THE DETAIL VIEW******************************************/
//Here we handle the selection and movement to the next detail.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Handling it for the collectionview, the reason their differetn is the nsindexpath.
    if (tableViewList.hidden == YES) {
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
            
            //Somehow have to check if its a favorite or not.
            destViewController.favorite = exercise.isFavorite;
            destViewController.hidesBottomBarWhenPushed = YES;
        }
    }
    //Handling for the tableview.
    else {
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

/*These two methods/buttons control the hidding of the views.*/
//Note: In future look for better way to do this, so I don't load data twice, maybe lazy loading.
//Have now added so the UIBarButtons change instead of having two.
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

//If the user leaves the page then dismiss the all TSMessages.
-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}


@end
