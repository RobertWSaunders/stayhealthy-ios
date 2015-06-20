//
//  FavoritesViewController.m
//  StayHealthy
//
//  Created by Student on 1/20/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

/***************************************************IMPLEMENTATION FILE***************************************/

#import "FavoritesViewController.h"


@interface FavoritesViewController ()


@end

@implementation FavoritesViewController

-(void)viewDidLoad
{
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewDidLayoutSubviews {
    /*
    CGRect frame= segmentedControl.frame;
    [segmentedControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 40)];
     */
}

-(void)viewWillAppear:(BOOL)animated {
    
    
    
    //Load the data into the arrays.
    favoriteStretchExercises = [CommonDataOperations checkIfExerciseIsFavorite:@"SELECT * FROM FavoriteExercises WHERE ExerciseType = 'stretchingexercises'" databaseName:@"UserDB1.sqlite" database:db];
    favoriteStrengthExercises = [CommonDataOperations checkIfExerciseIsFavorite:@"SELECT * FROM FavoriteExercises WHERE ExerciseType = 'strengthexercises'" databaseName:@"UserDB1.sqlite" database:db];
    favoriteWarmupExercises = [CommonDataOperations checkIfExerciseIsFavorite:@"SELECT * FROM FavoriteExercises WHERE ExerciseType = 'warmup'" databaseName:@"UserDB1.sqlite" database:db];
    favoriteWorkouts = [CommonDataOperations retreiveWorkoutInfo:@"SELECT * FROM PrebuiltWorkoutData WHERE isFavorite = 'TRUE'" databaseName:@"UserDB1.sqlite" database:db];
    
    //If there are no favorites then perform a message telling the user.
    if ( favoriteStrengthExercises.count == 0 &&  favoriteStretchExercises.count == 0 &&  favoriteWarmupExercises.count == 0 &&  favoriteWorkouts.count == 0)
        [CommonSetUpOperations performTSMessage:@"You have no favorites. To add one, on an exercise page simply press the star in the top right corner. If it is favorited then the star will be filled." message:nil viewController:self];
    
    //[CommonSetUpOperations setUpSidebarMenu:sidebarIcon viewController:self];
    [self setSegmentedControlText];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"Fav"])
    {
        [TSMessage showNotificationInViewController:self
                                              title:@"Welcome to the favorites page. Here you can view all your favorited exercises and workouts. To favorite a workout or exercise just tap the star on any workout or exercise detail page. You can toggle between the different types of exercises with the control at the top. Tap this message to dismiss."
                                           subtitle:nil
                                              image:nil
                                               type:TSMessageNotificationTypeMessage
                                           duration:TSMessageNotificationDurationEndless
                                           callback:nil
                                        buttonTitle:nil
                                     buttonCallback:nil
                                         atPosition:TSMessageNotificationPositionTop
                                canBeDismisedByUser:YES];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Fav"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [strengthCollectionView reloadData];
    [stretchingCollectionView reloadData];
    [warmupCollectionView reloadData];
    [workoutsCollectionView reloadData];
    
    [scroller setContentSize:CGSizeMake(1280, 479)];
    [scroller setPagingEnabled:YES];
    [scroller setScrollEnabled:YES];
    
    scroller.layer.masksToBounds = NO;
    scroller.layer.shadowOpacity = 0.10f;
    scroller.layer.shadowRadius = 4.0f;
    scroller.layer.shadowOffset = CGSizeZero;
    scroller.layer.shadowPath = [UIBezierPath bezierPathWithRect:scroller.bounds].CGPath;


}

-(void)setSegmentedControlText {
    /*NSDictionary *attributes = [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"Avenir" size:12]
                                                           forKey:NSFontAttributeName];
    [segmentedControl setTitleTextAttributes:attributes
                                    forState:UIControlStateNormal];
     */
    [segmentedControl setTitle:[NSString stringWithFormat:@"Strength (%ld)",(long)favoriteStrengthExercises.count] forSegmentAtIndex:0];
    [segmentedControl setTitle:[NSString stringWithFormat:@"Stretch (%ld)",(long)favoriteStretchExercises.count] forSegmentAtIndex:1];
    [segmentedControl setTitle:[NSString stringWithFormat:@"Warmup (%ld)",(long)favoriteWarmupExercises.count] forSegmentAtIndex:2];
    [segmentedControl setTitle:[NSString stringWithFormat:@"Workouts (%ld)",(long)favoriteWorkouts.count] forSegmentAtIndex:3];
}

