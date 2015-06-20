//
//  ExerciseDetailViewController.m
//  StayHealthy
//
//  Created by Student on 12/21/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
//

/*************************************************IMPLEMENTATION FILE************************************/
//The detail view for the exercises.

#import "ExerciseDetailViewController.h"
//^^^^^^^^^Import the header fie.

@interface ExerciseDetailViewController ()

@end

@implementation ExerciseDetailViewController

//Synthesize labels and strings.
@synthesize exerciseImage,descriptionLabel,repsText,setsText,materialsText,difficultyText,priText,secText, ident, isFavorite, detailView, favoriteButton, stretchingRefined, exerciseType;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [scroller setScrollEnabled:YES];

    
    self.automaticallyAdjustsScrollViewInsets = NO;
    


    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunchOfPage1"])
    {
        [TSMessage showNotificationInViewController:self
                                              title:@"So you have selected an exercise, if you want to see more details about it you can scroll down. Also favorite an exercise by pressing the star in the top right. Tap this message to dismiss."
                                           subtitle:nil
                                              image:nil
                                               type:TSMessageNotificationTypeMessage
                                           duration:TSMessageNotificationDurationEndless
                                           callback:nil
                                        buttonTitle:nil
                                     buttonCallback:nil
                                         atPosition:TSMessageNotificationPositionTop
                                canBeDismisedByUser:YES];

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLaunchOfPage1"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

    detailTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self performFavoriteSearch:exerciseType exerciseID:ident];
    
    [CommonDataOperations addDailyActivity:[NSString stringWithFormat:@"UPDATE DailyActivity SET exercisesViewed = exercisesViewed + 1 WHERE date = '%@'",[CommonSetUpOperations returnDateInString:[NSDate date]]] database:db];
    
    //Fill the data from the database into the textholders.
    [self fillData];

    if (checkIfFavorites.count > 0)
        [self createUIBarButtons:@"Star Filled-50.png" second:@"watch-25.png"];
    else
        [self createUIBarButtons:@"Star-50.png" second:@"watch-25.png"];
    
    [self formatData:difficultyText.text second:materialsText.text third:secText.text];
    
    //Fetching all the arrays data from the findExercise.plist
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"findExercise" ofType:@"plist"];
    NSDictionary *findExerciseData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];

    exerciseTypes = findExerciseData[@"exerciseTypes"];

    // Set the gesture to toggle the side menu.
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    tableViewTitles = @[@"Sets",@"Reps",@"Primary Muscle",@"Secondary Muscle",@"Equipment",@"Difficulty"];
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
    checkIfFavorites = [CommonDataOperations checkIfExerciseIsFavorite:query databaseName:@"UserDB1.sqlite" database:db];
}

//This method fills the data from the database into their respective placeholders.
-(void)fillData {
    self.title = self.title1;
    exerciseImage.image = self.image;
    descriptionLabel.text = self.text;
    repsText.text = self.reps;
    setsText.text = self.sets;
    materialsText.text = self.material;
    difficultyText.text = self.difficulty;
    priText.text = self.pri;
    secText.text = self.sec;
    isFavorite.text = self.favorite;
}

/*
 //This method sets up the datasource for the tableview, i.e. fills the dictionary with the correct key-value pairs.
 - (void)setupDataSource:(NSArray*)sortedDateArray {
 //The tableView sections.
 self.tableViewSections = [NSMutableArray arrayWithCapacity:0];
 //The dictionary for all the tableview cells. Note:NSMutableDictionary.
 self.tableViewCells = [NSMutableDictionary dictionaryWithCapacity:0];

 //The num gets 1+ every iteration, it is sent to the arrayOfEvents method.
 int num = 0;

 //Perform loop for all the TKCalendarEvents in sortedDateArray.
 for (CalendarObject* calendarEvents in sortedDateArray)
 {
 NSDate *startDateWithoutTime = [self dateWithOutTime:calendarEvents.startDate];
 NSDate *endDateWithoutTime = [self dateWithOutTime:calendarEvents.endDate];
 NSString* dateInString;

 //If the start date and end date is equal then it is a single date event and just add the value to the section and cell
 if([startDateWithoutTime isEqualToDate:endDateWithoutTime])
 {
 dateInString = [self returnDateAsString:calendarEvents.startDate];
 //If the header is already added in Section object then add only cell value otherwise add both
 if (![self.tableViewSections containsObject:dateInString])
 [self.tableViewSections addObject:dateInString];
 [self addValueToDictionary:self.tableViewCells keyName:dateInString value:calendarEvents];
 }
 //For multi day events
 else
 {
 NSMutableArray *noOfDaysEvent = [self arrayOfDays:calendarEvents.startDate endDate:calendarEvents.endDate];
 NSMutableArray *arrayEvents = [self arrayOfEvents:calendarEvents.startDate endDate:calendarEvents.endDate array:sortedArrayofEvents int:num];
 for (int i = 0; i < noOfDaysEvent.count; i++) {
 dateInString = [self returnDateAsString:noOfDaysEvent[i]];
 //If the header is already added in Section object then add only cell value otherwise add both
 if (![self.tableViewSections containsObject:dateInString])
 [self.tableViewSections addObject:dateInString];
 [self addValueToDictionary:self.tableViewCells keyName:dateInString value:arrayEvents[i]];
 }
 }
 num++;
 }
 [self sortSections];
 [self sortDictionaryValues];
 }
 */

