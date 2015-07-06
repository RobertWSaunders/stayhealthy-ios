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

    //Setting the images dependant on whether the exercise is a favorite or not.
    /*
    if ([CommonDataOperations isExerciseFavorited:self.exerciseIdentifier exerciseType:self.exerciseType])
        [self createUIBarButtons:@"Star Filled-50.png" second:@"watch-25.png"];
    else
        [self createUIBarButtons:@"Star-50.png" second:@"watch-25.png"];
    */
    
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
    /*
    self.title = self.title1;
    self.exerciseImage.image = self.image;
    self.descriptionLabel.text = self.text;
     */
}



//This method creates the uibarbuttons dependant on a few arguments.
-(void)createUIBarButtons:(NSString*)favoriteImageName second:(NSString*)watchImageName {
    self.favoriteButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:favoriteImageName] style:UIBarButtonItemStyleBordered target:self action:@selector(update:)];
    NSArray *actionButtonItems = @[self.favoriteButton];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
}

//Changes the images for the favorite button when the user presses it.
-(void)changeImage {
    if ([self.favoriteButton.image isEqual:[UIImage imageNamed:@"Star-50.png"]])
        [self.favoriteButton setImage:[UIImage imageNamed:@"Star Filled-50.png"]];
    else
        [self.favoriteButton setImage:[UIImage imageNamed:@"Star-50.png"]];
}

//Change the exercise type to something that is readable.
-(void)changeToReadable {
    if ([self.exerciseType isEqualToString:@"strength"])
        tempExerciseType = exerciseTypes[0];
    else if ([self.exerciseType isEqualToString:@"stretching"])
        tempExerciseType = exerciseTypes[1];
    else if ([self.exerciseType isEqualToString:@"warmup"])
        tempExerciseType = exerciseTypes[2];
}

//The mehtod that saves the favorite or takes it away.
- (IBAction)update:(id)sender {
    
    [self changeImage];
    [self changeToReadable];
    /*
    NSInteger exerciseID = [self.ident intValue];
    
    if ([self.favoriteButton.image isEqual:[UIImage imageNamed:@"Star Filled-50.png"]]) {
        [CommonDataOperations performInsertQuery:[NSString stringWithFormat:@"INSERT INTO FavoriteExercises ('ExerciseID','ExerciseType') VALUES ('%ld','%@')",(long)exerciseID,tempExerciseType] databaseName:USER_DATABASE database:db];
        }
    else {
        [CommonDataOperations performInsertQuery:[NSString stringWithFormat:@"DELETE FROM FavoriteExercises WHERE ExerciseID = '%ld' AND ExerciseType = '%@'",(long)exerciseID,tempExerciseType] databaseName:USER_DATABASE database:db];
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
    /*
    cell.textLabel.text = [tableViewTitles objectAtIndex:indexPath.row];
    [cell setUserInteractionEnabled:NO];
    
    cell.textLabel.font = tableViewTitleTextFont;
    cell.detailTextLabel.font = tableViewDetailTextFont;
    
    cell.textLabel.textColor = STAYHEALTHY_BLUE;
    cell.detailTextLabel.textColor = STAYHEALTHY_LIGHTGRAYCOLOR;
    
    //Sets
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = self.sets;
    }
    //Reps
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = self.reps;
    }
    //Primary Muscle
    if (indexPath.row == 2) {
        cell.detailTextLabel.text = self.pri;
    }
    //Secondary Muscle
    if (indexPath.row == 3) {
        NSString *trimmedStrings2 = [self.sec stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([trimmedStrings2 isEqualToString:@"null"]) {
         
                 self.sec = @"No Secondary Muscle";
            
           
        }
        cell.detailTextLabel.text = self.sec;
    }
    //Equipment
    if (indexPath.row == 4) {
        NSString *trimmedString = [self.material stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        if ([trimmedString isEqualToString:@"null"]) {
            self.material = @"No Equipment";
        }
        cell.detailTextLabel.text = self.material;
    }
    //Difficulty
    if (indexPath.row == 5) {
        cell.detailTextLabel.text = self.difficulty;
        if ([self.difficulty isEqualToString:@"Easy"])
            cell.detailTextLabel.textColor = STAYHEALTHY_GREEN;
        if ([self.difficulty isEqualToString:@"Intermediate"])
            cell.detailTextLabel.textColor = STAYHEALTHY_DARKERBLUE;
        if ([self.difficulty isEqualToString:@"Hard"])
            cell.detailTextLabel.textColor = STAYHEALTHY_RED;
        if ([self.difficulty isEqualToString:@"Very Hard"])
            cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    */
        return cell;
    
}

@end
