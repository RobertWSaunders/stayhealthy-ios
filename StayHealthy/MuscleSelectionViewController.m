//
//  MuscleSelectionViewController.m
//  StayHealthy
//
//  Created by Student on 12/7/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
//

/*************************************************IMPLEMENTATION FILE************************************/
/*************************************************REVISIT FOR VERSION 2.0.0************************************/
//Incorporate better and more effective code, especially for passing the queryies to the next view controller.

#import "MuscleSelectionViewController.h"
//^^^^^^^^^^Import the header file.

@interface MuscleSelectionViewController ()

@end

@implementation MuscleSelectionViewController

@synthesize sidebarButton, warmup, strengthCheck, stretchingCheck, warmUpCheck;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    advancedSearchTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    advancedSearchTableView.scrollEnabled = NO;
    
    UIColor *barColor = [UIColor colorWithRed:244.0f/255.0f green:244.0f/255.0f blue:244.0f/255.0f alpha:1.0f];
    searchBar.barTintColor = barColor;
    searchBar.tintColor = barColor;
    
    //Give the ViewController a title.
    self.navigationController.title = @"Find Exercise";

    
    //Style the SIAlertView asking what exercise type.
    [[SIAlertView appearance] setTitleFont:[UIFont fontWithName:@"Avenir-Light" size:20]];
    [[SIAlertView appearance] setTitleColor:[UIColor peterRiverColor]];
    [[SIAlertView appearance] setMessageColor:[UIColor peterRiverColor]];
    [[SIAlertView appearance] setCornerRadius:4];
    [[SIAlertView appearance] setShadowRadius:0];
    [[SIAlertView appearance] setViewBackgroundColor:[UIColor cloudsColor]];
    [[SIAlertView appearance] setButtonColor:[UIColor peterRiverColor]];
    [[SIAlertView appearance] setDestructiveButtonColor:[UIColor peterRiverColor]];
    [[SIAlertView appearance] setCancelButtonColor:[UIColor peterRiverColor]];
    [[SIAlertView appearance] setButtonFont:[UIFont fontWithName:@"Avenir-Light" size:18]];

    
    // Set the gesture for the sidebar toggle.
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //Check to see if its the users first time on this page. If so launch a TSMessage welcoming them and providing info.

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
    
    //Advanced Search Setup and its arrays.
    _nameSearch.delegate = self;
    
    //Styling the search button.
    self.searchButton.backgroundColor = [UIColor peterRiverColor];
    /*
    //If iPhone 5 then position and size the search button this way.
    if (IPHONE5) {
        self.searchButton.frame = CGRectMake(0,417,320,59);//x,y,w,h
    } else
        self.searchButton.frame = CGRectMake(0,330,320,59);//x,y,w,h
*/
    
    //If iPhone 5 then position and size the tableview this way.
    if (IPHONE5) {
        selectMuscleTableView.frame = CGRectMake(0,46,320,427);//x,y,w,h
    }
}

-(void)viewWillAppear:(BOOL)animated {
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunch1"])
    {
        
              [TSMessage showNotificationInViewController:self
                                              title:@"Welcome to the exercise selection page! Here you can change between the muscle list and advanced search. Simply choose the muscle you'd like to exercise or you can use the advanced search to choose specifics, like the type of equipment, difficulty, muscle groups, if you want a more specific result. Looking for a warm-up? Press the running icon in the top right. Tap this message to dismiss."
                                           subtitle:nil
                                              image:nil
                                               type:TSMessageNotificationTypeMessage
                                           duration:TSMessageNotificationDurationEndless
                                           callback:nil                                        buttonTitle:nil
                                     buttonCallback:nil
                                         atPosition:TSMessageNotificationPositionTop
                                canBeDismisedByUser:YES];

        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLaunch1"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}

//What happens if the Warmup UIBarButton is pressed.
-(void)warmup:(id)sender{
    [self performSegueWithIdentifier:@"30" sender:self];
}

//MUSCLE LIST STUFF - THE TABLEVIEW STUFF
/*****************************************************************/

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

//The view for the header in the tableview.
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    //Create a view for the header.
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 18)];
    
    //Now customize that view.
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 4, tableView.frame.size.width, 18)];
    [label setFont:[UIFont fontWithName:@"Avenir-Light" size:15]];
    label.textColor = [UIColor peterRiverColor];
    
    // Section header is in 0th index
    if (tableView == selectMuscleTableView && section == 0) {
        label.text = @"Front Muscles";
    }
    else if (tableView == selectMuscleTableView &&  section == 1) {
        label.text = @"Back Muscles";
    }
    else if (tableView == advancedSearchTableView &&  section == 0) {
        label.text = @"Configure Specifications";
    }
    else
    label.text = nil;
    [view addSubview:label];
    [view setBackgroundColor:[UIColor cloudsColor]];
    
    return view;

}


