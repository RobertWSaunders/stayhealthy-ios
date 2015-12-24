//
//  WorkoutsAdvancedSearchViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-25.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import "WorkoutsAdvancedSearchViewController.h"

@interface WorkoutsAdvancedSearchViewController ()

@end

@implementation WorkoutsAdvancedSearchViewController

/*********************************/
#pragma mark - View Loading Methods
/*********************************/

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self fetchAndLoadInformation];
    
    //Style the search button.
    //Set the background color of the button.
    self.searchButton.backgroundColor = STAYHEALTHY_BLUE;
    //Set the text color for the button.
    self.searchButton.titleLabel.textColor = [UIColor whiteColor];
    //Set the text for the button.
    self.searchButton.titleLabel.text = @"Search";
    
    //Set the scrollviews to not adjust to the insets, this adds a 60point gap between tableview and navigation bar.
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (IS_IPHONE_4_OR_LESS) {
        self.workoutSpecificationTableView.scrollEnabled = YES;
    }
    else {
        //Disable the ability for the users to scroll.
        self.workoutSpecificationTableView.scrollEnabled = NO;
    }

    
}

/*****************************************************/
#pragma mark - UITableView Delegate/Datasource Methods
/*****************************************************/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Returns the height of the TableView.
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Set the height of the tableview cells to be the constant.
    return 50;
}

//Returns the height of the section headers.
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

//Returns the height of the footers.
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

//Returns the number of sections of a TableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //Return the number of section headers.
    return [tableViewSectionHeaders count];
}

//Returns the number of rows in the section of a TableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        //Return the number of exercise attributes.
        return [workoutAdvancedSearchOptions count];
    }
    else {
        //Return one for the search exercise name.
        return 1;
    }
}

//Returns the title for the section headers.
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //Return the titles for the sections.
    if (section == 1) {
        //For section 1.
        return @"Workout Attributes";
    }
    else {
        //For section 0.
        return @"Search Workout Name";
    }
}

//Cell for row at index path for the TableViews
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //The first section is just attributes that push to the attribute selection page.
    if (indexPath.section == 1) {
        
        //Set the cell identifier.
        static NSString *advancedItem = @"advancedItem";
        
        //Create reference to the UITableViewCell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:advancedItem];
        
        //If the cell is nil create a new one.
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:advancedItem];
        }
        
        //Set the cell text label.
        cell.textLabel.text = [workoutAdvancedSearchOptions objectAtIndex:indexPath.row];
        //Set the detail text.
        cell.detailTextLabel.text = [tableViewAttributeSelectionsUserInterface objectAtIndex:indexPath.row];
        
        //Stlying the cells.
        cell.textLabel.font = tableViewTitleTextFont;
        cell.detailTextLabel.font = tableViewDetailTextFont;
        cell.textLabel.textColor = STAYHEALTHY_BLUE;
        cell.detailTextLabel.textColor = STAYHEALTHY_LIGHTGRAYCOLOR;
        
        //Set the selection cell.
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
        
        //Return the cell.
        return cell;
    }
    //The second section has a custom UITableViewCell with a UITextField.
    else {
        //Set the cell identifier.
        static NSString *advancedNameSearchItem = @"customCellWithTextField";
        
        //Create reference to the UITableViewCell.
        TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:advancedNameSearchItem];
        
        //If the cell is nil create a new one.
        if (cell == nil) {
            cell = [[TextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:advancedNameSearchItem];
        }
        
        //Set the cell label.
        cell.cellLabel.text = @"Workout Name";
        cell.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName:STAYHEALTHY_LIGHTGRAYCOLOR}];
        //Set the textfiled delegate to self.
        cell.textField.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //Stlying the cells.
        cell.cellLabel.font = tableViewTitleTextFont;
        cell.cellLabel.textColor = STAYHEALTHY_BLUE;
        cell.textField.font = tableViewDetailTextFont;
        cell.textField.textColor = STAYHEALTHY_LIGHTGRAYCOLOR;
        
        //Return the cell.
        return cell;
    }
}

//Controls what happens when a user presses a cell,
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[self performSegueWithIdentifier:@"searchOptions" sender:nil];
    //Deselect the row once complete touch/select.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/******************************************/
#pragma mark - UITextField Delegate Methods
/******************************************/

//When the user presses the return key on the textfield dismiss the keyboard.
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    //Dismiss the keyboard.
    [textField resignFirstResponder];
    return YES;
}

