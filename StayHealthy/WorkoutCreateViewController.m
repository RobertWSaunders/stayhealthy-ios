//
//  WorkoutCreateViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-25.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import "WorkoutCreateViewController.h"

@interface WorkoutCreateViewController ()

@end

@implementation WorkoutCreateViewController

/**********************************/
#pragma mark - View Loading Methods
/**********************************/

//What happens right before the view loads.
- (void)viewDidLoad {
    [super viewDidLoad];

    //Load the view dependant on what the user is doing.
    if (self.editMode) {
        //When a user is editing a workout.
        [self loadForEditMode];
    }
    else {
        //When a user is creating a workout.
        [self loadForCreateMode];
    }
    
    [CommonSetUpOperations setFirstViewTSMessage:USER_FIRST_VIEW_CREATE_WORKOUTS  viewController:self message:@"Wanna make your own workout? You can do that here! Simply make a name, select some exercises, select the workout attributes, and write a summary and away you go!"];
    
    //Set the tableView in edit mode for adding and deleting people.
    [self.createWorkoutTableView setEditing:YES animated:YES];
    //Make sure the user can select the cells even when in edit mode.
    self.createWorkoutTableView.allowsSelectionDuringEditing = YES;
    
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

//Loads the view for editing a workout.
- (void)loadForEditMode {
    textViewText = self.workoutToEdit.workoutSummary;
    selectedName = self.workoutToEdit.workoutName;
    self.title = @"Edit Workout";
    [self fetchAndLoadInformationForEditMode];
}

//Loads the view for creating a workout.
- (void)loadForCreateMode {
    textViewText = @"Summary";
    self.title = @"Create Workout";
    
    [self fetchAndLoadInformation];
}

/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the height of the TableView.
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Set the height of the workout summary cell.
    if (indexPath.section == 3 && indexPath.row == 0) {
        return 100;
    }
    //Set the height of the workout exercise cell.
    else if (indexPath.section == 1 && ((!self.editMode && workoutExercises.count > 0 && indexPath.row <= workoutExercises.count-1) || (self.editMode && self.workoutToEditExercises.count > 0 && indexPath.row <= self.workoutToEditExercises.count-1))) {
        return 76;
    }
    //For all other cells.
    else {
        return 50;
    }
}

//Returns the number of sections of a TableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.editMode) {
        return 5;
    }
    else {
        //Return the number of section headers.
        return 4;
    }
}

//Returns the number of rows in the section of a TableView.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        if (self.editMode) {
            return [self.workoutToEditExercises count]+1;
        }
        else {
            return [workoutExercises count]+1;
        }
    }
    else if (section == 2) {
        return [workoutOptions count];
    }
    else {
        return 1;
    }
}