//Design and fill the tableview cells.
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
        cell.textLabel.font = [UIFont fontWithName:@"Avenir" size:17];
        cell.detailTextLabel.font = [UIFont fontWithName:@"Avenir-Light" size:14];
        cell.textLabel.textColor = [UIColor peterRiverColor];
        cell.detailTextLabel.textColor = [UIColor peterRiverColor];
        
        //Then the background color view.
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor cloudsColor];
        bgColorView.layer.masksToBounds = YES;
        [cell setSelectedBackgroundView:bgColorView];
        //Then return the cell.

    
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
        cell2.textLabel.font = [UIFont fontWithName:@"Avenir" size:17];
        cell2.detailTextLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16];
        cell2.textLabel.textColor = [UIColor peterRiverColor];
        cell2.detailTextLabel.textColor = [UIColor lightGrayColor];
        
        //Then the background color view.
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor cloudsColor];
        bgColorView.layer.masksToBounds = YES;
        [cell2 setSelectedBackgroundView:bgColorView];
        
        //Then return the cell.
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

/*****************************************************************/
//END OF TABLEVIEW - MUSCLE LIST

/*****************************************************************/
//ADVANCED SEARCH

//The button that actually performs the search.
- (IBAction)searchButton:(id)sender {
    [self performSelector:@selector(search) withObject:nil];
}

/*
- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex{
    if (self.primaryPressed) {
        _primaryLabel.text=[primaryMuscleList objectAtIndex:anIndex];
    }
    else if (self.secondaryPressed) {
        _secondaryLabel.text=[secondaryMuscleList objectAtIndex:anIndex];
    }
    else if (self.equipmentPressed) {
        _equipmentLabel.text=[equipmentList objectAtIndex:anIndex];
    }
    else if (self.difficultyPressed) {
        _difficultLabel.text=[difficultyList objectAtIndex:anIndex];
    }
}
*/
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
            /*
            if (selectedValues.count > 0) {
                searchQuery = [[searchQuery stringByAppendingString:@" "]stringByAppendingString:[NSString stringWithFormat:@"AND Name LIKE '%%%@%%'",searchName]];
            }
            else {
                searchQuery = [[searchQuery stringByAppendingString:@" "]stringByAppendingString:[NSString stringWithFormat:@"Name LIKE '%%%@%%'",searchName]];
            }
            */
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
        [TSMessage showNotificationInViewController:self
                                              title:messageText
                                           subtitle:nil
                                              image:nil
                                               type:TSMessageNotificationTypeMessage
                                           duration:6
                                           callback:nil
                                        buttonTitle:nil
                                     buttonCallback:nil
                                         atPosition:TSMessageNotificationPositionTop
                                canBeDismisedByUser:YES];
        
    else
        [self performSegueWithIdentifier:@"search" sender:nil];
}
/*
//The method that shows the pop up, dependant on a few parameters.
-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple{
    
    exerciseType = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    exerciseType.delegate = self;
    [exerciseType showInView:self.view animated:YES];
    
    [exerciseType SetBackGroundDropDwon_R:52.0 G:152.0 B:219.0 alpha:0.95];
    
}

//What happens when the primary muscle button is pressed.
- (IBAction)PrimaryMuscle:(id)sender {
    [self checkBools:NO second:YES third:NO fourth:NO fith:NO];
    [self showPopUpWithTitle:@"Select Primary Muscle" withOption:primaryMuscleList xy:CGPointMake(16, 106) size:CGSizeMake(287, 370) isMultiple:NO];
}

//What happens when the secondary muscle button is pressed.
- (IBAction)SecondaryMuscle:(id)sender {
    [self checkBools:NO second:NO third:NO fourth:NO fith:YES];
    [self showPopUpWithTitle:@"Select Secondary Muscle" withOption:primaryMuscleList xy:CGPointMake(16, 106) size:CGSizeMake(287, 370) isMultiple:NO];
}

//What happens when the difficulty button is pressed.
- (IBAction)Difficulty:(id)sender {
    [self checkBools:NO second:NO third:YES fourth:NO fith:NO];
    [self showPopUpWithTitle:@"Select Difficulty" withOption:difficultyList xy:CGPointMake(16, 106) size:CGSizeMake(287, 226) isMultiple:NO];
}

//What happens when the equipment button is pressed.
- (IBAction)Equipment:(id)sender {
    [self checkBools:NO second:NO third:NO fourth:YES fith:NO];
    [self showPopUpWithTitle:@"Select Equipment" withOption:equipmentList xy:CGPointMake(16, 106) size:CGSizeMake(287, 370) isMultiple:NO];
}


-(void)checkBools:(BOOL)exerciseTypePressed second:(BOOL)primaryPressed third:(BOOL)difficultyPressed fourth:(BOOL)equipmentPressed fith:(BOOL) secondaryPressed{
    self.exerciseTypePressed = exerciseTypePressed;
    self.primaryPressed = primaryPressed;
    self.difficultyPressed = difficultyPressed;
    self.equipmentPressed = equipmentPressed;
    self.secondaryPressed = secondaryPressed;
    [exerciseType fadeOut];
}

*/
//This is for the text field, it resignFirstResponder.
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [_nameSearch resignFirstResponder];
    return YES;
}