-(void)backButtonPressed {
    //[self favoriteWorkouts];
    [ workoutsCollectionView reloadData];
}


-(NSString*)buildWorkoutQuery {
    NSString *workoutQuery = @"";
    
    NSMutableArray *arrayOfIds = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <  favoriteWorkouts.count; i++) {
        workoutFavoriteObjects *favoriteObject;
        favoriteObject = [ favoriteWorkouts objectAtIndex:i];
        [arrayOfIds addObject:favoriteObject.WorkoutID];
    }
    
    for (int i = 0; i < arrayOfIds.count; i++) {
    NSString *workoutID = [arrayOfIds objectAtIndex:i];
    
    workoutQuery = [[workoutQuery stringByAppendingString:@" "] stringByAppendingString:[NSString stringWithFormat:@"SELECT * FROM PrebuiltWorkouts WHERE ID = '%@'", workoutID]];
    
    if (i != arrayOfIds.count-1)
        workoutQuery = [[workoutQuery stringByAppendingString:@" "] stringByAppendingString:@"UNION ALL"];
    else
        workoutQuery = [[workoutQuery stringByAppendingString:@" "]stringByAppendingString:@"ORDER BY Name COLLATE NOCASE"];
    }
    return workoutQuery;
}

//Return the number of items in the collectionview.
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ( strengthCollectionView == collectionView)
        return [favoriteStrengthExercises count];
    else if ( stretchingCollectionView == collectionView)
        return [favoriteStretchExercises count];
    else if ( warmupCollectionView == collectionView)
        return [favoriteWarmupExercises count];
    else
        return [favoriteWorkouts count];
    return 0;
}

//Generates the query to search for the favorited exercises, then returns it.
-(NSString*)generateQuery:(NSMutableArray*)countArray{
    favoriteQuery = @"";
    NSString *exerciseTypes;
    for (int i = 0; i < countArray.count; i++) {
        favoriteColumns *favorites = [countArray objectAtIndex:i];
        if ([favorites.exerciseType isEqualToString:@"warmup"])
            exerciseTypes = @"warmupexercises";
        if ([favorites.exerciseType isEqualToString:@"stretchingexercises"])
            exerciseTypes = @"stretchingexercises";
        if ([favorites.exerciseType isEqualToString:@"strengthexercises"])
            exerciseTypes = @"strengthexercises";
        favoriteQuery = [[favoriteQuery stringByAppendingString:@" "] stringByAppendingString:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE ID = '%@'", exerciseTypes, favorites.exerciseID]];
        
        if (i != countArray.count-1) {
            favoriteQuery = [[favoriteQuery stringByAppendingString:@" "] stringByAppendingString:@"UNION ALL"];
        }
        else {
            favoriteQuery = [[favoriteQuery stringByAppendingString:@" "]stringByAppendingString:@"ORDER BY Name COLLATE NOCASE"];
        }
    }
    return favoriteQuery;
}


//Format the UICollectionViewCells
-(UICollectionViewCell*)formatCells:(NSIndexPath *)indexPath second:(FavoritesCell*)favoritesCell third:(NSString*)identifier collectionview:(UICollectionView*)collectionView array:(NSMutableArray*)arrayData{

    favoritesCell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    sqlColumns *favorite = [arrayData objectAtIndex:indexPath.row];

    favoritesCell.nameLabel.text = favorite.Name;
    favoritesCell.difficultyLabel.text = favorite.Difficulty;
    favoritesCell.equipmentLabel.text = favorite.Equipment;
    
    //Load the exercise images in the background, then fade them in.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
        UIImage *image = [UIImage imageNamed:favorite.File];
        dispatch_sync(dispatch_get_main_queue(), ^(void) {
            UIImageView* cellImageView = favoritesCell.exerciseImage;
            cellImageView.image = image;
            cellImageView.alpha = 0.0;
            [UIView animateWithDuration:0.5 animations:^{
                cellImageView.alpha = 1.0;
            }];
        });
    });
    
    if ([favoritesCell.difficultyLabel.text isEqualToString:@"Easy"])
        favoritesCell.difficultyLabel.textColor = STAYHEALTHY_GREEN;
    
    if ([favoritesCell.difficultyLabel.text isEqualToString:@"Intermediate"]) {
        favoritesCell.difficultyLabel.textColor = STAYHEALTHY_DARKERBLUE;
        
        favoritesCell.difficultyLabel.text = @"Inter";
    }
    if ([favoritesCell.difficultyLabel.text isEqualToString:@"Hard"])
        favoritesCell.difficultyLabel.textColor = STAYHEALTHY_RED;
    
    if ([favoritesCell.difficultyLabel.text isEqualToString:@"Very Hard"])
        favoritesCell.difficultyLabel.textColor = STAYHEALTHY_RED;
    
    
    NSString *string = favoritesCell.equipmentLabel.text;
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    if ([trimmedString isEqualToString:@"null"]) {
        favoritesCell.equipmentLabel.text = @"No Equip";
    }
    return favoritesCell;
}

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