//Configures the cells at a specific indexPath.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *workoutNameCell = @"workoutNameCell";
    static NSString *workoutSummaryCell = @"workoutSummaryCell";
    static NSString *workoutExerciseCell = @"workoutExerciseCell";
    static NSString *workoutAttributeCell = @"workoutAttributeCell";
    static NSString *workoutDeleteCell = @"workoutDeleteCell";

    //The first section of the tableView. i.e Workout Name and Workout Summary.
    if (indexPath.section == 0) {
            //Create reference to the UITableViewCell.
            TextFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:workoutNameCell];
            
            //If the cell is nil create a new one.
            if (cell == nil) {
                cell = [[TextFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:workoutNameCell];
            }
        
        //Set the cell label.
        cell.cellLabel.text = @"Workout Name";
        


            cell.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Workout Name" attributes:@{NSForegroundColorAttributeName:LIGHT_GRAY_COLOR}];
        
        cell.textField.text = selectedName;
            //Set the textfiled delegate to self.
            cell.textField.delegate = self;
            //Make the cell not selectable by the user. Or appear that way.
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            //Stlying the cells.
            cell.cellLabel.font = tableViewTitleTextFont;
            cell.cellLabel.textColor = BLUE_COLOR;
            cell.textField.font = tableViewDetailTextFont;
            cell.textField.textColor = LIGHT_GRAY_COLOR;
            
            //Return the cell.
            return cell;
    }
    //For the second section, i.e. Workout Exercises.
    else if (indexPath.section == 1) {
        //Check if we need to show the workout exercise cell.
        if ((!self.editMode && workoutExercises.count > 0 && indexPath.row <= workoutExercises.count-1) || (self.editMode && self.workoutToEditExercises.count > 0 && indexPath.row <= self.workoutToEditExercises.count-1)) {
            
            //Create reference to the UITableViewCell.
            ExerciseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:workoutExerciseCell];
            
            //If the cell is nil create a new one.
            if (cell == nil) {
                cell = [[ExerciseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:workoutExerciseCell];
            }
            
            SHExercise *exercise;
            
            if (self.editMode) {
                exercise = [self updateExerciseWithUserData:[self.workoutToEditExercises objectAtIndex:indexPath.row]];
            }
            else {
                exercise = [self updateExerciseWithUserData:[workoutExercises objectAtIndex:indexPath.row]];
            }
            
    
            cell.exerciseName.text = exercise.exerciseName;
            cell.difficulty.text = exercise.exerciseDifficulty;
            cell.difficulty.textColor = [CommonSetUpOperations determineDifficultyColor:exercise.exerciseDifficulty];
            
            cell.equipment.text = exercise.exerciseEquipment;
            NSString *trimmedString = [exercise.exerciseEquipment stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceCharacterSet]];
            
            if ([trimmedString isEqualToString:@"null"])
                cell.equipment.text = @"No Equipment";
            else
                cell.equipment.text = exercise.exerciseEquipment;
            
            //Load the exercise image on the background thread.
            [CommonSetUpOperations loadImageOnBackgroundThread:cell.exerciseImage image:[UIImage imageNamed:exercise.exerciseImageFile]];
            
            if ([exercise.liked isEqualToNumber:[NSNumber numberWithBool:YES]]) {
                cell.likeExerciseImage.hidden = NO;
                [cell.likeExerciseImage setImage:[UIImage imageNamed:@"likeSelectedColored.png"]];
                cell.likeExerciseImage.tintColor = BLUE_COLOR;
            }
            else {
                cell.likeExerciseImage.hidden = YES;
            }
            
            cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            [CommonSetUpOperations tableViewSelectionColorSet:cell];
            
             return cell;

        }
        //We show the cell that says add exercise.
        else {
            //Create reference to the UITableViewCell.
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:workoutAttributeCell];
            
            //If the cell is nil create a new one.
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:workoutAttributeCell];
            }

            cell.textLabel.font = tableViewTitleTextFont;
            cell.textLabel.textColor = BLUE_COLOR;
            cell.textLabel.text = @"Add Exercises";
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.detailTextLabel.hidden = YES;
            
            [CommonSetUpOperations tableViewSelectionColorSet:cell];
            
            return cell;
        }
    }
    //The final section which is just the workouts attributes.
    else if (indexPath.section == 2){
        
        //Create reference to the UITableViewCell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:workoutAttributeCell];
        
        //If the cell is nil create a new one.
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:workoutAttributeCell];
        }
        
        //Set the cell text label.
        cell.textLabel.text = [workoutOptions objectAtIndex:indexPath.row];
        //Set the detail text.
        cell.detailTextLabel.text = [tableViewAttributeSelectionsUserInterface objectAtIndex:indexPath.row];
            cell.detailTextLabel.textColor = [CommonSetUpOperations determineDifficultyColor:cell.detailTextLabel.text];
        
        //Stlying the cells.
        cell.textLabel.font = tableViewTitleTextFont;
        cell.detailTextLabel.font = tableViewDetailTextFont;
        cell.textLabel.textColor = BLUE_COLOR;
        //cell.detailTextLabel.textColor = LIGHT_GRAY_COLOR;
        
        //Set the selection cell.
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
        
        //Return the cell.
        return cell;
    }
    else if (indexPath.section == 3) {
            //Create reference to the UITableViewCell.
            TextViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:workoutSummaryCell];
            
            //If the cell is nil create a new one.
            if (cell == nil) {
                cell = [[TextViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:workoutSummaryCell];
            }
            
            //Set the reference to the workoutSummaryTextView, used for collecting information and delegate.
            workoutSummaryTextView = cell.textView;
        
        
            //Set the delegate of the textView to self.
            cell.textView.delegate = self;
        
            cell.textView.textColor = [UIColor lightGrayColor];
        
        
            if (!self.editMode) {
                cell.textView.text = textViewText;
            }//If it is in edit mode we need to show the workout that is being editing summary.
            else {
                cell.textView.text = self.workoutToEdit.workoutSummary;
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:workoutDeleteCell];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:workoutDeleteCell];
        }
        
        if (indexPath.row == 0) {
            cell.textLabel.text = @"Delete";
            cell.textLabel.textColor = RED_COLOR;
            cell.textLabel.font = tableViewTitleTextFont;
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
        }
        
        return cell;
    }
}

