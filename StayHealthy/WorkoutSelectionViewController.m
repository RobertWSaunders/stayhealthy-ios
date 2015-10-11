//
//  WorkoutSelectionViewController.m
//  StayHealthy
//
//  Created by Student on 1/9/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//


/*NOTES: For the future, i.e. version 2.0.0, make it so you can update the content collection views remotly
 from the internet, and also make it so that the arrays are stowed in the database, so it allows for easier updating.
 */

//The implementation of the header file and all of our defined properties.
#import "WorkoutSelectionViewController.h"

@interface WorkoutSelectionViewController ()

@end

//Start of implementation operations.
@implementation WorkoutSelectionViewController 

#pragma mark ViewDidLoad

- (void)viewDidLoad
{
    [super viewDidLoad];

self.automaticallyAdjustsScrollViewInsets = NO;

    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"WorkoutsFirstLaunch1"])
    {
        [TSMessage showNotificationInViewController:self
                                              title:@"Welcome to the workouts selection page. Here you can browse our favorite workouts, popular workouts, all the workouts, or dive into the different categories we have for you. Tap on this message to dismiss."
                                           subtitle:nil
                                              image:nil
                                               type:TSMessageNotificationTypeMessage
                                           duration:TSMessageNotificationDurationEndless
                                           callback:nil
                                        buttonTitle:nil
                                     buttonCallback:nil
                                         atPosition:TSMessageNotificationPositionTop
                                canBeDismisedByUser:YES];

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"WorkoutsFirstLaunch1"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    
    //Hidding the two views because they aren't the main, must be done for the segmented control, and just tidy.
    self.preBuiltWorkouts.hidden = YES;
    
    self.searchTextField.delegate = self;
    
    //Start of sidebutton actions and UI.

    self.searchButton.backgroundColor = STAYHEALTHY_BLUE;
    
    // Set the gesture for the menu swipe, it is a simple pan gesture.
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    //Fetching all the arrays data from the findExercise.plist
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"findExercise" ofType:@"plist"];
    NSDictionary *findData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    
    //Putting the data into the array.
    categories = findData[@"workoutCategories"];
    categoriesImage = findData[@"workoutCategoriesImages"];
    //Now filling all the arrays. From the arrays stored in the plist.
    workoutDifficulty = findData[@"workoutDifficulty"];
    sports = findData[@"sports"];
    workoutType = findData[@"workoutType"];
    equip = findData[@"workoutEquipment"];
    muscles = findData[@"muscleList"];

/*
    //Loading the data into the arrays.
    workoutData = [CommonDataOperations returnWorkoutData:@"SELECT * FROM PrebuiltWorkouts" databaseName:STAYHEALTHY_DATABASE database:db];
    favoritesWorkoutData = [CommonDataOperations returnWorkoutData:@"SELECT * FROM PrebuiltWorkouts WHERE ID = '1' OR ID = '49' OR ID = '3' OR ID = '7' OR ID = '11' OR ID = '42' OR ID = '36' OR ID = '6' OR ID = '15' OR ID = '16'" databaseName:STAYHEALTHY_DATABASE database:db];
    popularWorkoutData = [CommonDataOperations returnWorkoutData:@"SELECT * FROM PrebuiltWorkouts WHERE ID = '1' OR ID = '4' OR ID = '53' OR ID = '7' OR ID = '11' OR ID = '42' OR ID = '36' OR ID = '6' OR ID = '2' OR ID = '16'" databaseName:STAYHEALTHY_DATABASE database:db];
*/
}