//Style the cells and just put them together, not all done in this method, mostly outsourced.
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)
indexPath {
    NSString *idetifier1;
    NSString *idetifier2;
    NSString *idetifier3;
    NSString *idetifier4;
    if ( strengthCollectionView == collectionView) {
        if (IS_IPHONE_6P) {
            idetifier1 = @"strength6P";
        }
        else if (IS_IPHONE_6) {
            idetifier1 = @"strength6";
        }
        else if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
            idetifier1 = @"strength1";
        }
        
        FavoritesCell *favoritesCell = [strengthCollectionView dequeueReusableCellWithReuseIdentifier:idetifier1 forIndexPath:indexPath];
        
        favoriteStrengthExercisesData = [CommonDataOperations returnExerciseData:[self generateQuery:favoriteStrengthExercises] databaseName:@"Stayhealthyexercises.sqlite" database:db];
        
        sqlColumns *favorite = [favoriteStrengthExercisesData objectAtIndex:indexPath.row];
        
        favoritesCell.nameLabel.text = favorite.Name;
        favoritesCell.difficultyLabel.text = favorite.Difficulty;
        favoritesCell.equipmentLabel.text = favorite.Equipment;
        
        //Load the exercise images in the background, then fade them in.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
            UIImage *image = [UIImage imageNamed:favorite.File];
            dispatch_sync(dispatch_get_main_queue(), ^(void) {
                UIImageView* cellImageView = favoritesCell.exerciseImage;
                cellImageView.image = image;
                cellImageView.alpha = 0.0;
                [UIView animateWithDuration:0.5 animations:^{
                    cellImageView.alpha = 1.0;
                }];
            });
        });
        
        if ([favoritesCell.difficultyLabel.text isEqualToString:@"Easy"])
            favoritesCell.difficultyLabel.textColor = STAYHEALTHY_GREEN;
        
        if ([favoritesCell.difficultyLabel.text isEqualToString:@"Intermediate"]) {
            favoritesCell.difficultyLabel.textColor = STAYHEALTHY_DARKERBLUE;
            if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
                favoritesCell.difficultyLabel.text = @"Inter.";
            }
            else {
                favoritesCell.difficultyLabel.text = @"Intermediate";
            }
            
        }
        if ([favoritesCell.difficultyLabel.text isEqualToString:@"Hard"])
            favoritesCell.difficultyLabel.textColor = STAYHEALTHY_RED;
        
        if ([favoritesCell.difficultyLabel.text isEqualToString:@"Very Hard"])
            favoritesCell.difficultyLabel.textColor = STAYHEALTHY_RED;
        
        
        NSString *string = favoritesCell.equipmentLabel.text;
        NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        if ([trimmedString isEqualToString:@"null"]) {
            favoritesCell.equipmentLabel.text = @"No Equip";
        }
        
        [CommonSetUpOperations styleCollectionViewCell:favoritesCell];
        return favoritesCell;
    }
    else if ( warmupCollectionView == collectionView) {
        
        if (IS_IPHONE_6P) {
            idetifier2 = @"warmup6P";
        }
        else if (IS_IPHONE_6) {
            idetifier2 = @"warmup6";
        }
        else if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
            idetifier2 = @"warmup1";
        }
        
        FavoritesCell *favoritesCell = [ warmupCollectionView dequeueReusableCellWithReuseIdentifier:idetifier2 forIndexPath:indexPath];
        
        favoriteWarmupExercisesData = [CommonDataOperations returnExerciseData:[self generateQuery:favoriteWarmupExercises] databaseName:@"Stayhealthyexercises.sqlite" database:db];
        
        sqlColumns *favorite = [favoriteWarmupExercisesData objectAtIndex:indexPath.row];
        
        favoritesCell.nameLabel.text = favorite.Name;
        favoritesCell.difficultyLabel.text = favorite.Difficulty;
        favoritesCell.equipmentLabel.text = favorite.Equipment;
        
        //Load the exercise images in the background, then fade them in.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
            UIImage *image = [UIImage imageNamed:favorite.File];
            dispatch_sync(dispatch_get_main_queue(), ^(void) {
                UIImageView* cellImageView = favoritesCell.exerciseImage;
                cellImageView.image = image;
                cellImageView.alpha = 0.0;
                [UIView animateWithDuration:0.5 animations:^{
                    cellImageView.alpha = 1.0;
                }];
            });
        });
        
        if ([favoritesCell.difficultyLabel.text isEqualToString:@"Easy"])
            favoritesCell.difficultyLabel.textColor = STAYHEALTHY_GREEN;
        
        if ([favoritesCell.difficultyLabel.text isEqualToString:@"Intermediate"]) {
            favoritesCell.difficultyLabel.textColor = STAYHEALTHY_DARKERBLUE;
            if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
                favoritesCell.difficultyLabel.text = @"Inter.";
            }
            else {
                favoritesCell.difficultyLabel.text = @"Intermediate";
            }
        }
        if ([favoritesCell.difficultyLabel.text isEqualToString:@"Hard"])
            favoritesCell.difficultyLabel.textColor = STAYHEALTHY_RED;
        
        if ([favoritesCell.difficultyLabel.text isEqualToString:@"Very Hard"])
            favoritesCell.difficultyLabel.textColor = STAYHEALTHY_RED;
        
        
        NSString *string = favoritesCell.equipmentLabel.text;
        NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        if ([trimmedString isEqualToString:@"null"]) {
            favoritesCell.equipmentLabel.text = @"No Equip";
        }
        
        [CommonSetUpOperations styleCollectionViewCell:favoritesCell];
        
        return favoritesCell;
    }
    else if ( stretchingCollectionView == collectionView) {
        
        if (IS_IPHONE_6P) {
            idetifier3 = @"stretching6P";
        }
        else if (IS_IPHONE_6) {
            idetifier3 = @"stretching6";
        }
        else if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
            idetifier3 = @"stretching1";
        }
        
        FavoritesCell *favoritesCell = [ stretchingCollectionView dequeueReusableCellWithReuseIdentifier:idetifier3 forIndexPath:indexPath];
        
        favoriteStretchExercisesData = [CommonDataOperations returnExerciseData:[self generateQuery:favoriteStretchExercises] databaseName:@"Stayhealthyexercises.sqlite" database:db];
        
        sqlColumns *favorite = [favoriteStretchExercisesData objectAtIndex:indexPath.row];
        
        favoritesCell.nameLabel.text = favorite.Name;
        favoritesCell.difficultyLabel.text = favorite.Difficulty;
        favoritesCell.equipmentLabel.text = favorite.Equipment;
        
        //Load the exercise images in the background, then fade them in.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^(void) {
            UIImage *image = [UIImage imageNamed:favorite.File];
            dispatch_sync(dispatch_get_main_queue(), ^(void) {
                UIImageView* cellImageView = favoritesCell.exerciseImage;
                cellImageView.image = image;
                cellImageView.alpha = 0.0;
                [UIView animateWithDuration:0.5 animations:^{
                    cellImageView.alpha = 1.0;
                }];
            });
        });
        
        if ([favoritesCell.difficultyLabel.text isEqualToString:@"Easy"])
            favoritesCell.difficultyLabel.textColor = STAYHEALTHY_GREEN;
        
        if ([favoritesCell.difficultyLabel.text isEqualToString:@"Intermediate"]) {
            favoritesCell.difficultyLabel.textColor = STAYHEALTHY_DARKERBLUE;
            if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
                favoritesCell.difficultyLabel.text = @"Inter.";
            }
            else {
                favoritesCell.difficultyLabel.text = @"Intermediate";
            }
        }
        if ([favoritesCell.difficultyLabel.text isEqualToString:@"Hard"])
            favoritesCell.difficultyLabel.textColor = STAYHEALTHY_RED;
        
        if ([favoritesCell.difficultyLabel.text isEqualToString:@"Very Hard"])
            favoritesCell.difficultyLabel.textColor = STAYHEALTHY_RED;
        
        
        NSString *string = favoritesCell.equipmentLabel.text;
        NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        if ([trimmedString isEqualToString:@"null"]) {
            favoritesCell.equipmentLabel.text = @"No Equip";
        }
        
        [CommonSetUpOperations styleCollectionViewCell:favoritesCell];
        
        return favoritesCell;
        }

    else if ( workoutsCollectionView == collectionView) {
        if (IS_IPHONE_6P) {
            idetifier4 = @"workoutCell6P";
        }
        else if (IS_IPHONE_6) {
            idetifier4 = @"workoutCell6";
        }
        else if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
            idetifier4 = @"workoutCell";
        }
        
        workoutCell *workoutsCell = [ workoutsCollectionView dequeueReusableCellWithReuseIdentifier:idetifier4 forIndexPath:indexPath];
        
        favoriteWorkoutsData = [CommonDataOperations returnWorkoutData:[self buildWorkoutQuery] databaseName:@"Stayhealthyexercises.sqlite" database:db];
        
        workoutsDataObjects *workoutDataInfo = [favoriteWorkoutsData objectAtIndex:indexPath.row];
        
        workoutsCell.workoutName.text = workoutDataInfo.name;
        workoutsCell.difficulty.text = workoutDataInfo.Difficulty;
        
        UIImageView *workoutImageView = (UIImageView *)[workoutsCell viewWithTag:800];
        
        //Now setting the difficuly dot.
        if ([workoutsCell.difficulty.text isEqualToString:@"Easy"]) {
            UIImageView *cellImageView = (UIImageView *)[workoutsCell viewWithTag:100];
            cellImageView.image = [UIImage imageNamed:@"easy.png"];
            workoutsCell.difficulty.textColor = STAYHEALTHY_GREEN;
        }
        else if ([workoutsCell.difficulty.text isEqualToString:@"Intermediate"]) {
            UIImageView *cellImageView = (UIImageView *)[workoutsCell viewWithTag:100];
            cellImageView.image = [UIImage imageNamed:@"inter.png"];
            workoutsCell.difficulty.textColor = STAYHEALTHY_DARKERBLUE;
            if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
                workoutsCell.difficulty.text = @"Inter.";
            }
            else {
                workoutsCell.difficulty.text = @"Intermediate";
            }
        }
        else if ([workoutsCell.difficulty.text isEqualToString:@"Hard"]) {
            UIImageView *cellImageView = (UIImageView *)[workoutsCell viewWithTag:100];
            cellImageView.image = [UIImage imageNamed:@"hard.png"];
            workoutsCell.difficulty.textColor = STAYHEALTHY_RED;
        }
        else {
            UIImageView *cellImageView = (UIImageView *)[workoutsCell viewWithTag:100];
            cellImageView.image = [UIImage imageNamed:@"veryhard.png"];
            workoutsCell.difficulty.textColor = [UIColor blackColor];
        }

        //Get the workout exercises data, but more importantly focused on retreiving the images.
        workoutImages = [CommonDataOperations returnExerciseData:[self buildQuery: workoutsCollectionView tableView:nil indexPath:indexPath isFavoriteCollectionView:YES] databaseName:@"Stayhealthyexercises.sqlite" database:db];
        
        sqlColumns *workoutImageInfo = [workoutImages objectAtIndex:1];
        workoutImageView.image = [UIImage imageNamed:workoutImageInfo.File];
        [CommonSetUpOperations styleCollectionViewCell:workoutsCell];
        return workoutsCell;
    }
    return nil;
}
-(NSString*)buildQuery:(UICollectionView*)collectionView tableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath isFavoriteCollectionView:(BOOL)favoriteCollectionView{
    workoutsDataObjects *workoutDataInfo;
    NSString* exerciseQuery = @"";
    
    workoutDataInfo = [favoriteWorkoutsData objectAtIndex:indexPath.row];
    
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

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView ==  strengthCollectionView)
        [self displayPopup: strengthCollectionView array:favoriteStrengthExercisesData];
    else if (collectionView ==  stretchingCollectionView)
        [self displayPopup: stretchingCollectionView array:favoriteStretchExercisesData];
    else if (collectionView ==  warmupCollectionView)
        [self displayPopup: warmupCollectionView array:favoriteWarmupExercisesData];
   
}