//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

//What happens when the user selects a cell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //If the user selects a workout attribute cell.
    if (indexPath.section == 2) {
        [self performSegueWithIdentifier:@"selectOptions" sender:nil];
    }
    else if (indexPath.section == 1) {
        if ((!self.editMode && workoutExercises.count > 0 && indexPath.row <= workoutExercises.count-1) || (self.editMode && self.workoutToEditExercises.count > 0 && indexPath.row <= self.workoutToEditExercises.count-1)) {
            [self performSegueWithIdentifier:@"exerciseDetail" sender:nil];
           
        }
        else {
             [self performSegueWithIdentifier:@"selectExercises" sender:nil];
        }
    }
    else if (indexPath.section == 4) {
        
        //No stretching for bicep, chest, forearms, oblique.
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"title" andMessage:nil];
        [alertView addButtonWithTitle:@"Yes"
                                 type:SIAlertViewButtonTypeCancel
                              handler:^(SIAlertView *alertView) {
                                  SHDataHandler *dataHandler = [SHDataHandler getInstance];
                                  [dataHandler deleteCustomWorkoutRecord:self.workoutToEdit];
                                  [self dismissViewControllerAnimated:YES completion:^{
                                      [self.navigationController popToRootViewControllerAnimated:YES];
                                  }];
                                  
                              }];
        [alertView addButtonWithTitle:@"Cancel"
                                 type:SIAlertViewButtonTypeCancel
                              handler:nil];
        alertView.title = @"Are you sure?";
        [alertView show];
    /*
        LGAlertView *alertView = [[LGAlertView alloc] initWithTitle:@"Delete Workout"
                                                            message:@"Are you sure you would like to delete this workout?"
                                                              style:LGAlertViewStyleActionSheet
                                                       buttonTitles:@[@"Delete"]
                                                  cancelButtonTitle:@"Cancel"
                                             destructiveButtonTitle:nil
                                                      actionHandler:^(LGAlertView *alertView, NSString *title, NSUInteger index) {
                                                          SHDataHandler *dataHandler = [SHDataHandler getInstance];
                                                            [dataHandler deleteCustomWorkoutRecord:self.workoutToEdit];
                                                            [self.navigationController popToRootViewControllerAnimated:YES];
                                                      }
                                                      cancelHandler:nil
                                                 destructiveHandler:nil];
        alertView.titleFont = [UIFont fontWithName:regularFontName size:18.0f];
        alertView.titleTextColor = LIGHT_GRAY_COLOR;
        alertView.messageFont = [UIFont fontWithName:regularFontName size:16.0f];
        alertView.messageTextColor = DARK_GRAY_COLOR;
        alertView.buttonsFont = [UIFont fontWithName:regularFontName size:18.0f];
        alertView.buttonsTitleColor = RED_COLOR;
        alertView.buttonsBackgroundColorHighlighted = RED_COLOR;
        alertView.cancelButtonFont = [UIFont fontWithName:regularFontName size:18.0f];
        alertView.cancelButtonTitleColor = BLUE_COLOR;
        alertView.cancelButtonBackgroundColorHighlighted = BLUE_COLOR;
     
        [alertView showAnimated:YES completionHandler:nil];
     */
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//-----------------------------------------------
#pragma mark Cell Header and Footer Configuration
//-----------------------------------------------