/*******************************/
#pragma mark - Prepare For Segue
/*******************************/

//Handles what happens when a user performs a segue.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"searchOptions"]) {
        //What happens when the user selects a cell in the table view, takes the user to selection page.
        //Get the index path for the selected cell the user pressed.
        NSIndexPath *indexPath = [self.workoutSpecificationTableView indexPathForSelectedRow];
        //Create reference to the next view controller.
        advancedOptionsSelect *attributeSelectionPage = [[advancedOptionsSelect alloc]init];
        //Set the destination.
        attributeSelectionPage = segue.destinationViewController;
        //Set the properities for the next page.
        //Set the indexPath to the indexPath.
        attributeSelectionPage.indexPathPassed = indexPath;
        //Have to tell the next view that the delegate is this page.
        attributeSelectionPage.delegate = self;
        //Initialize the selected cells array from this view.
        attributeSelectionPage.selectedCells = [[NSMutableArray alloc] init];
        //Get the cell that the user selected.
        UITableViewCell *cell = [self.workoutSpecificationTableView cellForRowAtIndexPath:indexPath];
        //Do something only if the cell isn't the default.
        if (![cell.detailTextLabel.text isEqualToString:@"Any"]) {
            //Send what has been selected by the user, default is 'Any'
            attributeSelectionPage.selectedCells = [self convertDetailTextToArray:indexPath];
        }
        //Now pass specific things dependant on what cell the user pressed.
        if (indexPath.section == 1) {
            //First row is primary muscle selection.
            if (indexPath.row == 0) {
                attributeSelectionPage.arrayForTableView = targetMuscles;
                attributeSelectionPage.titleText = @"Select Target Muscles";
            }
            //Third row is equipment selection.
            else if (indexPath.row == 1) {
                attributeSelectionPage.arrayForTableView = sportsList;
                attributeSelectionPage.titleText = @"Select Target Sports";
            }
            //Third row is equipment selection.
            else if (indexPath.row == 2) {
                attributeSelectionPage.arrayForTableView = equipmentList;
                attributeSelectionPage.titleText = @"Select Equipment";
            }
            //Fourth row is difficulty selection.
            else if (indexPath.row == 3) {
                attributeSelectionPage.arrayForTableView = difficultyList;
                attributeSelectionPage.titleText = @"Select Difficulties";
            }
            //Fith row is exercise type selection.
            else if (indexPath.row == 4) {
                NSArray *differentTypesOfWorkouts = @[@"Warm-Up",@"Build Muscle",@"Injury Prevention",@"Core",@"Home Workout",@"General",@"Cardio",@"Stretch"];
                attributeSelectionPage.arrayForTableView = differentTypesOfWorkouts;
                attributeSelectionPage.titleText = @"Select Workout Types";
            }
        }
    }
    else if ([segue.identifier isEqualToString:@"search"]) {
        WorkoutListViewController *workoutsSearchViewController = [[WorkoutListViewController alloc] init];
        workoutsSearchViewController = segue.destinationViewController;
        workoutsSearchViewController.workoutQuery = searchQuery;
        workoutsSearchViewController.viewTitle =  @"Custom Search";
        
    }
}


//What gets fired when the user presses the back button in the selection page.
- (void)userHasSelected:(NSMutableArray *)selectedValues indexPath:(NSIndexPath *)indexPath passedArrayCount:(NSInteger)passedArrayCount {
    //Only if the user selected something then update the table.
    if (selectedValues.count > 0 && selectedValues.count < passedArrayCount) {
        //Replace the defaults or the previous selections.
        [workoutAdvancedSearchOptionsSelections replaceObjectAtIndex:indexPath.row withObject:[self convertSelectionsToString:selectedValues]];
        [tableViewAttributeSelectionsUserInterface replaceObjectAtIndex:indexPath.row withObject:[self convertSelectionsToStringWithSpace:selectedValues]];
    }
    else {
        //Set the object to 'Any' (default) if nothing was selected.
        [workoutAdvancedSearchOptionsSelections replaceObjectAtIndex:indexPath.row withObject:@"Any"];
        [tableViewAttributeSelectionsUserInterface replaceObjectAtIndex:indexPath.row withObject:@"Any"];
    }
    //Update the user interface.
    [self.workoutSpecificationTableView reloadData];
}


/*****************************/
#pragma mark - Actions
/*****************************/