#pragma mark CollectionView Datasource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView == popularCollectionView)
        return [popularWorkoutData count];
    else
        return [favoritesWorkoutData count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    //Our identifiers.
    //static NSString *categoriesIdentifier = @"catergoriesCell";
    static NSString *ourFavoritesIdentifier = @"favoritesCell";
    static NSString *popularIdentifier = @"popularCell";
 
    if (collectionView == self.ourFavoritesView){
        workoutCell *workoutcell = [collectionView dequeueReusableCellWithReuseIdentifier:ourFavoritesIdentifier forIndexPath:indexPath];
        /*
        workoutsDataObjects *workoutDataInfo = [favoritesWorkoutData objectAtIndex:indexPath.row];

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
            workoutcell.difficulty.text = @"Inter.";
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
        
        //Get the workout exercises data, but more importantly focused on retreiving the images.

         workoutImagesForCollection = [CommonDataOperations returnExerciseData:[self buildQuery:self.ourFavoritesView tableView:nil indexPath:indexPath isFavoriteCollectionView:YES] databaseName:STAYHEALTHY_DATABASE database:db];
        
        sqlColumns *workoutImageInfo = [workoutImagesForCollection objectAtIndex:1];
        workoutImageView.image = [UIImage imageNamed:workoutImageInfo.File];
        
        [CommonSetUpOperations styleCollectionViewCell:workoutcell];
        */
        return workoutcell;
    }
    else {
        workoutCell *workoutcell3 = [collectionView dequeueReusableCellWithReuseIdentifier:popularIdentifier forIndexPath:indexPath];
        /*
        workoutsDataObjects *workoutDataInfo = [popularWorkoutData objectAtIndex:indexPath.row];
        
        workoutcell3.workoutName.text = workoutDataInfo.name;
        workoutcell3.difficulty.text = workoutDataInfo.Difficulty;
        
        UIImageView *workoutImageView = (UIImageView *)[workoutcell3 viewWithTag:800];
        
        //Now setting the difficuly dot.
        if ([workoutcell3.difficulty.text isEqualToString:@"Easy"]) {
            UIImageView *cellImageView = (UIImageView *)[workoutcell3 viewWithTag:100];
            cellImageView.image = [UIImage imageNamed:@"easy.png"];
            workoutcell3.difficulty.textColor = STAYHEALTHY_GREEN;
        }
        else if ([workoutcell3.difficulty.text isEqualToString:@"Intermediate"]) {
            UIImageView *cellImageView = (UIImageView *)[workoutcell3 viewWithTag:100];
            cellImageView.image = [UIImage imageNamed:@"inter.png"];
            workoutcell3.difficulty.textColor = STAYHEALTHY_BLUE;
            workoutcell3.difficulty.text = @"Inter.";
        }
        else if ([workoutcell3.difficulty.text isEqualToString:@"Hard"]) {
            UIImageView *cellImageView = (UIImageView *)[workoutcell3 viewWithTag:100];
            cellImageView.image = [UIImage imageNamed:@"hard.png"];
            workoutcell3.difficulty.textColor = STAYHEALTHY_RED;
        }
        else {
            UIImageView *cellImageView = (UIImageView *)[workoutcell3 viewWithTag:100];
            cellImageView.image = [UIImage imageNamed:@"veryhard.png"];
            workoutcell3.difficulty.textColor = [UIColor blackColor];
        }
        
        //Get the workout exercises data, but more importantly focused on retreiving the images.
        
        workoutImagesForCollection = [CommonDataOperations returnExerciseData:[self buildQuery:self.ourFavoritesView tableView:nil indexPath:indexPath isFavoriteCollectionView:YES] databaseName:STAYHEALTHY_DATABASE database:db];
        
        sqlColumns *workoutImageInfo = [workoutImagesForCollection objectAtIndex:1];
        workoutImageView.image = [UIImage imageNamed:workoutImageInfo.File];
        
        [CommonSetUpOperations styleCollectionViewCell:workoutcell3];
        */
        return workoutcell3;
    }
     
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //Display the popup and give it the title.
    if (collectionView == self.ourFavoritesView) {
        [self performSegueWithIdentifier:@"workoutDetail" sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"workoutDetail1" sender:nil];
    }
}