-(void)sendData:(NSIndexPath*)indexPath dataArray:(NSArray*)dataArray segue:(UIStoryboardSegue*)segue query:(NSString*)builtQuery {
    workoutsDataObjects *objects = [dataArray objectAtIndex:indexPath.row];
    NSArray* typeArrayData = [objects.workoutType componentsSeparatedByString:@","];
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
    if ([segue.identifier isEqualToString:@"toWorkoutDetail"]) {
        NSArray *arrayOfIndexPaths = [workoutsCollectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [arrayOfIndexPaths firstObject];
        
        workoutsDataObjects *objects = [favoriteWorkoutsData objectAtIndex:indexPath.row];
        NSArray* typeArrayData = [objects.workoutType componentsSeparatedByString:@","];
        WorkoutDetailViewController *destViewController = segue.destinationViewController;
        destViewController.summary = objects.summary;
        destViewController.titleText = objects.name;
        destViewController.genderText = objects.gender;
        destViewController.difficultyText = objects.Difficulty;
        destViewController.typeArray = typeArrayData;
        destViewController.dummieText = [self buildQuery: workoutsCollectionView tableView:nil indexPath:indexPath isFavoriteCollectionView:NO];
        destViewController.queryText = [self buildQuery: workoutsCollectionView tableView:nil indexPath:indexPath isFavoriteCollectionView:NO];
        destViewController.sportText = objects.Sports;
        destViewController.muscleText = objects.targetMuscles;
        destViewController.equipText = objects.equipment;
        destViewController.workoutID = objects.ID;

    }
}


-(void)displayPopup:(UICollectionView*)collectionview array:(NSMutableArray*)arrayData {
    PopupViewController *secondDetailViewController = [[PopupViewController alloc] initWithNibName:@"PopupViewController" bundle:nil];
    secondDetailViewController.delegate = self;
    NSArray *arrayOfIndexPaths = [collectionview indexPathsForSelectedItems];
    NSIndexPath *indexPath1 = [arrayOfIndexPaths firstObject];
    sqlColumns *exercise = [arrayData objectAtIndex:indexPath1.row];
    secondDetailViewController.image = [UIImage imageNamed:exercise.File];
    secondDetailViewController.text = exercise.Description;
    secondDetailViewController.title1 = exercise.Name;
    secondDetailViewController.reps = exercise.Reps;
    secondDetailViewController.sets = exercise.Sets;
    secondDetailViewController.material = exercise.Equipment;
    secondDetailViewController.difficulty = exercise.Difficulty;
    secondDetailViewController.pri = exercise.PrimaryMuscle;
    secondDetailViewController.sec = exercise.SecondaryMuscle;
    secondDetailViewController.ident = exercise.ID;
    secondDetailViewController.exerciseType = exercise.ExerciseType;
    [self presentPopupViewController:secondDetailViewController animationType:MJPopupViewAnimationFade];
}


//Hides or shows the view dependant on the segment index.
- (IBAction)segmentValueChanged:(UISegmentedControl*)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            strengthCollectionView.hidden = NO;
            stretchingCollectionView.hidden = YES;
            warmupCollectionView.hidden = YES;
            workoutsCollectionView.hidden = YES;
            
            //[scroller setContentOffset:CGPointMake(0, 0)];
            break;
        case 1:
            strengthCollectionView.hidden = YES;
            stretchingCollectionView.hidden = NO;
            warmupCollectionView.hidden = YES;
            workoutsCollectionView.hidden = YES;
             //[scroller setContentOffset:CGPointMake(320, 0)];
            break;
        case 2:
            
            strengthCollectionView.hidden = YES;
            stretchingCollectionView.hidden = YES;
            warmupCollectionView.hidden = NO;
            workoutsCollectionView.hidden = YES;
            //[scroller setContentOffset:CGPointMake(640, 0)];
            break;
        case 3:
            strengthCollectionView.hidden = YES;
            stretchingCollectionView.hidden = YES;
            warmupCollectionView.hidden = YES;
            workoutsCollectionView.hidden = NO;
            //[scroller setContentOffset:CGPointMake(960, 0)];
            break;
        default:
            break;
    }
}

