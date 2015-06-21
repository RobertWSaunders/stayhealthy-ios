//
//  MuscleSelectionViewController.m
//  StayHealthy
//
//  Created by Student on 12/7/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
//


#import "MuscleSelectionViewController.h"

@interface MuscleSelectionViewController ()

@end

@implementation MuscleSelectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    advancedSearchTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    advancedSearchTableView.scrollEnabled = NO;
    
    //Give the ViewController a title.
    self.navigationController.title = @"Find Exercise";

    [CommonSetUpOperations styleAlertView];


    //Our SIAlertview string values.
    strength = @"Strength";
    stretching = @"Stretching";
    cancel = @"Cancel";
    title = @"Exercise Type";

    //Fetching all the arrays data from the findExercise.plist
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"findExercise" ofType:@"plist"];
    NSDictionary *findExerciseData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    //Queries List
    queries = findExerciseData[@"queries"];
    //Title text.
    titleText = findExerciseData[@"titleText"];
    
    //Tableview/Muscle List view arrays
    musclesForTableview = findExerciseData[@"musclesForTableview"];
    scientificMuscleNames = findExerciseData[@"scientificMuscleNames"];
    musclesForTableview2 = findExerciseData[@"musclesForTableview2"];
    scientificMuscleNames2 = findExerciseData[@"scientificMuscleNames2"];
    
    //Advanced search arrays.
    primaryMuscleList = findExerciseData[@"primaryMuscleList"];
    secondaryMuscleList = findExerciseData[@"secondaryMuscleList"];
    equipmentList = findExerciseData[@"equipmentList"];
    difficultyList = findExerciseData[@"difficultyList"];
    
    advancedOptions = [NSArray arrayWithObjects:@"Primary Muscle",@"Secondary Muscle", @"Equipment", @"Difficulty", @"Exercise Type", nil];
  
    advancedOptionsSelections = [NSArray arrayWithObjects:@"Any",@"Any", @"Any", @"Any", @"Strength", nil];
    
    //Styling the search button.
    self.searchButton.backgroundColor = STAYHEALTHY_BLUE;
}

-(void)viewWillAppear:(BOOL)animated {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunch1"])
    {
        [CommonSetUpOperations performTSMessage:@"Welcome to the exercise selection page! Here you can change between the muscle list and advanced search. Simply choose the muscle you'd like to exercise or you can use the advanced search to choose specifics, like the type of equipment, difficulty, muscle groups, if you want a more specific result. Looking for a warm-up? Press the running icon in the top right. Tap this message to dismiss." message:nil viewController:self canBeDismissedByUser:YES duration:60];

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLaunch1"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

//What happens if the Warmup UIBarButton is pressed.
-(void)warmup:(id)sender{
    [self performSegueWithIdentifier:@"30" sender:self];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE_4_OR_LESS) {
        return 58;
    }
    else {
        return 60;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == advancedSearchTableView)
        return 1;
    else
        return 2;
    // Return the number of sections.
    //2 because front and back muscles.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == selectMuscleTableView) {
        //Number of rows in each section, just counts the array.
        switch (section) {
            case 0:
                return [musclesForTableview count];
                break;
            case 1:
                return [musclesForTableview2 count];
                break;
            default:
                break;
        }
    }
       //As a precaution then return something.
    return 5;
}

