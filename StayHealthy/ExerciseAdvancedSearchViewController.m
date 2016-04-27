//
//  ExerciseAdvancedSearchViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-07-05.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "ExerciseAdvancedSearchViewController.h"

@implementation ExerciseAdvancedSearchViewController

/*********************************/
#pragma mark - View Loading Methods
/*********************************/

- (void)viewDidLoad {
    
    //Fetches the information from the plist and fills the arrays.
    [self fetchAndLoadInformation];
    
    //Set the scrollviews to not adjust to the insets, this adds a 60point gap between tableview and navigation bar.
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (IS_IPHONE_4_OR_LESS) {
        self.exerciseSpecificationTableView.scrollEnabled = YES;
    }
    else {
        //Disable the ability for the users to scroll.
        self.exerciseSpecificationTableView.scrollEnabled = NO;
    }
    
    //Style the search button.
    //Set the background color of the button.
    self.searchButton.backgroundColor = BLUE_COLOR;
    //Set the text color for the button.
    self.searchButton.titleLabel.textColor = [UIColor whiteColor];
    //Set the text for the button.
    self.searchButton.titleLabel.text = @"Search";
    
    [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_FIND_EXERCISE_ADVANCED_SEARCH  viewController:self message:@"Here you can choose the things you want in an exercise and I'll try my best to find it for you! Sometimes I can't find anything though, I'm really sorry about that, but I promise I'll look harder next time!"];
    
}

/*****************************************************/
#pragma mark - UITableView Delegate/Datasource Methods
/*****************************************************/

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
        return [exerciseAdvancedSearchOptions count];
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
        return @"Exercise Attributes";
    }
    else {
        //For section 0.
        return @"Search Exercise Name";
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
        cell.textLabel.text = [exerciseAdvancedSearchOptions objectAtIndex:indexPath.row];
        //Set the detail text.
        cell.detailTextLabel.text = [tableViewAttributeSelectionsUserInterface objectAtIndex:indexPath.row];
        
        //Stlying the cells.
        cell.textLabel.font = tableViewTitleTextFont;
        cell.detailTextLabel.font = tableViewDetailTextFont;
        cell.textLabel.textColor = BLUE_COLOR;
        cell.detailTextLabel.textColor = LIGHT_GRAY_COLOR;
        
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
        cell.cellLabel.text = @"Exercise Name";
        cell.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Name" attributes:@{NSForegroundColorAttributeName:LIGHT_GRAY_COLOR}];
        //Set the textfiled delegate to self.
        cell.textField.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //Stlying the cells.
        cell.cellLabel.font = tableViewTitleTextFont;
        cell.cellLabel.textColor = BLUE_COLOR;
        cell.textField.font = tableViewDetailTextFont;
        cell.textField.textColor = LIGHT_GRAY_COLOR;
        
        //Return the cell.
        return cell;
    }
}

//Controls what happens when a user presses a cell,
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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

/****************************/
#pragma mark - Search Methods
/****************************/