//Finally if the view is dissappering dismiss all TSMessages
-(void)viewDidDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}

- (void)cancelButtonClicked:(PopupViewController *)aSecondDetailViewController
{
    
    //Load the data into the arrays.
    favoriteStretchExercises = [CommonDataOperations checkIfExerciseIsFavorite:@"SELECT * FROM FavoriteExercises WHERE ExerciseType = 'stretchingexercises'" databaseName:@"UserDB1.sqlite" database:db];
    favoriteStrengthExercises = [CommonDataOperations checkIfExerciseIsFavorite:@"SELECT * FROM FavoriteExercises WHERE ExerciseType = 'strengthexercises'" databaseName:@"UserDB1.sqlite" database:db];
    favoriteWarmupExercises = [CommonDataOperations checkIfExerciseIsFavorite:@"SELECT * FROM FavoriteExercises WHERE ExerciseType = 'warmup'" databaseName:@"UserDB1.sqlite" database:db];
    favoriteWorkouts = [CommonDataOperations retreiveWorkoutInfo:@"SELECT * FROM PrebuiltWorkoutData WHERE isFavorite = 'TRUE'" databaseName:@"UserDB1.sqlite" database:db];
    
    [strengthCollectionView reloadData];
    [stretchingCollectionView reloadData];
    [warmupCollectionView reloadData];
    [workoutsCollectionView reloadData];
    
    [self setSegmentedControlText];
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    //If there are no favorites then perform a message telling the user.
    if ( favoriteStrengthExercises.count == 0 &&  favoriteStretchExercises.count == 0 &&  favoriteWarmupExercises.count == 0 &&  favoriteWorkouts.count == 0)
        [CommonSetUpOperations performTSMessage:@"You have no favorites. To add one, on an exercise page simply press the star in the top right corner. If it is favorited then the star will be filled." message:nil viewController:self];

}

//If the user leaves the page then dismiss the all TSMessages.
-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (scrollView == scroller) {
        [scroller setContentOffset: CGPointMake(scroller.contentOffset.x, 0)];
        CGFloat pageWidth = scrollView.bounds.size.width;
        NSInteger pageNumber = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        segmentedControl.selectedSegmentIndex = pageNumber;
    }
  
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == scroller) {
        [scroller setScrollEnabled:NO];
    }
    else if (scrollView == strengthCollectionView || scrollView == stretchingCollectionView || scrollView == warmupCollectionView || scrollView == workoutsCollectionView) {
        [scroller setScrollEnabled:YES];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
     NSLog(@"H");
}
*/


@end