//Returns the height of the header in the tableview.
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == advancedSearchTableView) {
        return 0;
    }
    else {
        return 25;
    }
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [CommonSetUpOperations drawViewForTableViewHeader:tableView];
    
    //Now customize that view.
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, tableView.frame.size.width, 18)];
    [titleLabel setFont:tableViewHeaderFont];
    titleLabel.textColor = STAYHEALTHY_BLUE;
    
    [headerView addSubview:titleLabel];
    
    if (tableView == selectMuscleTableView && section == 0) {
        titleLabel.text = @"Front Muscles";
    }
    else if (tableView == selectMuscleTableView &&  section == 1) {
        titleLabel.text = @"Back Muscles";
    }
    
    return headerView;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == selectMuscleTableView) {
    //Define the identifier.
    static NSString *muscleItem = @"muscleItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleItem];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:muscleItem];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [musclesForTableview objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [scientificMuscleNames objectAtIndex:indexPath.row];
    }
    if (indexPath.section == 1) {
        cell.textLabel.text = [musclesForTableview2 objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [scientificMuscleNames2 objectAtIndex:indexPath.row];
    }
        
        //Stlying the cells.
        cell.textLabel.font = tableViewTitleTextFont;
        cell.detailTextLabel.font = tableViewUnderTitleTextFont;
        cell.textLabel.textColor = STAYHEALTHY_BLUE;
        cell.detailTextLabel.textColor = STAYHEALTHY_BLUE;
        
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
    
       return cell;
    }
    else {
        static NSString *advancedItem = @"advancedItem";
        
        UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:advancedItem];
        
        if (cell2 == nil) {
            cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:advancedItem];
        }
        
        cell2.textLabel.text = [advancedOptions objectAtIndex:indexPath.row];
        cell2.detailTextLabel.text = [advancedOptionsSelections objectAtIndex:indexPath.row];
        
        //Stlying the cells.
        cell2.textLabel.font = tableViewTitleTextFont;
        cell2.detailTextLabel.font = tableViewDetailTextFont;
        cell2.textLabel.textColor = STAYHEALTHY_BLUE;
        cell2.detailTextLabel.textColor = STAYHEALTHY_LIGHTGRAYCOLOR;
        
       [CommonSetUpOperations tableViewSelectionColorSet:cell2];

        return cell2;
    }
}

//Controls what happens when a user presses a cell, i.e. a SIAlertview pops up.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (tableView == selectMuscleTableView) {
    if (indexPath.section == 0) {
        if (indexPath.row < 2) {
            NSString *indexPathNum = [NSString stringWithFormat: @"%ld", (long)indexPath.row*2];
            NSString *indexPathNumAdd = [NSString stringWithFormat: @"%ld", ((long)indexPath.row*2)+1];
            [self selectRow:indexPathNum second:indexPathNumAdd];
        }
        if (indexPath.row > 2 && indexPath.row < 5) {
            NSString *indexPathNum = [NSString stringWithFormat: @"%ld", ((long)indexPath.row*2)-1];
            NSString *indexPathNumAdd = [NSString stringWithFormat: @"%ld", ((long)indexPath.row*2)];
            [self selectRow:indexPathNum second:indexPathNumAdd];
        }
        if (indexPath.row > 5){
            NSString *indexPathNum = [NSString stringWithFormat: @"%ld", ((long)indexPath.row*2)-2];
            NSString *indexPathNumAdd = [NSString stringWithFormat: @"%ld", ((long)indexPath.row*2)-1];
            [self selectRow:indexPathNum second:indexPathNumAdd];
        }
        //For Chest and Oblique, they don't have stretching, so have to make special SIAlertview.
        if (indexPath.row == 2) {
            NSString *indexPathNum = [NSString stringWithFormat: @"%d", 4];
            [self strengthOnly:indexPathNum];
        }
        if (indexPath.row == 5) {
            NSString *indexPathNum = [NSString stringWithFormat: @"%d", 9];
            [self strengthOnly:indexPathNum];
        }
    }
        else if (indexPath.section == 1) {
            NSString *indexPathNum = [NSString stringWithFormat: @"%ld", (((long)indexPath.row+11)*2)-2];
            NSString *indexPathNumAdd = [NSString stringWithFormat: @"%ld", (((long)indexPath.row+11)*2)-1];
            [self selectRow:indexPathNum second:indexPathNumAdd];
        }
    }
    //Then deselect the row once complete touch/select.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//Creates the SIAlertview, and has the parameters for the segue to perform.
-(void)selectRow:(NSString*)indexPathNum second:(NSString*)indexPathNumAdd {    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"title" andMessage:nil];
    [alertView addButtonWithTitle:strength
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              [self performSegueWithIdentifier:indexPathNum sender:nil];
                          }];
    [alertView addButtonWithTitle:stretching
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              [self performSegueWithIdentifier:indexPathNumAdd sender:nil];
                          }];
    [alertView addButtonWithTitle:cancel
                             type:SIAlertViewButtonTypeCancel
                          handler:nil];
    [alertView show];
    alertView.title = title;
}

//The special SIAlertView for chest and oblique.
-(void)strengthOnly:(NSString*)indexPathNum {
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"title" andMessage:nil];
    [alertView addButtonWithTitle:strength
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              [self performSegueWithIdentifier:indexPathNum sender:nil];
                          }];
    [alertView addButtonWithTitle:cancel
                             type:SIAlertViewButtonTypeCancel
                          handler:nil];
    [alertView show];
    alertView.title = title;
}



