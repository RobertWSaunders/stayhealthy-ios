//
//  WorkoutDetailViewController.m
//  StayHealthy
//
//  Created by Student on 3/26/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import "WorkoutDetailViewController.h"

@interface WorkoutDetailViewController ()

@end

@implementation WorkoutDetailViewController

@synthesize workoutExercises,query, backDelegate;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!expandedSections)
    {
        expandedSections = [[NSMutableIndexSet alloc] init];
    }
   
    self.workoutExpandableTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"WorkoutsFirstLaunch5"])
    {
        [TSMessage showNotificationInViewController:self
                                              title:@"Great! You have selected a workout. Now you can read the summary of it to see if you will like it, view the exercises in it, and look at the more detailed workout analysis. If you like it, simply just press \"start workout\" to get going. Tap this message to dismiss."
                                           subtitle:nil
                                              image:nil
                                               type:TSMessageNotificationTypeMessage
                                           duration:TSMessageNotificationDurationEndless
                                           callback:nil
                                        buttonTitle:nil
                                     buttonCallback:nil
                                         atPosition:TSMessageNotificationPositionBottom
                                canBeDismisedByUser:YES];

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"WorkoutsFirstLaunch5"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    //Fetching all the arrays data from the findExercise.plist
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"findExercise" ofType:@"plist"];
    NSDictionary *findData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];

    allSports = findData[@"sports2"];
    allMuscles = findData[@"muscleList"];


    sportsArray = [self.sportText componentsSeparatedByString:@","];
    muscleArray = [self.muscleText componentsSeparatedByString:@","];
    equipmentArray = [self.equipText componentsSeparatedByString:@","];
	
   // [self performFavoriteSearch:self.workoutID];
    
    self.title = self.titleText;
    self.summaryText.text = self.summary;
    self.startWorkoutButton.backgroundColor = STAYHEALTHY_BLUE;
    
    
    [[SIAlertView appearance] setTitleFont:[UIFont fontWithName:@"Avenir-Light" size:20]];
    [[SIAlertView appearance] setTitleColor:STAYHEALTHY_BLUE];
    [[SIAlertView appearance] setMessageColor:STAYHEALTHY_BLUE];
    [[SIAlertView appearance] setCornerRadius:4];
    [[SIAlertView appearance] setShadowRadius:0];
    [[SIAlertView appearance] setViewBackgroundColor:STAYHEALTHY_WHITE];
    [[SIAlertView appearance] setButtonColor:STAYHEALTHY_BLUE];
    [[SIAlertView appearance] setDestructiveButtonColor:STAYHEALTHY_BLUE];
    [[SIAlertView appearance] setCancelButtonColor:STAYHEALTHY_BLUE];
    [[SIAlertView appearance] setButtonFont:[UIFont fontWithName:@"Avenir-Light" size:18]];
    [[SIAlertView appearance] setMessageFont:[UIFont fontWithName:@"Avenir-Light" size:16]];
    [[SIAlertView appearance] setMessageColor:[UIColor lightGrayColor]];
    
    if (checkIfFavorite.count > 0) {
        /*
        workoutFavoriteObjects *favoriteObject = [checkIfFavorite objectAtIndex:0];
        if ([favoriteObject.isFavorite isEqualToString:@"TRUE"])
            [self createUIBarButtons:@"Star Filled-50.png"];
        else
            [self createUIBarButtons:@"Star-50.png"];
         */
    }
    
    detail = @[@"Exercises:",@"Type:",@"Difficulty:",@"Gender:",@"Times Completed:"];
    
    NSString *numberOfExercises = [NSString stringWithFormat:@"%lu", (unsigned long)workoutExercises.count];
    NSString *gender = self.genderText;
    NSString *difficulty = self.difficultyText;
    
    //workoutFavoriteObjects *favoriteObject = [checkIfFavorite objectAtIndex:0];
  //  NSString *timescompleted = [NSString stringWithFormat:@"%ld",(long)favoriteObject.TimesCompleted];
   // NSString *type = [self.typeArray objectAtIndex:0];
  //  detailInformation = @[numberOfExercises,type,difficulty,gender,timescompleted];
    
    
   // workoutExercises = [CommonDataOperations returnExerciseData:self.queryText databaseName:STAYHEALTHY_DATABASE database:db];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.workoutExpandableTable) {
        return 55.0f;
    }
    else {
        return 85.0f;
    }
}
- (BOOL)tableView:(UITableView *)tableView canCollapseSection:(NSInteger)section
{
    if (tableView == self.workoutExpandableTable) return YES;
    return NO;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == self.workoutExpandableTable) return 4;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == self.workoutExpandableTable) {
        
    if ([self tableView:tableView canCollapseSection:section])
    {
        if ([expandedSections containsIndex:section])
        {
            
            if (section == 0) {
                return [muscleArray count];
            }
            else if (section == 1) {
                return [sportsArray count];
            }
            else if (section == 2) {
                return [equipmentArray count];
            }
            else if (section == 3) {
                return [detail count];
            }
        }
    }
    // Return the number of rows in the section.
    return 1;
    }
    
    return [workoutExercises count];
    
    
    
    
   }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.workoutExpandableTable) {
        
        static NSString *CellIdentifier = @"expandCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        // Configure the cell...
        
        if ([self tableView:tableView canCollapseSection:indexPath.section])
        {
            if (!indexPath.row)
            {
                cell.textLabel.textColor = STAYHEALTHY_BLUE;
                cell.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:18.0f];
                
                
                if (indexPath.section == 0) {
                    cell.textLabel.text = [NSString stringWithFormat:@"Target Muscles"];
                    cell.detailTextLabel.text = @"";
                }
                else if (indexPath.section == 1) {
                    cell.textLabel.text = [NSString stringWithFormat:@"Sports"];
                    cell.detailTextLabel.text = @"";
                }
                else if (indexPath.section == 2) {
                    cell.textLabel.text = [NSString stringWithFormat:@"Equipment"];
                    cell.detailTextLabel.text = @"";
                }
                else if (indexPath.section == 3) {
                    cell.textLabel.text = [NSString stringWithFormat:@"Workout Information"];
                    cell.detailTextLabel.text = @"";
                }
                
                if ([expandedSections containsIndex:indexPath.section])
                {
                    cell.accessoryView = [ALCustomColoredAccessory accessoryWithColor:[UIColor lightGrayColor] type:ALCustomColoredAccessoryTypeUp];
                }
                else
                {
                    cell.accessoryView = [ALCustomColoredAccessory accessoryWithColor:[UIColor lightGrayColor] type:ALCustomColoredAccessoryTypeDown];
                }
            }
            else
            {
                cell.accessoryView = nil;
                cell.accessoryType = UITableViewCellAccessoryNone;

                if (indexPath.section == 0) {
                    if ([[muscleArray objectAtIndex:0] isEqualToString:@"All"] || [[muscleArray objectAtIndex:0] isEqualToString:@"null"]) {
                        cell.textLabel.text = [allMuscles objectAtIndex:indexPath.row];
                    }
                    else {
                        cell.textLabel.text = [muscleArray objectAtIndex:indexPath.row];
                    }
                    cell.textLabel.textColor = [UIColor lightGrayColor];
                    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.0f];
                     cell.detailTextLabel.text = @"";
                }
                else if (indexPath.section == 1) {
                    if ([[sportsArray objectAtIndex:0] isEqualToString:@"All"] || [[sportsArray objectAtIndex:0] isEqualToString:@"null"]) {
                        cell.textLabel.text = [allSports objectAtIndex:indexPath.row];
                    }
                    else {
                        cell.textLabel.text = [sportsArray objectAtIndex:indexPath.row];
                    }
                    cell.textLabel.textColor = [UIColor lightGrayColor];
                    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.0f];
                     cell.detailTextLabel.text = @"";
                }
                else if (indexPath.section == 2) {
                    if ([[equipmentArray objectAtIndex:0] isEqualToString:@"None"] || [[equipmentArray objectAtIndex:0] isEqualToString:@"null"]) {
                        cell.textLabel.text = @"No Equipment Needed";
                    }
                    else {
                        cell.textLabel.text = [equipmentArray objectAtIndex:indexPath.row];
                    }
                    cell.textLabel.textColor = [UIColor lightGrayColor];
                    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.0f];
                     cell.detailTextLabel.text = @"";
                }
                else if (indexPath.section == 3) {
                    cell.textLabel.text = [detail objectAtIndex:indexPath.row];
                    cell.detailTextLabel.text = [detailInformation objectAtIndex:indexPath.row];
                    cell.textLabel.textColor = [UIColor lightGrayColor];
                    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.0f];
                    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
                    cell.detailTextLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.0f];
                    
                }
          
            }
        }
        return cell;
    }
    
    static NSString *simpleTableIdentifier = @"ourExerciseCells";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    /*
    sqlColumns *exercise = [self.workoutExercises objectAtIndex:indexPath.row];
    
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
        difficulty.textColor = STAYHEALTHY_RED;
    }
    
    UIImageView *cellImageView = (UIImageView *)[cell viewWithTag:100];
    cellImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",exercise.File]];
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = STAYHEALTHY_WHITE;
    bgColorView.layer.masksToBounds = YES;
    [cell setSelectedBackgroundView:bgColorView];
    */
    return cell;

      }