//Performs a search, builds the query, and executes onto other screen.
-(void)search {
    //This performs a search for the StayHealthy exercises.
    if (self.segmentedControl.selectedSegmentIndex == 0) {
        //Starting with blank query.
        searchQuery = @"";
    
        //Fill the arrays with their information.
        [self fillSelectedData];
    
        //Start of query building.
        //First 'if block for when the user only selects an exercise type.
        if (selectedPrimaryMuscles.count == 0 && selectedSecondaryMuscles.count == 0 && selectedEquipment.count == 0 && selectedDifficulty.count == 0 && [selectedName isEqualToString:@""]) {
            for (int i = 0; i < selectedExerciseTypes.count; i++) {
                searchQuery = [[searchQuery stringByAppendingString:@" "] stringByAppendingString:[NSString stringWithFormat:@"SELECT * FROM %@",selectedExerciseTypes[i]]];
                if (i != selectedExerciseTypes.count-1) {
                    searchQuery = [[searchQuery stringByAppendingString:@" "] stringByAppendingString:[NSString stringWithFormat:@"UNION ALL"]];
                }
                else {
                    searchQuery = [[searchQuery stringByAppendingString:@" "]stringByAppendingString:@"ORDER BY exerciseName COLLATE NOCASE"];
                }
            }
            NSLog(@"*****************************************");
            NSLog(@"ADVANCED SEARCH QUERY: %@", searchQuery);
            NSLog(@"*****************************************");
        }
        //More advanced, using the choosen attributes to create the query.
        else {
            //Array which holds the attribute values the user has selected.
            NSMutableArray *selectedArrays = [[NSMutableArray alloc] init];
            //Array which holds the column names the user has selected.
            NSMutableArray *selectedColumns= [[NSMutableArray alloc] init];
            if (selectedPrimaryMuscles.count > 0) {
                [selectedArrays addObject:selectedPrimaryMuscles];
                [selectedColumns addObject:@"exercisePrimaryMuscle"];
            }
            if (selectedSecondaryMuscles.count > 0) {
                [selectedArrays addObject:selectedSecondaryMuscles];
                [selectedColumns addObject:@"exerciseSecondaryMuscle"];
            }
            if (selectedEquipment.count > 0) {
                [selectedArrays addObject:selectedEquipment];
                [selectedColumns addObject:@"exerciseEquipment"];
            }
            if (selectedDifficulty.count > 0) {
                [selectedArrays addObject:selectedDifficulty];
                [selectedColumns addObject:@"exerciseDifficulty"];
            }
            if (selectedForceType.count > 0) {
                [selectedArrays addObject:selectedForceType];
                [selectedColumns addObject:@"exerciseForceType"];
            }
            if (selectedMechanicsType.count > 0) {
                [selectedArrays addObject:selectedMechanicsType];
                [selectedColumns addObject:@"exerciseMechanicsType"];
            }
            //Initial for loops for the creation of the different statements we will bind together because from different tables.
            for (int i=0; i<selectedExerciseTypes.count; i++) {
                //Create the initial SELECT * FROM for the specific table.
                searchQuery = [[searchQuery stringByAppendingString:@" "] stringByAppendingString:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE",selectedExerciseTypes[i]]];
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
                            searchQuery = [[searchQuery stringByAppendingString:@" "]stringByAppendingString:[NSString stringWithFormat:@"%@ LIKE '%%%@%%'",selectedColumns[k],arrayForSelection[m]]];
                            if (m != arrayForSelection.count-1) {
                                searchQuery = [[searchQuery stringByAppendingString:@" "] stringByAppendingString:[NSString stringWithFormat:@"OR"]];
                            }
                        }
                    }
                //Now we have completed the SELECT statment from this table, add a UNION ALL for the next table.
                if (i != selectedExerciseTypes.count) {
                    if (![selectedName isEqualToString:@""]) {
                        if (selectedColumns.count > 0) {
                            searchQuery = [[searchQuery stringByAppendingString:@" "]stringByAppendingString:[NSString stringWithFormat:@"AND exerciseName LIKE '%%%@%%'",selectedName]];
                        }
                        else {
                            searchQuery = [[searchQuery stringByAppendingString:@" "]stringByAppendingString:[NSString stringWithFormat:@" exerciseName LIKE '%%%@%%'",selectedName]];
                        }
                    }
                    if (i != selectedExerciseTypes.count-1) {
                        searchQuery = [[searchQuery stringByAppendingString:@" "] stringByAppendingString:@"UNION ALL"];
                    }
                    else {
                        searchQuery = [[searchQuery stringByAppendingString:@" "]stringByAppendingString:@"ORDER BY exerciseName COLLATE NOCASE"];
                    }
                }
            }
                NSLog(@"*****************************************");
                NSLog(@"ADVANCED SEARCH QUERY: %@", searchQuery);
                NSLog(@"*****************************************");
        }
        //Perform the search and go to view exercises view controller.
        [self performSegueWithIdentifier:@"search" sender:nil];
    }
    else {
        //Put the core data search methods here.
        NSLog(@"CORE DATA SEARCH HERE");
    }
}