#pragma mark Tableview Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == categoriesTableView)
        return 5;
    else
        return [workoutData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.allWorkoutsTableView) {
        NSString *CellIdentifier;

        CellIdentifier = @"workoutTableViewCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    /*
        workoutsDataObjects *workoutDataInfo = [workoutData objectAtIndex:indexPath.row];
        workoutsDataObjects *objects = [workoutData objectAtIndex:indexPath.row];
        typeArrayDisplay = [objects.workoutType componentsSeparatedByString:@","];
        arrayCountExercises = [objects.exerciseIDs componentsSeparatedByString:@","];
    */
        UILabel *name = (UILabel *)[cell viewWithTag:700];

        UILabel *type = (UILabel *)[cell viewWithTag:702];
        UILabel *numExercises = (UILabel *)[cell viewWithTag:703];
    
        UIImageView *workoutImageView1 = (UIImageView *)[cell viewWithTag:22];
        UIView *difficultyView = (UIView *)[cell viewWithTag:21];
    /*
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
    
    workoutImagesForTableView = [CommonDataOperations returnExerciseData:[self buildQuery:nil tableView:self.allWorkoutsTableView indexPath:indexPath isFavoriteCollectionView:NO] databaseName:STAYHEALTHY_DATABASE database:db];
        
        sqlColumns *workoutImageInfo = [ workoutImagesForTableView objectAtIndex:0];
        *//*
        NSMutableArray *arrayOfImages = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < workoutImagesForTableView.count; i++) {
            sqlColumns *workoutImageInfo = [ workoutImagesForTableView objectAtIndex:i];
            UIImage *newImage = [UIImage imageNamed:workoutImageInfo.File];
            [arrayOfImages addObject:newImage];
        }
    
        [workoutImageView1 setAnimationImages:arrayOfImages];
        
        workoutImageView1.animationDuration = 20;
        
        [workoutImageView1 startAnimating];
*/
      //  workoutImageView1.image = [UIImage imageNamed:workoutImageInfo.File];
 
    return cell;
        
    }
    else if (tableView == categoriesTableView) {
        NSString *CellIdentifier = @"category1";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        cell.textLabel.text = [categories objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageNamed:[categoriesImage objectAtIndex:indexPath.row]];
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = STAYHEALTHY_WHITE;
        bgColorView.layer.masksToBounds = YES;
        [cell setSelectedBackgroundView:bgColorView];
        
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == categoriesTableView) {
        [self performSegueWithIdentifier:@"popupView" sender:nil];
    }
    else {
           [self performSegueWithIdentifier:@"workoutDetailTable" sender:nil];
    }
 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark Popup Delegate Methods / And Popup Methods



- (void)cancelButtonClicked:(PopupViewController *)listViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

-(void)performSegue {
    
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self performSegueWithIdentifier:@"toDetail" sender:nil];
}
-(void)retreiveData:(NSString *)selectedOption title:(NSString *)titleForView type:(NSString *)type{
    selectedForPopup = selectedOption;
    generatedTitleForPopup = titleForView;
    typeOfSelected = type;
}


#pragma mark Query Building

-(NSString*)buildQuery:(UICollectionView*)collectionView tableView:(UITableView*)tableView indexPath:(NSIndexPath*)indexPath isFavoriteCollectionView:(BOOL)favoriteCollectionView{
    exerciseQuery = @"";
   /* workoutsDataObjects *workoutDataInfo;
    exerciseQuery = @"";
    
    if (favoriteCollectionView)
        workoutDataInfo = [favoritesWorkoutData objectAtIndex:indexPath.row];
    else
        workoutDataInfo = [workoutData objectAtIndex:indexPath.row];
        
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
    */
    return exerciseQuery;
}

-(NSString*)buildWorkoutQueryForBrowseScreen:(NSString*)selectedValue type:(NSString*)typeOfSelection{
    NSString *workoutQuery = @"";
    workoutQuery = [NSString stringWithFormat:@"SELECT * FROM PrebuiltWorkouts WHERE %@ LIKE '%%%@%%'",typeOfSelection,selectedValue];
    NSLog(@"%@",workoutQuery);
    return workoutQuery;
}

#pragma mark View Actions

- (IBAction)segmentValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self setHidden:NO browseView:NO preBuilt:YES];
            break;
        case 1:
            [self setHidden:YES browseView:YES preBuilt:NO];
            break;
        default:
            break;
    }
}

#pragma mark Prepare For Segue