//Returns the title for the section headers.
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //Return the titles for the sections.
    if (section == 2) {
        //For section 1.
        return @"Workout Attributes";
    }
    else if (section == 1) {
        return @"Exercises";
    }
    else if (section == 3) {
        return @"Workout Summary";
    }
    else {
        //For section 0.
        return @"";
    }
}

//Returns the height of the section headers.
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 30;
    }
    else {
        return 40;
    }
}

//Returns the height of the footers.
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    if ((!self.editMode && section == 3) || (self.editMode && section == 4)) {
        return 35;
    }
    else {
        return 2;
    }
}

//-------------------------------------
#pragma mark TableView Editing Handling
//-------------------------------------

//Specifies the editing style for the editing enabled tableViewCells.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if ((!self.editMode && workoutExercises.count > 0 && indexPath.row <= workoutExercises.count-1) || (self.editMode && self.workoutToEditExercises.count > 0 && indexPath.row <= self.workoutToEditExercises.count-1)) {
            return UITableViewCellEditingStyleDelete;
        }
        else {
            return UITableViewCellEditingStyleInsert;
        }
    }
    return UITableViewCellEditingStyleNone;
}

//Specifies the indexPaths for the tableViewCells that can be edited.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   if (indexPath.section == 1) {
        return YES;
    }
    else {
        return NO;
    }
}