//DESELECT THE CELL, IF YOU DON"T CALL THIS METHOD THEN IT WON'T DESELECT.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.workoutExpandableTable) {
    if ([self tableView:tableView canCollapseSection:indexPath.section])
    {
        if (!indexPath.row)
        {
            // only first row toggles exapand/collapse
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
            NSInteger section = indexPath.section;
            BOOL currentlyExpanded = [expandedSections containsIndex:section];
            NSInteger rows;
            
            NSMutableArray *tmpArray = [NSMutableArray array];
            
            if (currentlyExpanded)
            {
                rows = [self tableView:tableView numberOfRowsInSection:section];
                [expandedSections removeIndex:section];
                
            }
            else
            {
                [expandedSections addIndex:section];
                rows = [self tableView:tableView numberOfRowsInSection:section];
            }
            
            for (int i=1; i<rows; i++)
            {
                NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:i
                                                               inSection:section];
                [tmpArray addObject:tmpIndexPath];
            }
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if (currentlyExpanded)
            {
                [tableView deleteRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                
                cell.accessoryView = [ALCustomColoredAccessory accessoryWithColor:[UIColor lightGrayColor] type:ALCustomColoredAccessoryTypeDown];
                
            }
            else
            {
                [tableView insertRowsAtIndexPaths:tmpArray
                                 withRowAnimation:UITableViewRowAnimationTop];
                cell.accessoryView =  [ALCustomColoredAccessory accessoryWithColor:[UIColor lightGrayColor] type:ALCustomColoredAccessoryTypeUp];
                
            }
        }
        else {
            NSLog(@"Selected Section is %ld and subrow is %ld ",(long)indexPath.section ,(long)indexPath.row);
            
        }
        
    }
    }
    else {
        /*
    PopupViewController *secondDetailViewController = [[PopupViewController alloc] initWithNibName:@"PopupViewController" bundle:nil];
    secondDetailViewController.delegate = self;
    //self.workoutExercisesTable = (UITableView *)[self.workoutDetails viewWithTag:10];
    NSIndexPath *indexPath1 = [self.workoutExercisesTable indexPathForSelectedRow];
    sqlColumns *exercise = [self.workoutExercises objectAtIndex:indexPath1.row];
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self presentPopupViewController:secondDetailViewController animationType:MJPopupViewAnimationFade];
    }
         */
}
}