//Filling and storing data into arrays.
-(void) fillSelectedData {
    //Create references to the cells.
    //The cell responsible for the name search.
    TextFieldTableViewCell *exerciseNameCell = (TextFieldTableViewCell *)[self.exerciseSpecificationTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //The cell responsible for the primary muscle.
    UITableViewCell *primaryMuscleCell = [self.exerciseSpecificationTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    //The cell responsible for the secondary muscle.
    UITableViewCell *secondaryMuscleCell = [self.exerciseSpecificationTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
    //The cell responsible for the equipment.
    UITableViewCell *equipmentCell = [self.exerciseSpecificationTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1]];
    //The cell responsible for the difficulty.
    UITableViewCell *difficultyCell = [self.exerciseSpecificationTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:1]];
    //The cell responsible for the difficulty.
    UITableViewCell *forceTypeCell = [self.exerciseSpecificationTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:1]];
    //The cell responsible for the difficulty.
    UITableViewCell *mechanicTypeCell = [self.exerciseSpecificationTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:1]];
    //The cell responsible for the exercise type.
    UITableViewCell *exerciseTypeCell = [self.exerciseSpecificationTableView  cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:1]];
    
    //Initialize the selected types array
    selectedExerciseTypes = [[NSMutableArray alloc] init];
    
    //Empty the arrays.
    selectedDifficulty = nil;
    selectedPrimaryMuscles = nil;
    selectedSecondaryMuscles = nil;
    selectedEquipment =  nil;
    selectedForceType =  nil;
    selectedMechanicsType =  nil;
    
    //Put the data into the arrays, only if the user has selected 
    //Selected primary muscles array.
    if (![primaryMuscleCell.detailTextLabel.text isEqualToString:@"Any"]) {
    selectedPrimaryMuscles = [primaryMuscleCell.detailTextLabel.text componentsSeparatedByString:@", "];
    }
    //Selected secondary muscles array.
    if (![secondaryMuscleCell.detailTextLabel.text isEqualToString:@"Any"]) {
    selectedSecondaryMuscles = [secondaryMuscleCell.detailTextLabel.text componentsSeparatedByString:@", "];
    }
    //Selected equipment array.
    if (![equipmentCell.detailTextLabel.text isEqualToString:@"Any"]) {
    selectedEquipment = [equipmentCell.detailTextLabel.text componentsSeparatedByString:@", "];
    }
    //Selected difficulty array.
    if (![difficultyCell.detailTextLabel.text isEqualToString:@"Any"]) {
        selectedDifficulty = [difficultyCell.detailTextLabel.text componentsSeparatedByString:@", "];
    }
    //Selected force type array.
    if (![difficultyCell.detailTextLabel.text isEqualToString:@"Any"]) {
        selectedForceType = [forceTypeCell.detailTextLabel.text componentsSeparatedByString:@", "];
    }
    //Selected difficulty array.
    if (![difficultyCell.detailTextLabel.text isEqualToString:@"Any"]) {
        selectedMechanicsType = [mechanicTypeCell.detailTextLabel.text componentsSeparatedByString:@", "];
    }
    //Selected exercise types array.
    if ([exerciseTypeCell.detailTextLabel.text isEqualToString:@"Any"]) {
        NSArray *allTableNames = @[STRENGTH_DB_TABLENAME,STRETCHING_DB_TABLENAME,WARMUP_DB_TABLENAME];
        [selectedExerciseTypes addObjectsFromArray:allTableNames];
    }
    else {
        NSArray *convertExerciseTypesToTableNames;
        convertExerciseTypesToTableNames = [exerciseTypeCell.detailTextLabel.text componentsSeparatedByString:@", "];
        for (int i = 0; i < convertExerciseTypesToTableNames.count; i++) {
            if ([[convertExerciseTypesToTableNames objectAtIndex:i] isEqualToString:@"Strength"]) {
                [selectedExerciseTypes addObject:STRENGTH_DB_TABLENAME];
            }
            else if ([[convertExerciseTypesToTableNames objectAtIndex:i] isEqualToString:@"Stretching"]) {
                [selectedExerciseTypes addObject:STRETCHING_DB_TABLENAME];
            }
            else {
                [selectedExerciseTypes addObject:WARMUP_DB_TABLENAME];
            }
        }
    }
    //Get the text the user has or hasn't entered in the exercise name textfield.
    selectedName = exerciseNameCell.textField.text;
}

/*******************************/
#pragma mark - Prepare For Segue
/*******************************/