//The button that actually performs the search.
- (IBAction)searchButton:(id)sender {
    [self performSelector:@selector(search) withObject:nil];
}


-(void)search {
    
    //Reset the array for another search.
    [selectedTypes removeAllObjects];
    
    //Starting with blank query, and getting name from uitextfield.
    searchQuery = [NSString stringWithFormat:@""];
    //searchName = self.nameSearch.text;
    
    UITableViewCell *Cell = [advancedSearchTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell *Cell2 = [advancedSearchTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITableViewCell *Cell3 = [advancedSearchTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UITableViewCell *Cell4 = [advancedSearchTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    
    //Receiving data values.
    primaryText = Cell.detailTextLabel.text;
    secondaryText = Cell2.detailTextLabel.text;
    difficultyText = Cell4.detailTextLabel.text;
    equipmentText = Cell3.detailTextLabel.text;
    
    //Fills the selected values into their arrays.
    [self fillStoreData];
    
    //Checks what switches are on, and then adds the exercise types into the array if it is on.
    [self selectedTypes];
    
      //Start of query building
    if ([Cell.detailTextLabel.text isEqualToString:@"Any"] && [Cell2.detailTextLabel.text isEqualToString:@"Any"] && [Cell3.detailTextLabel.text isEqualToString:@"Any"] && [Cell4.detailTextLabel.text isEqualToString:@"Any"]) {
         searchQuery = [[searchQuery stringByAppendingString:@" "] stringByAppendingString:[NSString stringWithFormat:@"SELECT * FROM %@ ORDER BY Name COLLATE NOCASE",selectedTypes[0]]];
        NSLog(@"%@", searchQuery);
    }
    else {
        for (int i=0; i<selectedTypes.count; i++) {
            searchQuery = [[searchQuery stringByAppendingString:@" "] stringByAppendingString:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE",selectedTypes[i]]];
            
            for (int k=0; k<selectedValues.count; k++) {
                searchQuery = [[searchQuery stringByAppendingString:@" "]stringByAppendingString:[NSString stringWithFormat:@"%@ LIKE '%%%@%%'",selectedColumns[k],selectedValues[k]]];
                
                if (k != selectedValues.count-1) {
                    searchQuery = [[searchQuery stringByAppendingString:@" "] stringByAppendingString:[NSString stringWithFormat:@"AND "]];
                }
            }
            if (i != selectedTypes.count-1) {
                searchQuery = [[searchQuery stringByAppendingString:@" "] stringByAppendingString:@"UNION ALL"];
            }
            else {
                searchQuery = [[searchQuery stringByAppendingString:@" "]stringByAppendingString:@"ORDER BY Name COLLATE NOCASE"];
            }
            NSLog(@"%@", searchQuery);
        }
    }
    
    //Then check the search with the check search method.
    [self checkSearch:selectedTypes second:@"Please select an exercise type to complete a search."];
}

//Checks what switches are on, and then adds the exercise types into the array if it is on.
-(NSMutableArray*) selectedTypes{
    selectedTypes = [[NSMutableArray alloc] init];
    
    @try {
        UITableViewCell *Cell5 = [advancedSearchTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        NSString *type = Cell5.detailTextLabel.text;
        if ([type isEqualToString:@"Strength"]) {
            [selectedTypes addObject:@"strengthexercises"];
        }
        else if ([type isEqualToString:@"Stretching"]) {
             [selectedTypes addObject:@"stretchingexercises"];
        }
        else {
             [selectedTypes addObject:@"warmupexercises"];
        }
    }
    @finally {
        return selectedTypes;
    }
}

//Filling and storing data into arrays.rgb(46, 204, 113)
-(void) fillStoreData {
    selectedValues = [[NSMutableArray alloc] init];
    selectedColumns = [[NSMutableArray alloc] init];
    
    UITableViewCell *Cell = [advancedSearchTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell *Cell2 = [advancedSearchTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITableViewCell *Cell3 = [advancedSearchTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UITableViewCell *Cell4 = [advancedSearchTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];

    
    if (![Cell.detailTextLabel.text isEqualToString:@"Any"]) {
        [selectedColumns addObject:@"primarymuscle"];
        [selectedValues addObject:primaryText];
    }
    NSLog(@"%@",Cell2.detailTextLabel.text);
    if (![Cell2.detailTextLabel.text isEqualToString:@"Any"]) {
        [selectedColumns addObject:@"secondarymuscle"];
        [selectedValues addObject:secondaryText];
    }
    if (![Cell4.detailTextLabel.text isEqualToString:@"Any"]) {
        [selectedColumns addObject:@"difficulty"];
        [selectedValues addObject:difficultyText];
    }
    if (![Cell3.detailTextLabel.text isEqualToString:@"Any"]) {
        [selectedColumns addObject:@"equipment"];
        [selectedValues addObject:equipmentText];
    }
}

//This checks to see if the search is valid. If it is then perform the search.
-(void)checkSearch:(NSArray*)typesSelected second:(NSString*)messageText {
    if (typesSelected.count == 0)
        [CommonSetUpOperations performTSMessage:messageText message:nil viewController:self canBeDismissedByUser:YES duration:6];
    else
        [self performSegueWithIdentifier:@"search" sender:nil];
}



- (void)done:(NSString*)selectedValue num:(NSInteger *)cell {
    primaryText = selectedValue;
    UITableViewCell *Cell = [advancedSearchTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITableViewCell *Cell2 = [advancedSearchTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITableViewCell *Cell3 = [advancedSearchTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    UITableViewCell *Cell4 = [advancedSearchTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    UITableViewCell *Cell5 = [advancedSearchTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    
    if (*cell == 0) {
        Cell.detailTextLabel.text = selectedValue;
    }
    else if (*cell == 1) {
        Cell2.detailTextLabel.text = selectedValue;
    }
    else if (*cell == 2) {
        Cell3.detailTextLabel.text = selectedValue;
    }
    else if (*cell == 3) {
        Cell4.detailTextLabel.text = selectedValue;
    }
    else if (*cell == 4) {
        Cell5.detailTextLabel.text = selectedValue;
    }
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

     NSInteger segueInt = [segue.identifier intValue];
    
    if ([segue.identifier isEqualToString:@"advancedOptions"]) {
        NSIndexPath *indexPath = [advancedSearchTableView indexPathForSelectedRow];
        UINavigationController *nav = segue.destinationViewController;
        advancedOptionsSelect *triv = [[advancedOptionsSelect alloc]init];
        triv = nav.viewControllers[0];
        triv.num = indexPath.row;
        triv.delegate = self;
        if (indexPath.row == 0) {
            triv.arrayForTableView = primaryMuscleList;
            triv.titleText = @"Select Muscle";
            triv.isExerciseType = NO; 
        }
        else if (indexPath.row == 1) {
            triv.arrayForTableView = secondaryMuscleList;
            triv.titleText = @"Select Muscle";
            triv.isExerciseType = NO;
        }
        else if (indexPath.row == 2) {
            triv.arrayForTableView = equipmentList;
            triv.titleText = @"Select Equipment";
            triv.isExerciseType = NO;
        }
        else if (indexPath.row == 3) {
            triv.arrayForTableView = difficultyList;
            triv.titleText = @"Select Difficulty";
            triv.isExerciseType = NO;
        }
        else if (indexPath.row == 4) {
            NSArray *exerciseTypes = @[@"Strength",@"Stretching",@"Warmup"];
            triv.arrayForTableView = exerciseTypes;
            triv.titleText = @"Select Exercise Type";
            triv.isExerciseType = NO;
        }
    }
    else {
        if (segueInt < queries.count) {
            ImprovedExerciseController *parentViewController = segue.destinationViewController;
            parentViewController.query = queries[segueInt];
            parentViewController.titleText = titleText[segueInt];
        }
        if ([segue.identifier isEqualToString:@"search"]) {
            ImprovedExerciseController *destViewController = segue.destinationViewController;
            destViewController.query = searchQuery;
            destViewController.titleText = @"Custom Search";
        }
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}


- (IBAction)segmentValueChanged:(UISegmentedControl*)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self setHidden:NO second:YES];
            break;
        case 1:
            [self setHidden:YES second:NO];
        default:
            break;
    }
}

-(void)setHidden:(BOOL)muscleListHide second:(BOOL)advancedSearchHide {
    self.muscleList.hidden = muscleListHide;
    self.advancedSearch.hidden = advancedSearchHide;
}

@end