- (IBAction)segmentValueChanged:(UISegmentedControl*)sender {
    switch (sender.selectedSegmentIndex) {
            case 0:
            self.workoutExercisesTable.hidden = NO;
            self.workoutExpandableTable.hidden = YES;
            break;
        case 1:
            self.workoutExercisesTable.hidden = YES;
            self.workoutExpandableTable.hidden = NO;
            break;
    }
}

- (IBAction)readMoreButton:(id)sender {
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"title" andMessage:self.summary];
    [alertView addButtonWithTitle:@"Done"
                             type:SIAlertViewButtonTypeCancel
                          handler:nil];
    [alertView show];
    alertView.title = @"Summary";
    
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"workoutExDetails"]) {
        /*
        NSIndexPath *indexPath = [self.workoutExercisesTable indexPathForSelectedRow];
        sqlColumns *exercise = [self.workoutExercises objectAtIndex:indexPath.row];
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
         */
    }
    if ([segue.identifier isEqualToString:@"workoutPage"]) {
        WorkoutViewController *destViewController = segue.destinationViewController;
        destViewController.titleText = self.title;
        destViewController.query = self.queryText;
        destViewController.workoutID = self.workoutID;
        destViewController.hidesBottomBarWhenPushed = YES;
    }
}

- (void)cancelButtonClicked:(PopupViewController *)aSecondDetailViewController
{
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
}