//Handles what happens when a user performs a segue.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ExerciseSelection"]) {
        //What happens when the user selects a cell in the table view, takes the user to selection page.
        //Get the index path for the selected cell the user pressed.
        NSIndexPath *indexPath = [self.exerciseSpecificationTableView indexPathForSelectedRow];
        //Create reference to the next view controller.
        advancedOptionsSelect *attributeSelectionPage = [[advancedOptionsSelect alloc]init];
        //Set the destination.
        attributeSelectionPage = segue.destinationViewController;
        //Set the properities for the next page.
        //Set the indexPath to the indexPath.
        attributeSelectionPage.indexPathPassed = indexPath;
        //Have to tell the next view that the delegate is this page.
        attributeSelectionPage.delegate =  self;
        //Initialize the selected cells array from this view.
        attributeSelectionPage.selectedCells = [[NSMutableArray alloc] init];
        //Get the cell that the user selected.
        UITableViewCell *cell = [self.exerciseSpecificationTableView cellForRowAtIndexPath:indexPath];
        //Do something only if the cell isn't the default.
        if (![cell.detailTextLabel.text isEqualToString:@"Any"]) {
            //Send what has been selected by the user, default is 'Any'
             attributeSelectionPage.selectedCells = [self convertDetailTextToArray:indexPath];
        }
        //Now pass specific things dependant on what cell the user pressed.
        if (indexPath.section == 1) {
            //First row is primary muscle selection.
            if (indexPath.row == 0) {
                attributeSelectionPage.arrayForTableView = primaryMuscles;
                attributeSelectionPage.titleText = @"Select Muscles";
                attributeSelectionPage.typeOfExerciseAttribute = primaryMuscle;
            }
            //Second row is seconday muscle selection.
            else if (indexPath.row == 1) {
                attributeSelectionPage.arrayForTableView = secondaryMuscles;
                attributeSelectionPage.titleText = @"Select Muscles";
                attributeSelectionPage.typeOfExerciseAttribute = secondaryMuscle;
            }
            //Third row is equipment selection.
            else if (indexPath.row == 2) {
                attributeSelectionPage.arrayForTableView = equipmentList;
                attributeSelectionPage.titleText = @"Select Equipment";
                attributeSelectionPage.typeOfExerciseAttribute = equipment;
            }
            //Fourth row is difficulty selection.
            else if (indexPath.row == 3) {
                attributeSelectionPage.arrayForTableView = difficultyList;
                attributeSelectionPage.titleText = @"Select Difficulties";
                attributeSelectionPage.typeOfExerciseAttribute = difficulty;
            }
            //Fourth row is forceType selection.
            else if (indexPath.row == 4) {
                attributeSelectionPage.arrayForTableView = forceTypeList;
                attributeSelectionPage.titleText = @"Select Force Types";
                attributeSelectionPage.typeOfExerciseAttribute = forceType;
            }
            //Fourth row is mechanic type selection.
            else if (indexPath.row == 5) {
                attributeSelectionPage.arrayForTableView = mechanicsTypeList;
                attributeSelectionPage.titleText = @"Select Mechanic Types";
                attributeSelectionPage.typeOfExerciseAttribute = mechanicType;
            }
            //Fith row is exercise type selection.
            else if (indexPath.row == 6) {
                NSArray *differentTypesOfExercises = @[@"Strength",@"Stretching",@"Warmup"];
                attributeSelectionPage.arrayForTableView = differentTypesOfExercises;
                attributeSelectionPage.titleText = @"Select Exercise Types";
                attributeSelectionPage.typeOfExerciseAttribute = exerciseType;
            }
        }
    }
    else if ([segue.identifier isEqualToString:@"search"]) {
        ExerciseListController *exerciseSearchViewController = [[ExerciseListController alloc] init];
        exerciseSearchViewController = segue.destinationViewController;
        exerciseSearchViewController.exerciseQuery = searchQuery;
        exerciseSearchViewController.viewTitle =  @"Custom Search";
        if (self.exerciseSelectionMode) {
            exerciseSearchViewController.exerciseSelectionMode = YES;
            exerciseSearchViewController.selectedExercises = self.selectedExercises;
        }
    }
}

/********************************************/
#pragma mark - Selection Page Delegate Method
/********************************************/

