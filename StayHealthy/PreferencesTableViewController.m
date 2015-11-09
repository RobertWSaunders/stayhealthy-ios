//
//  PreferencesTableViewController.m
//  
//
//  Created by Robert Saunders on 2015-07-12.
//
//

#import "PreferencesTableViewController.h"

@implementation PreferencesTableViewController

/**********************************/
#pragma mark - View Loading Methods
/**********************************/

//What happens right before the view loads.
- (void)viewDidLoad {
    
    //Set the title for the page.
    self.title = @"Preferences";
    
    [self setTableViewData];
    
    //Fill the arrays with the.
    generalPreferences = @[@"Auto Database Updates",@"Tutorial Messages",@""];
    findExercisePreferences = @[@"Scientific Terminology",@"Visible Recently Viewed",@""];
    workoutPreferences = @[@""];
    favouritesPreferences = @[@""];
    
}

-(void)setTableViewData {
    
}

/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the height for the tableViews cells.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

//Returns the number of sections for the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

//Returns the number of rows in each section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [generalPreferences count];
    }
    else if (section == 1) {
        return [findExercisePreferences count];
    }
    else if (section == 2) {
        return [workoutPreferences count];
    }
    else {
        return [favouritesPreferences count];
    }
}

//Cell for row at index path for the tableViews.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"preferencesCell";
    static NSString *findExerciseSegment = @"findExerciseSegment";
    static NSString *workoutsSegment = @"workoutsSegment";
    static NSString *favoritesSegment = @"favoritesSegment";
    static NSString *defaultModuleSegment = @"defaultModuleSegment";

    
    //For cells that need just text or a switch.
    if ((indexPath.section == 0 && indexPath.row == 0) || ((indexPath.section == 1) && (indexPath.row == 0 || indexPath.row == 1))) {
        
        //Create reference to the cell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        //If the cell is equal to nil than create one.
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        if (indexPath.section == 0 && indexPath.row == 0) {
            cell.detailTextLabel.text = @"";
            cell.textLabel.text = [generalPreferences objectAtIndex:indexPath.row];
            [self addSwitch:cell key:PREFERENCE_TUTORIAL_MESSAGES];
        }
        else if (indexPath.section == 1 && indexPath.row == 1) {
            cell.detailTextLabel.text = @"10";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.textLabel.text = [findExercisePreferences objectAtIndex:indexPath.row];
        }
        else if (indexPath.section == 1 && indexPath.row == 0) {
            cell.detailTextLabel.text = @"";
            cell.textLabel.text = [findExercisePreferences objectAtIndex:indexPath.row];
          [self addSwitch:cell key:PREFERENCE_FINDEXERCISE_SCIENTIFIC_NAMES];
        }
        
        //Set the text color and the font for the cell textLabels.
        cell.textLabel.textColor = STAYHEALTHY_BLUE;
        cell.textLabel.font = tableViewTitleTextFont;
        
        //Set the tableView selection color.
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
        
        //Finally return the cell.
        return cell;

    }
    
    
    
    else {
        
        static NSString *cellIdentifier;

        
        if (indexPath.section == 0) {
            cellIdentifier = defaultModuleSegment;
        }
        else if (indexPath.section == 1) {
             cellIdentifier = findExerciseSegment;
        }
        else if (indexPath.section == 2) {
             cellIdentifier = workoutsSegment;
        }
        else {
             cellIdentifier = favoritesSegment;
        }
        
        //Create reference to the cell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
            
        //If the cell is equal to nil than create one.
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }

        //Set the text color and the font for the cell textLabels.
        cell.textLabel.textColor = STAYHEALTHY_BLUE;
        cell.textLabel.font = tableViewTitleTextFont;
        
        //Set the tableView selection color.
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
        
        //Finally return the cell.
        return cell;

    }
    
   }

//----------------------------------------------------
#pragma mark TableView Header and Footer Configuration
//----------------------------------------------------

//Returns the height of the section headers.
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

//Returns the height of the footers.
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    
    return 30;
    
}

//Returns the title for headers in the tableView.
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
         return @"General";
    }
    else if (section == 1) {
        return @"Find Exercise";
    }
    else if (section == 2) {
        return @"Workouts";
    }
    else {
        return @"Favorites";
    }
}

//Returns the title for footers in the tableView.
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return @"Default tab selected when the application loads.";
    }
    else if (section == 1) {
        return @"Default selected view for 'Find Exercise'.";
    }
    else if (section == 2) {
        return @"Default selected view for 'Workouts'";
    }
    else {
        return @"Default selected view for 'Favorites'.";
    }
}

//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //Deselect the tableView cell once the user has selected.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/****************************/
#pragma mark - Helper Methods
/****************************/

- (void)addSwitch:(UITableViewCell*)tableViewCell key:(NSString*)key {
    UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
    
    [switchview addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:key]) {
        switchview.on = YES;
    }
    else {
        switchview.on = NO;
    }
    
    tableViewCell.accessoryView = switchview;
}

- (void)addSegmentControl:(UITableViewCell*)tableViewCell key:(NSString*)key arrayForControl:(NSArray*)arrayForControl {
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(tableViewCell.frame.origin.x+20, tableViewCell.frame.origin.y+20, tableViewCell.frame.size.width, tableViewCell.frame.size.height-40)];
    
    segmentedControl = [[UISegmentedControl alloc] initWithItems:arrayForControl];
    
    [segmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:key]) {
        segmentedControl.selectedSegmentIndex = 0;
    }
    else {
        segmentedControl.selectedSegmentIndex = 1;
    }
    
    [tableViewCell addSubview:segmentedControl];
}

- (void)switchValueChanged:(id)sender{
    
    if([sender isOn]){
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:PREFERENCE_TUTORIAL_MESSAGES];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:PREFERENCE_TUTORIAL_MESSAGES];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)segmentValueChanged:(UISegmentedControl*)sender {
    
    if([sender selectedSegmentIndex] == 0){
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:PREFERENCE_FINDEXERCISE_MODULE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:PREFERENCE_FINDEXERCISE_MODULE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