#pragma mark Favoriting

-(void)performFavoriteSearch:(NSString*)ID {
    NSString *workoutFavoriteQuery;
    workoutFavoriteQuery = [NSString stringWithFormat:@"SELECT * FROM PrebuiltWorkoutData WHERE WorkoutID = '%@'",ID];
  //  checkIfFavorite = [CommonDataOperations retreiveWorkoutInfo:workoutFavoriteQuery databaseName:USER_DATABASE database:db];

    if (checkIfFavorite.count == 0) {
     /*   [CommonDataOperations performInsertQuery:[NSString stringWithFormat:@"INSERT INTO PrebuiltWorkoutData ('WorkoutID','TimesCompleted','isFavorite') VALUES ('%@','0','FALSE')",self.workoutID] databaseName:USER_DATABASE database:db];
         checkIfFavorite = [CommonDataOperations retreiveWorkoutInfo:workoutFavoriteQuery databaseName:USER_DATABASE database:db];
      */
    }
    
}

//This method creates the uibarbuttons dependant on a few arguments.
-(void)createUIBarButtons:(NSString*)favoriteImageName {
    self.favoriteButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:favoriteImageName] style:UIBarButtonItemStyleBordered target:self action:@selector(update:)];
    NSArray *actionButtonItems = @[self.favoriteButton];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
}

//Changes the favorites image dependant on if its a favorite or not.
-(void)changeImage {
    if ([self.favoriteButton.image isEqual:[UIImage imageNamed:@"Star-50.png"]])
        [self.favoriteButton setImage:[UIImage imageNamed:@"Star Filled-50.png"]];
    else
        [self.favoriteButton setImage:[UIImage imageNamed:@"Star-50.png"]];
}

//The mehtod that saves the favorite or takes it away.
- (IBAction)update:(id)sender {
    [self changeImage];
    [self.backDelegate backButtonPressed];
    NSInteger workoutID = [self.workoutID intValue];
   // if ([self.favoriteButton.image isEqual:[UIImage imageNamed:@"Star Filled-50.png"]])
      //  [CommonDataOperations performInsertQuery:[NSString stringWithFormat:@"UPDATE PrebuiltWorkoutData SET isFavorite = 'TRUE' WHERE WorkoutID = '%ld'",(long)workoutID] databaseName:USER_DATABASE database:db];
   // else if ([self.favoriteButton.image isEqual:[UIImage imageNamed:@"Star-50.png"]])
         //[CommonDataOperations performInsertQuery:[NSString stringWithFormat:@"UPDATE PrebuiltWorkoutData SET isFavorite = 'FALSE' WHERE WorkoutID = '%ld'",(long)workoutID] databaseName:USER_DATABASE database:db];
    
}

//If the user leaves the page then dismiss the all TSMessages.
-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}


@end
