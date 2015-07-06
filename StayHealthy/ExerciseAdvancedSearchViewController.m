//
//  ExerciseAdvancedSearchViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-07-05.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import "ExerciseAdvancedSearchViewController.h"

@implementation ExerciseAdvancedSearchViewController

- (void)viewDidLoad {
    //Advanced search
    //List of all the primary muscles.
    primaryMuscles = [CommonRequests returnGeneralPlist][@"primaryMuscles"];
    //List of all the secondary muscles.
    secondaryMuscles = [CommonRequests returnGeneralPlist][@"secondaryMuscles"];
    //List of all the types of equipment.
    equipmentList = [CommonRequests returnGeneralPlist][@"equipmentList"];
    //List of all the types of difficulty.
    difficultyList = [CommonRequests returnGeneralPlist][@"difficultyList"];
    
    //Fill an array with the arrays for the advanced search, used in the for loop.
    NSArray *advancedSearchArrays = @[primaryMuscles, secondaryMuscles, equipmentList, difficultyList];
    //Add 'Any' to the first index of each array. Have to do it here because we want to maintain stability and reliance of the plist.
    for (int i = 0; i < advancedSearchArrays.count; i++) {
        NSMutableArray *array;
        array = advancedSearchArrays[i];
        array = [[NSMutableArray alloc] init];
        [array insertObject:@"Any" atIndex:0];
    }
    
    //The values of the advanced search titles in the tableview.
    exerciseAdvancedSearchOptions = @[@"Primary Muscle",@"Secondary Muscle",@"Equipment",@"Difficulty",@"Exercise Type"];
    //The defaults in the advanced search view.
    exerciseAdvancedSearchOptionsDefaults = @[@"Any",@"Any", @"Any", @"Any", @"Strength"];
    
    /*
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
     */
    
    /*
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
     
     NSIndexPath *indexPath = [advancedSearchTableView indexPathForSelectedRow];
     UINavigationController *nav = segue.destinationViewController;
     advancedOptionsSelect *triv = [[advancedOptionsSelect alloc]init];
     triv = nav.viewControllers[0];
     triv.num = indexPath.row;
     triv.delegate = self;
     if (indexPath.row == 0) {
     triv.arrayForTableView = primaryMuscleList;
     triv.titleText = @"Select Muscle";
     
     }
     else if (indexPath.row == 1) {
     triv.arrayForTableView = secondaryMuscleList;
     triv.titleText = @"Select Muscle";
     }
     else if (indexPath.row == 2) {
     triv.arrayForTableView = equipmentList;
     triv.titleText = @"Select Equipment";
     
     }
     else if (indexPath.row == 3) {
     triv.arrayForTableView = difficultyList;
     triv.titleText = @"Select Difficulty";
     
     }
     else if (indexPath.row == 4) {
     NSArray *exerciseTypes = @[@"Strength",@"Stretching",@"Warmup"];
     triv.arrayForTableView = exerciseTypes;
     triv.titleText = @"Select Exercise Type";
     }
     }


     */

}

@end