//What happens when a user deletes a exercise.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.createWorkoutTableView beginUpdates];
        
        if (self.editMode) {
            [self.workoutToEditExercises removeObjectAtIndex:indexPath.row];
        }
        else {
            [workoutExercises removeObjectAtIndex:indexPath.row];
        }
        
        [self.createWorkoutTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.createWorkoutTableView endUpdates];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if ((indexPath.section == 1) && ((!self.editMode && workoutExercises.count > 0 && indexPath.row <= workoutExercises.count-1) || (self.editMode && self.workoutToEditExercises.count > 0 && indexPath.row <= self.workoutToEditExercises.count-1))) {
        return YES;
    }
    else {
        return NO;
    }
    
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath != destinationIndexPath) {
        
        SHExercise *exercise;
        
        if (self.editMode) {
            exercise = [self updateExerciseWithUserData:[self.workoutToEditExercises objectAtIndex:sourceIndexPath.row]];
            [self.workoutToEditExercises removeObjectAtIndex:sourceIndexPath.row];
            [self.workoutToEditExercises insertObject:exercise atIndex:destinationIndexPath.row];
        }
        else {
            exercise = [self updateExerciseWithUserData:[workoutExercises objectAtIndex:sourceIndexPath.row]];
            [workoutExercises removeObjectAtIndex:sourceIndexPath.row];
            [workoutExercises insertObject:exercise atIndex:destinationIndexPath.row];
        }
        
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (sourceIndexPath.section != proposedDestinationIndexPath.section) {
         NSInteger row = 0;
        if (sourceIndexPath.section < proposedDestinationIndexPath.section) {
            row = [tableView numberOfRowsInSection:sourceIndexPath.section] - 2;
        }
        return [NSIndexPath indexPathForRow:row inSection:sourceIndexPath.section];
    }
    
    if (proposedDestinationIndexPath.row == [tableView numberOfRowsInSection:sourceIndexPath.section] - 1) {
         NSInteger row = 0;
        row = [tableView numberOfRowsInSection:sourceIndexPath.section] - 2;
        return [NSIndexPath indexPathForRow:row inSection:sourceIndexPath.section];
    }
    
    return proposedDestinationIndexPath;
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

- (void)textFieldDidEndEditing:(UITextField *)textField {
    selectedName = textField.text;
}



- (void)fetchAndLoadInformation {
    //List of all the primary muscles.
    targetMuscles = [CommonUtilities returnGeneralPlist][@"primaryMuscles"];
    //List of all the types of equipment.
    equipmentList = [CommonUtilities returnGeneralPlist][@"equipmentList"];
    //List of all the types of difficulty.
    difficultyList = [CommonUtilities returnGeneralPlist][@"difficultyList"];
    sportsList = [CommonUtilities returnGeneralPlist][@"sports2"];
    
    //The values of the advanced search titles in the TableView.
    workoutOptions = @[@"Target Muscles",@"Target Sports",@"Equipment",@"Difficulty",@"Workout Type"];
    
    //The defaults in the advanced search view.
    workoutAdvancedSearchOptionsSelections = [[NSMutableArray alloc] initWithObjects:@"None",@"None",@"None",@"None",@"None", nil];
    tableViewAttributeSelectionsUserInterface = [[NSMutableArray alloc] initWithObjects:@"None",@"None",@"None",@"None",@"None", nil];
    
}

-(void)fetchAndLoadInformationForEditMode {
    
    //List of all the primary muscles.
    targetMuscles = [CommonUtilities returnGeneralPlist][@"primaryMuscles"];
    //List of all the types of equipment.
    equipmentList = [CommonUtilities returnGeneralPlist][@"equipmentList"];
    //List of all the types of difficulty.
    difficultyList = [CommonUtilities returnGeneralPlist][@"difficultyList"];
    sportsList = [CommonUtilities returnGeneralPlist][@"sports2"];
    
    //The values of the advanced search titles in the TableView.
    workoutOptions = @[@"Target Muscles",@"Target Sports",@"Equipment",@"Difficulty",@"Workout Type"];
    
    
    //The defaults in the advanced search view.
    workoutAdvancedSearchOptionsSelections = [[NSMutableArray alloc] initWithObjects:self.workoutToEdit.workoutTargetMuscles,self.workoutToEdit.workoutTargetSports,self.workoutToEdit.workoutEquipment,self.workoutToEdit.workoutDifficulty,self.workoutToEdit.workoutType, nil];
    tableViewAttributeSelectionsUserInterface = [[NSMutableArray alloc] initWithObjects:self.workoutToEdit.workoutTargetMuscles,self.workoutToEdit.workoutTargetSports,self.workoutToEdit.workoutEquipment,self.workoutToEdit.workoutDifficulty,self.workoutToEdit.workoutType, nil];
}

/*****************************************/
#pragma mark - UITextView Delegate Methods
/*****************************************/

//Asks the delegate if the edition should begin in the specified textView.
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
   // TextViewTableViewCell *cell = (TextViewTableViewCell*)[self.createWorkoutTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
   
    /*if (!self.editMode) {
        cell.textView.text = @"";
        cell.textView.textColor = [UIColor lightGrayColor];
    }
    */
    [self.createWorkoutTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    self.createWorkoutTableView.frame= CGRectMake(self.createWorkoutTableView.frame.origin.x, self.createWorkoutTableView.frame.origin.y - 300, self.createWorkoutTableView.frame.size.width, self.createWorkoutTableView.frame.size.height);
    [UIView commitAnimations];
    self.createWorkoutTableView.scrollEnabled = NO;
    //NSIndexPath *indexPath =[NSIndexPath indexPathForRow:nIndex inSection:nSectionIndex];
    //[self.createWorkoutTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {

   // TextViewTableViewCell *cell = (TextViewTableViewCell*)[self.createWorkoutTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    
   /* if(cell.textView.text.length == 0){
        cell.textView.textColor = [UIColor lightGrayColor];
        cell.textView.text = @"Summary";
        [cell.textView resignFirstResponder];
    }*/
    
    textViewText = textView.text;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.createWorkoutTableView.frame= CGRectMake(self.createWorkoutTableView.frame.origin.x, self.createWorkoutTableView.frame.origin.y + 300, self.createWorkoutTableView.frame.size.width, self.createWorkoutTableView.frame.size.height);
    
    [UIView commitAnimations];

    self.createWorkoutTableView.scrollEnabled = YES;
    return YES;
}

//Tells the delegate the the text has been changed in the specified textView.
-(void)textViewDidChange:(UITextView *)textView {
   // TextViewTableViewCell *cell = (TextViewTableViewCell*)[self.createWorkoutTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    
    /*if(cell.textView.text.length == 0){
        cell.textView.textColor = [UIColor lightGrayColor];
        cell.textView.text = @"Summary";
        [textView resignFirstResponder];
    }
     */
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


/*************************************************/
#pragma mark - Exercise Selection Delegate Methods
/*************************************************/

//What happens when a user selects a exercise.
- (void)selectedExercises:(NSMutableArray*)selectedExercises {
    if (selectedExercises.count > 0) {
        if (self.editMode) {
            self.workoutToEditExercises = selectedExercises;
        }
        else {
            workoutExercises = [[NSMutableArray alloc] init];
            workoutExercises = selectedExercises;
        }
        
        [self.createWorkoutTableView reloadData];
    }
}

/**********************************************/
#pragma mark - AdvancedOptions Delegate Methods
/**********************************************/

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
        [workoutAdvancedSearchOptionsSelections replaceObjectAtIndex:indexPath.row withObject:@"None"];
        [tableViewAttributeSelectionsUserInterface replaceObjectAtIndex:indexPath.row withObject:@"None"];
    }
    //Update the user interface.
    [self.createWorkoutTableView reloadData];
}

