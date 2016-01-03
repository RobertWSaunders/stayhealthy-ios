//
//  PreferencesViewController.m
//  
//
//  Created by Robert Saunders on 2015-07-12.
//
//

#import "PreferencesViewController.h"

@implementation PreferencesViewController

/**********************************/
#pragma mark - View Loading Methods
/**********************************/

//What happens right before the view loads.
- (void)viewDidLoad {
    
    self.tabBarController.tabBar.hidden=YES;
          
    //Set the title for the page.
    self.title = @"Preferences";
    
    [self setTableViewData];
    
    //Fill the arrays with the.
    generalPreferences = @[@"Auto Database Updates",@"Tutorial Messages"];
    findExercisePreferences = @[@""];
    workoutPreferences = @[@""];
    favouritesPreferences = @[@""];
    
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;
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
        
        //Create reference to the cell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        //If the cell is equal to nil than create one.
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        if (indexPath.section == 0) {
            cell.detailTextLabel.text = @"";
            cell.textLabel.text = [generalPreferences objectAtIndex:indexPath.row];
            if (indexPath.row == 0) {
                [self addSwitch:cell key:PREFERENCE_TUTORIAL_MESSAGES];
            }
            else {
                [self addSwitch:cell key:PREFERENCE_TUTORIAL_MESSAGES];
            }
            
        }
    
        //Set the text color and the font for the cell textLabels.
        cell.textLabel.textColor = BLUE_COLOR;
        cell.textLabel.font = tableViewTitleTextFont;
        
        //Set the tableView selection color.
        [CommonSetUpOperations tableViewSelectionColorSet:cell];
        
        //Finally return the cell.
        return cell;
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
    if (section == 3) {
        return 35;
    }
    else {
        return 2;
    }
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



@end