/*****************************************************************/
//END OF ADVANCED SEARCH

/*****************************************************************/
//START OF BODY VIEW
//Switching the views one way.
- (IBAction)switchViews:(id)sender {
    [self switchViewsHide:YES second:NO];
}

//Switching the views another way, back.
- (IBAction)switchViewBack:(id)sender {
    [self switchViewsHide:NO second:YES];
}

//Checks which views to hide.
-(void)switchViewsHide:(BOOL)front second:(BOOL)back {
    self.frontBodyView.hidden = front;
    self.backBodyView.hidden = back;
}

//END OF BODY VIEW
/*****************************************************************/

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


//PREPARE FOR SEGUE, PASSES THE QUERIES
/*****************************************************************/

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

/*****************************************************************/
//END OF PREPARE FOR SEGUE

//If the user leaves the page then dismiss the all TSMessages.
-(void)viewWillDisappear:(BOOL)animated {
    [TSMessage dismissActiveNotification];
}

//Segment Value changed. Toggles between the views.
- (IBAction)segmentValueChanged:(UISegmentedControl*)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self setHidden:NO second:YES third:YES];
            break;
        case 1:
            [self setHidden:YES second:YES third:NO];
        default:
            break;
    }
}

//Set the views hidden or not.
-(void)setHidden:(BOOL)muscleListHide second:(BOOL)bodyViewHide third:(BOOL)advancedSearchHide {
    self.muscleList.hidden = muscleListHide;
    self.bodyView.hidden = bodyViewHide;
    self.advancedSearch.hidden = advancedSearchHide;
}

//BODYVIEW BUTTONS

- (IBAction)abdominalButton:(id)sender {
    [self selectRow:@"0" second:@"1"];
}
- (IBAction)pectoralisButton:(id)sender {
    [self strengthOnly:@"4"];
}
- (IBAction)quadriceps:(id)sender {
    [self selectRow:@"12" second:@"13"];
}
- (IBAction)traps:(id)sender {
    [self selectRow:@"10" second:@"11"];
}
- (IBAction)biceps:(id)sender {
    [self selectRow:@"2" second:@"3"];
}
- (IBAction)forearms:(id)sender {
    [self selectRow:@"5" second:@"6"];
}
- (IBAction)groin:(id)sender {
    [self selectRow:@"7" second:@"8"];
}
- (IBAction)oblique:(id)sender {
    [self strengthOnly:@"9"];
}
- (IBAction)shoulder:(id)sender {
    [self selectRow:@"14" second:@"15"];
}
- (IBAction)tricep:(id)sender {
    [self selectRow:@"16" second:@"17"];
}
- (IBAction)wrist:(id)sender {
    [self selectRow:@"18" second:@"19"];
}
- (IBAction)calf:(id)sender {
    [self selectRow:@"20" second:@"21"];
}
- (IBAction)glutes:(id)sender {
    [self selectRow:@"22" second:@"23"];
}
- (IBAction)hamstring:(id)sender {
    [self selectRow:@"24" second:@"25"];
}
- (IBAction)lats:(id)sender {
    [self selectRow:@"26" second:@"27"];
}
- (IBAction)lowerback:(id)sender {
    [self selectRow:@"28" second:@"29"];
}

@end

/***********************************************END OF CLASS*****************************************/