/********************************/
#pragma mark - Prepare For Segue
/********************************/

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"selectOptions"]) {
        //What happens when the user selects a cell in the table view, takes the user to selection page.
        //Get the index path for the selected cell the user pressed.
        NSIndexPath *indexPath = [self.createWorkoutTableView indexPathForSelectedRow];
        //Create reference to the next view controller.
        advancedOptionsSelect *attributeSelectionPage = [[advancedOptionsSelect alloc]init];
        //Set the destination.
        attributeSelectionPage = segue.destinationViewController;
        //Set the properities for the next page.
        //Set the indexPath to the indexPath.
        attributeSelectionPage.indexPathPassed = indexPath;
        //Have to tell the next view that the delegate is this page.
        attributeSelectionPage.delegate = self;
        attributeSelectionPage.singleSelectionMode = NO;
        attributeSelectionPage.viewMode = NO;
        //Initialize the selected cells array from this view.
        attributeSelectionPage.selectedCells = [[NSMutableArray alloc] init];
        //Get the cell that the user selected.
        UITableViewCell *cell = [self.createWorkoutTableView cellForRowAtIndexPath:indexPath];
        //Do something only if the cell isn't the default.
        if (![cell.detailTextLabel.text isEqualToString:@"None"]) {
            //Send what has been selected by the user, default is 'Any'
            attributeSelectionPage.selectedCells = [self convertDetailTextToArray:indexPath];
        }
        //Now pass specific things dependant on what cell the user pressed.
        if (indexPath.section == 2) {
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
                attributeSelectionPage.titleText = @"Select Difficulty";
                 attributeSelectionPage.singleSelectionMode = YES;
        }
        //Fith row is exercise type selection.
        else if (indexPath.row == 4) {
            NSArray *differentTypesOfWorkouts = @[@"Warm-Up",@"Build Muscle",@"Injury Prevention",@"Core",@"Home Workout",@"General",@"Cardio",@"Stretch"];
            attributeSelectionPage.arrayForTableView = differentTypesOfWorkouts;
            attributeSelectionPage.titleText = @"Select Workout Type";
            attributeSelectionPage.singleSelectionMode = YES;
        }
    }
    }
    else if ([segue.identifier isEqualToString:@"selectExercises"]) {
        UINavigationController *navController  = [[UINavigationController alloc] init];
        navController = segue.destinationViewController;
        ExerciseSelectionViewController *exerciseSelectionView = [[ExerciseSelectionViewController alloc] init];
        exerciseSelectionView = navController.viewControllers[0];
        exerciseSelectionView.exerciseSelectionMode = YES;
        exerciseSelectionView.delegate = self;
        if (self.editMode) {
            exerciseSelectionView.selectedExercises = self.workoutToEditExercises;
        }
        else {
            exerciseSelectionView.selectedExercises = workoutExercises;
        }
        
    }
    else if ([segue.identifier isEqualToString:@"exerciseDetail"]) {
        NSIndexPath *indexPath = [self.createWorkoutTableView indexPathForSelectedRow];
        SHExercise *exercise;
        if (self.editMode) {
            exercise = [self.workoutToEditExercises objectAtIndex:indexPath.row];
        }
        else {
            exercise = [workoutExercises objectAtIndex:indexPath.row];
        }
        ExerciseDetailViewController *detailView = [[ExerciseDetailViewController alloc] init];
        detailView = segue.destinationViewController;
        detailView.exerciseToDisplay = exercise;
        detailView.viewTitle = exercise.exerciseName;
        detailView.modalView = NO;
        detailView.showActionIcon = NO;
    }
}