//What gets fired when the user presses the back button in the selection page.
- (void)userHasSelected:(NSMutableArray *)selectedValues indexPath:(NSIndexPath *)indexPath passedArrayCount:(NSInteger)passedArrayCount {
    //Only if the user selected something then update the table.
    if (selectedValues.count > 0 && selectedValues.count < passedArrayCount) {
        //Replace the defaults or the previous selections.
        [exerciseAdvancedSearchOptionsSelections replaceObjectAtIndex:indexPath.row withObject:[self convertSelectionsToString:selectedValues]];
        [tableViewAttributeSelectionsUserInterface replaceObjectAtIndex:indexPath.row withObject:[self convertSelectionsToStringWithSpace:selectedValues]];
    }
    else {
        //Set the object to 'Any' (default) if nothing was selected.
        [exerciseAdvancedSearchOptionsSelections replaceObjectAtIndex:indexPath.row withObject:@"Any"];
        [tableViewAttributeSelectionsUserInterface replaceObjectAtIndex:indexPath.row withObject:@"Any"];
    }
    //Update the user interface.
    [self.exerciseSpecificationTableView reloadData];
}

/*********************/
#pragma mark - Actions
/*********************/

//What happens when the user presses the search button at the bottom of the screen.
- (IBAction)searchButtonPressed:(id)sender {
    //Perform the search.
    [self search];
}

//Dismiss the view controller.
- (IBAction)dismissButtonPressed:(id)sender {
    if (self.exerciseSelectionMode) {
        [self.delegate advancedSelectedExercises:self.selectedExercises];
    }
    //Dismiss the modal popup with an animation.
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*****************************/
#pragma mark - Utility Methods
/*****************************/

- (void)fetchAndLoadInformation {
    
    //List of all the primary muscles.
    primaryMuscles = [CommonUtilities returnGeneralPlist][@"primaryMuscles"];
    //List of all the secondary muscles.
    secondaryMuscles = [CommonUtilities returnGeneralPlist][@"secondaryMuscles"];
    //List of all the types of equipment.
    equipmentList = [CommonUtilities returnGeneralPlist][@"equipmentList"];
    //List of all the types of difficulty.
    difficultyList = [CommonUtilities returnGeneralPlist][@"difficultyList"];
    forceTypeList = [CommonUtilities returnGeneralPlist][@"forceTypeList"];
    mechanicsTypeList = [CommonUtilities returnGeneralPlist][@"mechanicsTypeList"];
    
    //The values of the advanced search titles in the TableView.
    exerciseAdvancedSearchOptions = @[@"Primary Muscle",@"Secondary Muscle",@"Equipment",@"Difficulty",@"Force Type",@"Mechanics Type",@"Exercise Type"];
    //The defaults in the advanced search view.
    exerciseAdvancedSearchOptionsSelections = [[NSMutableArray alloc] initWithObjects:@"Any",@"Any",@"Any",@"Any",@"Any",@"Any",@"Any", nil];
    tableViewAttributeSelectionsUserInterface = [[NSMutableArray alloc] initWithObjects:@"Any",@"Any",@"Any",@"Any",@"Any",@"Any",@"Any", nil];
    
    //The header text for the TableView section headers.
    tableViewSectionHeaders = @[@"Exercise Attributes",@"Search Exercise Name"];
}

//Converts what is presented as the detailText label into an array to pass to the selection view so that the selections can be checkmarked.
- (NSMutableArray*)convertDetailTextToArray:(NSIndexPath*)indexPath {
    //Create the array/
    NSArray *detailTextArray;
    //Make reference to the TableView cell.
    UITableViewCell *cell = [self.exerciseSpecificationTableView cellForRowAtIndexPath:indexPath];
    //Only if the cell has something selected and is not the default.
    if (![cell.detailTextLabel.text isEqualToString:@"Any"]) {
        //Get the information into array format.
        detailTextArray = [[exerciseAdvancedSearchOptionsSelections objectAtIndex:indexPath.row] componentsSeparatedByString:@","];
    }
    //Return the mutable copy.
    return [detailTextArray mutableCopy];
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

- (void)selectedExercises:(NSMutableArray*)selectedExercises {
    self.selectedExercises = selectedExercises;
}

@end