- (IBAction)dismissButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//What happens when the user presses the search button at the bottom of the screen.
- (IBAction)searchButtonPressed:(id)sender {
    //Perform the search.
    [self search];
}

//Filling and storing data into arrays.

-(void) fillSelectedData {
    //Create references to the cells.
    //The cell responsible for the name search.
    TextFieldTableViewCell *exerciseNameCell = (TextFieldTableViewCell *)[self.workoutSpecificationTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //The cell responsible for the primary muscle.
    UITableViewCell *targetMuscleCell = [self.workoutSpecificationTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
        //The cell responsible for the equipment.
    UITableViewCell *targetSportCell = [self.workoutSpecificationTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    UITableViewCell *equipmentCell = [self.workoutSpecificationTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    //The cell responsible for the difficulty.
    UITableViewCell *difficultyCell = [self.workoutSpecificationTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    //The cell responsible for the exercise type.
    UITableViewCell *workoutTypeCell = [self.workoutSpecificationTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:1]];
    
    //Initialize the selected types array
    selectedWorkoutTypes = nil;
    
    //Empty the arrays.
    selectedDifficulty = nil;
    selectedTargetMuscles = nil;
    selectedEquipment =  nil;
    selectedSports = nil;
    
    //Put the data into the arrays, only if the user has selected
    //Selected primary muscles array.
    if (![targetMuscleCell.detailTextLabel.text isEqualToString:@"Any"]) {
        selectedTargetMuscles = [targetMuscleCell.detailTextLabel.text componentsSeparatedByString:@", "];
    }
    //Selected equipment array.
    if (![targetSportCell.detailTextLabel.text isEqualToString:@"Any"]) {
        selectedSports = [targetSportCell.detailTextLabel.text componentsSeparatedByString:@", "];
    }
    //Selected equipment array.
    if (![equipmentCell.detailTextLabel.text isEqualToString:@"Any"]) {
        selectedEquipment = [equipmentCell.detailTextLabel.text componentsSeparatedByString:@", "];
    }
    //Selected difficulty array.
    if (![difficultyCell.detailTextLabel.text isEqualToString:@"Any"]) {
        selectedDifficulty = [difficultyCell.detailTextLabel.text componentsSeparatedByString:@", "];
    }
    //Selected exercise types array.
    if (![workoutTypeCell.detailTextLabel.text isEqualToString:@"Any"]) {
        selectedWorkoutTypes = [workoutTypeCell.detailTextLabel.text componentsSeparatedByString:@", "];
    }
    
    //Get the text the user has or hasn't entered in the exercise name textfield.
    selectedName = exerciseNameCell.textField.text;
}

//Performs a search, builds the query, and executes onto other screen.
-(void)search {
    //This performs a search for the StayHealthy exercises.
    //Starting with blank query.
        searchQuery = @"";
        
        //Fill the arrays with their information.
        [self fillSelectedData];
        
        //Start of query building.

            //Array which holds the attribute values the user has selected.
            NSMutableArray *selectedArrays = [[NSMutableArray alloc] init];
            //Array which holds the column names the user has selected.
            NSMutableArray *selectedColumns= [[NSMutableArray alloc] init];
            if (selectedTargetMuscles.count > 0) {
                [selectedArrays addObject:selectedTargetMuscles];
                [selectedColumns addObject:@"workoutTargetMuscles"];
            }
            if (selectedEquipment.count > 0) {
                [selectedArrays addObject:selectedEquipment];
                [selectedColumns addObject:@"workoutEquipment"];
            }
            if (selectedDifficulty.count > 0) {
                [selectedArrays addObject:selectedDifficulty];
                [selectedColumns addObject:@"workoutDifficulty"];
            }
            if (selectedWorkoutTypes.count > 0) {
                [selectedArrays addObject:selectedWorkoutTypes];
                [selectedColumns addObject:@"workoutType"];
            }
            if (selectedSports.count > 0) {
                [selectedArrays addObject:selectedSports];
                [selectedColumns addObject:@"workoutTargetSports"];
            }
    
    
            //Create the initial SELECT * FROM for the specific table.
            searchQuery = [[searchQuery stringByAppendingString:@" "] stringByAppendingString:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE", WORKOUTS_DB_TABLENAME]];
    
            //Now create a for loop for the columns.
                for (int k=0; k<selectedArrays.count; k++) {
                    //So if there are a second or third or fourth column selected add them to the query.
                    if (selectedArrays.count > 1 && k > 0) {
                        searchQuery = [[searchQuery stringByAppendingString:@" "] stringByAppendingString:[NSString stringWithFormat:@"AND"]];
                    }
                    //Now create the array that holds the different values for the column we are handling right now.
                    NSArray *arrayForSelection = [selectedArrays objectAtIndex:k];
                    //Now create a for loop for the values in the columns.
                    for (int m=0; m<arrayForSelection.count; m++) {
                        //Now input the column and the value for the column into the query.
                        searchQuery = [[searchQuery stringByAppendingString:@" "]stringByAppendingString:[NSString stringWithFormat:@"%@ LIKE '%@'",selectedColumns[k],arrayForSelection[m]]];
                        if (m != arrayForSelection.count-1) {
                            searchQuery = [[searchQuery stringByAppendingString:@" "] stringByAppendingString:[NSString stringWithFormat:@"OR"]];
                        }
                    }
                }
                //Or if it is the last table then just order the resulting exercises by name.
                if (![selectedName isEqualToString:@""]) {
                    searchQuery = [[searchQuery stringByAppendingString:@" "]stringByAppendingString:[NSString stringWithFormat:@"AND workoutName LIKE '%%%@%%' ORDER BY workoutName COLLATE NOCASE",selectedName]];
                }
                else {
                    searchQuery = [[searchQuery stringByAppendingString:@" "]stringByAppendingString:@"ORDER BY workoutName COLLATE NOCASE"];
                }
            LogDataSuccess(@"*****************************************");
            LogDataSuccess(@"ADVANCED SEARCH QUERY: %@", searchQuery);
            LogDataSuccess(@"*****************************************");
    
    //Perform the search and go to view exercises view controller.
    [self performSegueWithIdentifier:@"search" sender:nil];
}


/*****************************/
#pragma mark - Utility Methods
/*****************************/

- (void)fetchAndLoadInformation {
    
    //List of all the primary muscles.
    targetMuscles = [CommonUtilities returnGeneralPlist][@"primaryMuscles"];
    //List of all the types of equipment.
    equipmentList = [CommonUtilities returnGeneralPlist][@"equipmentList"];
    //List of all the types of difficulty.
    difficultyList = [CommonUtilities returnGeneralPlist][@"difficultyList"];
    sportsList = [CommonUtilities returnGeneralPlist][@"sports2"];
    
    //The values of the advanced search titles in the TableView.
    workoutAdvancedSearchOptions = @[@"Target Muscles",@"Target Sports",@"Equipment",@"Difficulty",@"Workout Type"];
    
    //The defaults in the advanced search view.
    workoutAdvancedSearchOptionsSelections = [[NSMutableArray alloc] initWithObjects:@"Any",@"Any",@"Any",@"Any",@"Any", nil];
    tableViewAttributeSelectionsUserInterface = [[NSMutableArray alloc] initWithObjects:@"Any",@"Any",@"Any",@"Any",@"Any", nil];
    
    //The header text for the TableView section headers.
    tableViewSectionHeaders = @[@"Workout Attributes",@"Search Workout Name"];
}


//Converts array objects into string.
- (NSString*)convertSelectionsToString:(NSMutableArray*)convertSelectionsToString {
    //Creates a string with the objects of the array seperated by a comma.
    return [convertSelectionsToString componentsJoinedByString:@","];
}
//Converts array objects into string.
- (NSString*)convertSelectionsToStringWithSpace:(NSMutableArray*)convertSelectionsToString {
    //Creates a string with the objects of the array seperated by a comma.
    return [convertSelectionsToString componentsJoinedByString:@", "];
}

//Converts what is presented as the detailText label into an array to pass to the selection view so that the selections can be checkmarked.
- (NSMutableArray*)convertDetailTextToArray:(NSIndexPath*)indexPath {
    //Create the array/
    NSArray *detailTextArray;
    //Make reference to the TableView cell.
    UITableViewCell *cell = [self.workoutSpecificationTableView cellForRowAtIndexPath:indexPath];
    //Only if the cell has something selected and is not the default.
    if (![cell.detailTextLabel.text isEqualToString:@"Any"]) {
        //Get the information into array format.
        detailTextArray = [[workoutAdvancedSearchOptionsSelections objectAtIndex:indexPath.row] componentsSeparatedByString:@","];
    }
    //Return the mutable copy.
    return [detailTextArray mutableCopy];
}

@end