-(void)sendData:(NSIndexPath*)indexPath dataArray:(NSArray*)dataArray segue:(UIStoryboardSegue*)segue query:(NSString*)builtQuery {/*
    workoutsDataObjects *objects = [dataArray objectAtIndex:indexPath.row];
    typeArray1 = [objects.workoutType componentsSeparatedByString:@","];
    WorkoutDetailViewController *destViewController = segue.destinationViewController;
    destViewController.summary = objects.summary;
    destViewController.titleText = objects.name;
    destViewController.genderText = objects.gender;
    destViewController.difficultyText = objects.Difficulty;
    destViewController.typeArray = typeArray1;
    destViewController.queryText = builtQuery;
    destViewController.sportText = objects.Sports;
    destViewController.muscleText = objects.targetMuscles;
    destViewController.equipText = objects.equipment;
    destViewController.workoutID = objects.ID;
                                                                                                                                    */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([segue.identifier isEqualToString:@"workoutDetail"]) {
        NSArray *arrayOfIndexPaths = [self.ourFavoritesView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [arrayOfIndexPaths firstObject];
        [self sendData:indexPath dataArray:favoritesWorkoutData segue:segue query:[self buildQuery:self.ourFavoritesView tableView:nil indexPath:indexPath isFavoriteCollectionView:YES]];
        WorkoutDetailViewController *destViewController = segue.destinationViewController;
        destViewController.hidesBottomBarWhenPushed = YES;
    }
    else if ([segue.identifier isEqualToString:@"workoutDetail1"]) {
        NSArray *arrayOfIndexPaths = [popularCollectionView indexPathsForSelectedItems];
        NSIndexPath *indexPath = [arrayOfIndexPaths firstObject];
        [self sendData:indexPath dataArray:popularWorkoutData segue:segue query:[self buildQuery:popularCollectionView tableView:nil indexPath:indexPath isFavoriteCollectionView:YES]];
        WorkoutDetailViewController *destViewController = segue.destinationViewController;
        destViewController.hidesBottomBarWhenPushed = YES;
    }
    else if ([segue.identifier isEqualToString:@"workoutDetailTable"]) {
        NSIndexPath *indexPath = [self.allWorkoutsTableView indexPathForSelectedRow];
        [self sendData:indexPath dataArray:workoutData segue:segue query:[self buildQuery:nil tableView:self.allWorkoutsTableView indexPath:indexPath isFavoriteCollectionView:NO]];
        WorkoutDetailViewController *destViewController = segue.destinationViewController;
        destViewController.hidesBottomBarWhenPushed = YES;
    }
    else if ([segue.identifier isEqualToString:@"toDetail"]) {
        WorkoutsSearchedViewController *destViewController = segue.destinationViewController;
        destViewController.titleText =  generatedTitleForPopup;
        destViewController.query = [self buildWorkoutQueryForBrowseScreen:selectedForPopup type:typeOfSelected];
    }
    else if ([segue.identifier isEqualToString:@"popupView"])
    {
        NSIndexPath *indexPath = [categoriesTableView indexPathForSelectedRow];
        workoutOptionsViewController *destViewController = segue.destinationViewController;
        if (indexPath.row == 0) {
            destViewController.titleText = @"Select Sport";
            destViewController.arrayForTableView = sports;
            destViewController.type = @"Sports";
        }
        if (indexPath.row == 1) {
            destViewController.titleText = @"Select Muscle";
            destViewController.arrayForTableView = muscles;
            destViewController.type = @"targetMuscles";
        }
        if (indexPath.row == 2) {
            destViewController.titleText = @"Select Equipment";
            destViewController.arrayForTableView = equip;
            destViewController.type = @"equipment";
        }
        if (indexPath.row == 3) {
            destViewController.titleText = @"Select Workout Type";
            destViewController.arrayForTableView = workoutType;
            destViewController.type = @"workoutType";
        }
        if (indexPath.row == 4) {
            destViewController.titleText = @"Select Difficulty";
            destViewController.arrayForTableView = workoutDifficulty;
            destViewController.type = @"difficulty";
        }
    }
   
}

#pragma mark Utilities
-(void)setHidden:(BOOL)scroller browseView:(BOOL)browseView preBuilt:(BOOL)preBuilt {
    self.scroller.hidden = browseView;
    self.preBuiltWorkouts.hidden = preBuilt;
    //self.scroller.hidden = scroller;
}
//Used to dismiss the keyboard for the search uitextfield.
-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

//If the user leaves the page then dismiss the all TSMessages.
-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}


@end
