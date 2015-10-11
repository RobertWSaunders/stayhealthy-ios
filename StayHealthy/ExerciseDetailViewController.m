//
//  ExerciseDetailViewController.m
//  StayHealthy
//
//  Created by Student on 12/21/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
//

#import "ExerciseDetailViewController.h"

@interface ExerciseDetailViewController () {
    //ScrollView
    IBOutlet UIScrollView *scroller;
    //Exercise Information TableView
    IBOutlet UITableView *detailTableView;
    //Instruction Label
    IBOutlet UILabel *instructionLabel;
    //Database
    sqlite3 * db;
    //Exercise Types
    NSArray *exerciseTypes;
    //Array contains titles for exercise tableview information.
    NSArray *tableViewTitles;

    //Stores a temporary exercise type for the update.
    NSString *tempExerciseType;
}

@end

@implementation ExerciseDetailViewController

/***********************/
#pragma mark ViewDidLoad
/***********************/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Allows user to scroll the UIScrollView
    [scroller setScrollEnabled:YES];
    
    //Sets the NSUserDefault and displays the TSMessage when page is loaded for the first time.
    [CommonSetUpOperations setFirstViewTSMessage:@"FirstViewForPageTwo" viewController:self message:@"So you have selected an exercise, if you want to see more details about it you can scroll down. Also favorite an exercise by pressing the star in the top right. Tap this message to dismiss."];

    //Fill the data from the database into the textholders.
    [self fillData];

    /*
    if (![CommonDataOperations checkExerciseIsInUserDatabase:self.exerciseIdentifier]) {
         [CommonDataOperations insertExerciseEntry:NO exerciseID:self.exerciseIdentifier];
        [self createUIBarButtons:@"like.png"];
    }
    else {
        if ([CommonDataOperations isExerciseFavorite:self.exerciseIdentifier]) {
            [self createUIBarButtons:@"likeSelected.png"];
        }
        else {
            [self createUIBarButtons:@"like.png"];
        }

    }*/
   
    
    //Find the path to the plist containing all the nessescary information.
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"findExercise" ofType:@"plist"];
    NSDictionary *findExerciseData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];

    //Fill exercise types with information from the plist.
    exerciseTypes = findExerciseData[@"exerciseTypes"];
    //Fill the tableview titles array with the correct titles.
    tableViewTitles = @[@"Sets",@"Reps",@"Primary Muscle",@"Secondary Muscle",@"Equipment",@"Difficulty"];
    
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;
    //Gets rid on needed TableView seperator lines.
    detailTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

/***************************/
#pragma mark Utility Methods
/***************************/



//This method fills the data from the database into their respective placeholders.
-(void)fillData {
    
    self.title = self.exerciseTitle;
    self.exerciseImageView.image = self.exerciseImage;
    self.descriptionLabel.text = self.exerciseInstructions;
     
}



//This method creates the uibarbuttons dependant on a few arguments.
-(void)createUIBarButtons:(NSString*)favoriteImageName {
    self.favoriteButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:favoriteImageName] style:UIBarButtonItemStyleBordered target:self action:@selector(update:)];
    NSArray *actionButtonItems = @[self.favoriteButton];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
}

//Changes the images for the favorite button when the user presses it.
-(void)changeImage {
    if ([self.favoriteButton.image isEqual:[UIImage imageNamed:@"like.png"]])
        [self.favoriteButton setImage:[UIImage imageNamed:@"likeSelected.png"]];
    else
        [self.favoriteButton setImage:[UIImage imageNamed:@"like.png"]];
}



//The mehtod that saves the favorite or takes it away.
- (IBAction)update:(id)sender {
    
    [self changeImage];
    /*
    if ([self.favoriteButton.image isEqual:[UIImage imageNamed:@"likeSelected.png"]]) {
        [CommonDataOperations insertExerciseEntry:YES exerciseID:self.exerciseIdentifier];
        }
    else {
        [CommonDataOperations insertExerciseEntry:NO exerciseID:self.exerciseIdentifier];
        }
     */
    }
     

//If the user leaves the page then dismiss the all TSMessages.
-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}


/**************************************/
#pragma mark TableView Delegate Methods
/**************************************/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0f;
}

//Design and fill the tableview cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

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
        cell.detailTextLabel.text = self.exerciseSets;
    }
    //Reps
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = self.exerciseReps;
    }
    //Primary Muscle
    if (indexPath.row == 2) {
        cell.detailTextLabel.text = self.exercisePrimaryMuscle;
    }
    //Secondary Muscle
    if (indexPath.row == 3) {
        NSString *trimmedStrings2 = [self.exerciseSecondaryMuscle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([trimmedStrings2 isEqualToString:@"null"]) {
         
                 self.exerciseSecondaryMuscle = @"No Secondary Muscle";
            
           
        }
        cell.detailTextLabel.text = self.exerciseSecondaryMuscle;
    }
    //Equipment
    if (indexPath.row == 4) {
        NSString *trimmedString = [self.exerciseEquipment stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        if ([trimmedString isEqualToString:@"null"]) {
            self.exerciseEquipment = @"No Equipment";
        }
        cell.detailTextLabel.text = self.exerciseEquipment;
    }
    //Difficulty
    if (indexPath.row == 5) {
        cell.detailTextLabel.text = self.exerciseDifficulty;
        if ([self.exerciseDifficulty isEqualToString:@"Easy"])
            cell.detailTextLabel.textColor = STAYHEALTHY_GREEN;
        if ([self.exerciseDifficulty isEqualToString:@"Intermediate"])
            cell.detailTextLabel.textColor = STAYHEALTHY_DARKERBLUE;
        if ([self.exerciseDifficulty isEqualToString:@"Hard"])
            cell.detailTextLabel.textColor = STAYHEALTHY_RED;
        if ([self.exerciseDifficulty isEqualToString:@"Very Hard"])
            cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    
        return cell;
    
}

@end