//This method creates the uibarbuttons dependant on a few arguments.
-(void)createUIBarButtons:(NSString*)favoriteImageName second:(NSString*)watchImageName {
    self.favoriteButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:favoriteImageName] style:UIBarButtonItemStyleBordered target:self action:@selector(update:)];
    NSArray *actionButtonItems = @[favoriteButton];
    self.navigationItem.rightBarButtonItems = actionButtonItems;
}

//This method formats the data in the View Controller.
-(void)formatData:(NSString*)difficultyTextCheck second:(NSString*)trimMaterialString third:(NSString*)trimString2{
    if ([difficultyTextCheck isEqualToString:@"Easy"])
        difficultyText.textColor = STAYHEALTHY_GREEN;
    if ([difficultyTextCheck isEqualToString:@"Intermediate"])
        difficultyText.textColor = STAYHEALTHY_DARKERBLUE;
    if ([difficultyTextCheck isEqualToString:@"Hard"])
        difficultyText.textColor = STAYHEALTHY_RED;
    if ([difficultyTextCheck isEqualToString:@"Very Hard"])
        difficultyText.textColor = STAYHEALTHY_RED;
   
    NSString *trimmedString = [trimMaterialString stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    if ([trimmedString isEqualToString:@"null"])
        materialsText.text = @"No Equipment";
    
    NSString *trimmedStrings2 = [trimString2 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ([trimmedStrings2 isEqualToString:@"null"])
        secText.text = @"No Secondary Muscle";
}

//Changes the favorites image dependant on if its a favorite or not.
-(void)changeImage {
    if ([favoriteButton.image isEqual:[UIImage imageNamed:@"Star-50.png"]])
        [favoriteButton setImage:[UIImage imageNamed:@"Star Filled-50.png"]];
    else
        [favoriteButton setImage:[UIImage imageNamed:@"Star-50.png"]];
}

//Change the exercise type to something that is readable.
-(void)changeToReadable {
    if ([self.exerciseType isEqualToString:@"strength"])
        self.stretchingRefined = exerciseTypes[0];
    else if ([self.exerciseType isEqualToString:@"stretching"])
        self.stretchingRefined = exerciseTypes[1];
    else if ([self.exerciseType isEqualToString:@"warmup"])
        self.stretchingRefined = exerciseTypes[2];
}

//The mehtod that saves the favorite or takes it away.
- (IBAction)update:(id)sender {
    
    [self changeImage];
    [self changeToReadable];
    
    NSInteger exerciseID = [ident intValue];
    
    if ([favoriteButton.image isEqual:[UIImage imageNamed:@"Star Filled-50.png"]]) {
        [CommonDataOperations performInsertQuery:[NSString stringWithFormat:@"INSERT INTO FavoriteExercises ('ExerciseID','ExerciseType') VALUES ('%ld','%@')",(long)exerciseID,self.stretchingRefined] databaseName:@"UserDB1.sqlite" database:db];
        }
    else {
        [CommonDataOperations performInsertQuery:[NSString stringWithFormat:@"DELETE FROM FavoriteExercises WHERE ExerciseID = '%ld' AND ExerciseType = '%@'",(long)exerciseID,self.stretchingRefined] databaseName:@"UserDB1.sqlite" database:db];
        }
    }

//If the user leaves the page then dismiss the all TSMessages.
-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}


//MUSCLE LIST STUFF - THE TABLEVIEW STUFF
/*****************************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0f;
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
    
        return cell;
    
}

@end