/********************************/
#pragma mark - Utility Methods
/********************************/

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
    UITableViewCell *cell = [self.createWorkoutTableView cellForRowAtIndexPath:indexPath];
    //Only if the cell has something selected and is not the default.
    if (![cell.detailTextLabel.text isEqualToString:@"None"]) {
        //Get the information into array format.
            detailTextArray = [[workoutAdvancedSearchOptionsSelections objectAtIndex:indexPath.row] componentsSeparatedByString:@","];
        
    }
    //Return the mutable copy.
    return [detailTextArray mutableCopy];
}

- (SHExercise *)updateExerciseWithUserData:(SHExercise*)exercise {
    SHDataHandler *dataHandler = [SHDataHandler getInstance];
    
    Exercise *dataExercise = [dataHandler fetchExerciseByIdentifier:exercise.exerciseIdentifier];
    
    if (dataExercise != nil) {
        exercise.lastViewed = dataExercise.lastViewed;
        exercise.liked = dataExercise.liked;
    }
    
    return exercise;
}

- (void)saveWorkout {
        if (self.editMode) {
            if ([self userCanSave:YES]) {
            SHDataHandler *handler = [[SHDataHandler alloc] init];
            [handler updateCustomWorkoutRecord:[self updateCustomWorkout:self.workoutToEdit]];
            [self dismissViewControllerAnimated:YES completion:nil];
            }
        }
        else {
            if ([self userCanSave:NO]) {
                SHDataHandler *handler = [[SHDataHandler alloc] init];
                [handler saveCustomWorkoutRecord:[self createCustomWorkout]];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
    }
   
}

- (SHCustomWorkout* )createCustomWorkout {
    
    //Build Custom Workout
    //Create reference to a new custom workout.
    SHCustomWorkout *customWorkout = [[SHCustomWorkout alloc] init];
    //Set a new workout idenitifier.
    customWorkout.workoutID = [CommonUtilities returnUniqueID];
    //Set the name of the new workout.
    customWorkout.workoutName = selectedName;
    //Set the summary of the new workout.
    if ([textViewText isEqualToString:@"Summary"]) {
        customWorkout.workoutSummary = nil;
    }
    else {
        customWorkout.workoutSummary = textViewText;
    }
    //Set the workout exercise identifiers.
    customWorkout.workoutExerciseIDs = [self returnWorkoutExerciseIdentifiers:workoutExercises];
    //Set the workout exercise types.
    customWorkout.exerciseTypes = [self returnWorkoutExerciseTypes:workoutExercises];
    customWorkout.workoutType = [workoutAdvancedSearchOptionsSelections objectAtIndex:4];
    customWorkout.workoutEquipment = [workoutAdvancedSearchOptionsSelections objectAtIndex:2];
    customWorkout.workoutDifficulty = [workoutAdvancedSearchOptionsSelections objectAtIndex:3];
    customWorkout.workoutTargetMuscles = [workoutAdvancedSearchOptionsSelections objectAtIndex:0];
    customWorkout.workoutTargetSports = [workoutAdvancedSearchOptionsSelections objectAtIndex:1];
    customWorkout.dateCreated = [NSDate date];
    customWorkout.dateModified = [NSDate date];
    
    return customWorkout;
}

- (SHCustomWorkout* )updateCustomWorkout:(SHCustomWorkout*)updateWorkout {

    
    //Set the name of the new workout.
    updateWorkout.workoutName = selectedName;
    //Set the summary of the new workout.
    if ([textViewText isEqualToString:@"Summary"]) {
        updateWorkout.workoutSummary = nil;
    }
    else {
         updateWorkout.workoutSummary = textViewText;
    }
    //Set the workout exercise identifiers.
    updateWorkout.workoutExerciseIDs = [self returnWorkoutExerciseIdentifiers:self.workoutToEditExercises];
    //Set the workout exercise types.
    updateWorkout.exerciseTypes = [self returnWorkoutExerciseTypes:self.workoutToEditExercises];
    updateWorkout.workoutType = [workoutAdvancedSearchOptionsSelections objectAtIndex:4];
    updateWorkout.workoutEquipment = [workoutAdvancedSearchOptionsSelections objectAtIndex:2];
    updateWorkout.workoutDifficulty = [workoutAdvancedSearchOptionsSelections objectAtIndex:3];
    updateWorkout.workoutTargetMuscles = [workoutAdvancedSearchOptionsSelections objectAtIndex:0];
    updateWorkout.workoutTargetSports = [workoutAdvancedSearchOptionsSelections objectAtIndex:1];
    updateWorkout.dateModified = [NSDate date];

    return updateWorkout;
}

- (NSString*)returnWorkoutExerciseIdentifiers:(NSMutableArray*)passedWorkoutExercises {
    NSMutableArray *exerciseIdentifiers = [[NSMutableArray alloc] init];
    for (SHExercise *exercise in passedWorkoutExercises) {
        [exerciseIdentifiers addObject:exercise.exerciseIdentifier];
    }
    return [exerciseIdentifiers componentsJoinedByString:@","];
}

- (NSString*)returnWorkoutExerciseTypes:(NSMutableArray*)passedWorkoutExercises {
    NSMutableArray *exerciseTypes = [[NSMutableArray alloc] init];
    for (SHExercise *exercise in passedWorkoutExercises) {
        [exerciseTypes addObject:exercise.exerciseType];
    }
     return [exerciseTypes componentsJoinedByString:@","];
}

- (BOOL)userCanSave:(BOOL)update {
    
    //Workout Name Cell
       
    if ([selectedName isEqualToString:@""] || (selectedName == nil)) {
        [CommonSetUpOperations performTSMessage:@"Workout Name Required" message:nil viewController:self canBeDismissedByUser:YES duration:6];
        return NO;
    }
    
    if (update) {
        if (self.workoutToEditExercises.count < 1) {
            [CommonSetUpOperations performTSMessage:@"At least two exercises are required." message:nil viewController:self canBeDismissedByUser:YES duration:6];
            return NO;
        }
    }
    else {
        if (workoutExercises.count < 1) {
             [CommonSetUpOperations performTSMessage:@"At least two exercises are required." message:nil viewController:self canBeDismissedByUser:YES duration:6];
            return NO;
        }
    }
    
    if ([[workoutAdvancedSearchOptionsSelections objectAtIndex:3] isEqualToString:@"None"]) {
        [CommonSetUpOperations performTSMessage:@"Workout Difficulty Required" message:nil viewController:self canBeDismissedByUser:YES duration:6];
        return NO;
    }
    else if ([[workoutAdvancedSearchOptionsSelections objectAtIndex:4] isEqualToString:@"None"]) {
        [CommonSetUpOperations performTSMessage:@"Workout Type Required" message:nil viewController:self canBeDismissedByUser:YES duration:6];
        return NO;
    }
    /*
    else if ([workoutSummaryCell.textView.text isEqualToString:@"Summary"]) {
        [CommonSetUpOperations performTSMessage:@"Summary" message:nil viewController:self canBeDismissedByUser:YES duration:6];
        return NO;
    }
     */
    
    return YES;
}
/*****************************/
#pragma mark - Action Methods
/*****************************/

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(id)sender {
     TextFieldTableViewCell *cell = (TextFieldTableViewCell*)[self.createWorkoutTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    [cell.textField resignFirstResponder];
    [self saveWorkout];
}



@end
