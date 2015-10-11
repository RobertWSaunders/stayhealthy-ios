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

- (void)viewDidLoad {
    
    //Set the title for the page.
    self.title = @"Preferences";
    
    //Fill the arrays with the.
    userPreferences = @[@"Enable Tutorial Messages"];
    userPreferencesUserInterface = @[@"Default Orientation"];
    
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
    return 2;
}

//Returns the height of the section headers.
- (CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

//Returns the height of the footers.
- (CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

//Returns the number of rows in each section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [userPreferences count];
    }
    else {
        return [userPreferencesUserInterface count];
    }
}

//Cell for row at index path for the tableViews.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //The cell identifier for the cells in the tableView.
    static NSString *CellIdentifier = @"preferencesCell";
    
    //Create reference to the cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //If the cell is equal to nil than create one.
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [userPreferences objectAtIndex:indexPath.row];
        [self addSwitch:cell key:TUTORIAL_MESSAGES];
    }
    else if (indexPath.section == 1) {
        cell.textLabel.text = [userPreferencesUserInterface objectAtIndex:indexPath.row];
        [self addSegmentControl:cell key:LIST_ORIENTATION arrayForControl:[NSArray arrayWithObjects:@"List",@"Collection", nil]];
        
    }
    
    //Set the text color and the font for the cell textLabels.
    cell.textLabel.textColor = STAYHEALTHY_BLUE;
    cell.textLabel.font = tableViewTitleTextFont;
    
    //Set the tableView selection color.
    [CommonSetUpOperations tableViewSelectionColorSet:cell];
    
    //Finally return the cell.
    return cell;
}

//Returns the title for the header in the tableView.
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"General Preferences";
    }
    else {
        return @"User Interface";
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Deselect the tableView cell once the user has selected.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

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
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectZero];
    
    segmentedControl = [[UISegmentedControl alloc] initWithItems:arrayForControl];
    
    [segmentedControl addTarget:self action:@selector(segmentValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:key]) {
        segmentedControl.selectedSegmentIndex = 1;
    }
    else {
        segmentedControl.selectedSegmentIndex = 0;
    }
    
    tableViewCell.accessoryView =  segmentedControl;
}

- (void)switchValueChanged:(id)sender{
    
    if([sender isOn]){
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:TUTORIAL_MESSAGES];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:TUTORIAL_MESSAGES];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)segmentValueChanged:(id)sender{
    if([sender selectedSegmentIndex] == 0){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:LIST_ORIENTATION];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:LIST_ORIENTATION];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}



@end
