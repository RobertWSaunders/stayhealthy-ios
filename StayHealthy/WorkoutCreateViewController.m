//
//  WorkoutCreateViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-25.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import "WorkoutCreateViewController.h"

@interface WorkoutCreateViewController ()

@end

@implementation WorkoutCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fetchAndLoadInformation];
    
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

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
    if (section == 2) {
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
    if (section == 2) {
        //For section 1.
        return @"Workout Attributes";
    }
    else if (section == 1) {
        return @"Exercises";
    }
    else {
        //For section 0.
        return @"Workout Name";
    }
}

//Configures the cells at a specific indexPath.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //The first section is just attributes that push to the attribute selection page.
    if (indexPath.section == 2) {
        
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
    else  {
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


//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

//What happens when the user selects a cell in the tableView.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//-------------------------------------
#pragma mark TableView Editing Handling
//-------------------------------------

//Specifies the editing style for the editing enabled tableViewCells.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return UITableViewCellEditingStyleInsert;
    }
    else {
        return UITableViewCellEditingStyleNone;
    }
}

//Specidies the indexPaths for the tableViewCells that can be edited.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 1) {
        return YES;
    }
    else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    workoutAdvancedSearchOptionsSelections = [[NSMutableArray alloc] initWithObjects:@"None",@"None",@"None",@"None",@"None", nil];
    tableViewAttributeSelectionsUserInterface = [[NSMutableArray alloc] initWithObjects:@"None",@"None",@"None",@"None",@"None", nil];
    
    //The header text for the TableView section headers.
    tableViewSectionHeaders = @[@"Workout Attributes",@"Search Workout Name", @"Exercises"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(id)sender {
    
}

@end
