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
    
    //Hide the tabbar.
    self.tabBarController.tabBar.hidden = YES;
    
    //Set the title for the page.
    self.title = @"Preferences";
    
    //Style the alert views.
   // [CommonSetUpOperations styleAlertView:JOURNAL_COLOR];
    
    //Fill the arrays with the.
    generalPreferences = @[@"Tutorial Messages",@"Automatic Database Updates",@"List View",@"Default Launch Module",@"Notifications"];
    journalPreferences = @[@"Show Calendar Weeks",@"Highlight Weekends",@"Simple Mode",@"Default Calendar View",@"Default Selected Date",@"Logging"];
    exercisesPreferences = @[@"Intelligent Mode",@"Always Focused Search",@"Scientific Muscle Names",@"Recent Exercises Shown",@"Default View"];
    workoutPreferences = @[@"Workout Sectioning",@"Default View"];
    likedPreferences = @[@"Default View"];
    
    launchModules = @[@"Journal",@"Exercises",@"Workouts",@"Liked"];
    calendarViews = @[@"Month",@"Week"];
    defaultSelectedDate = @[@"Today",@"Last Exercise Log",@"Last Workout Log",@"Last Log",@"Next Planned Workout"];
    recentsShown = @[@"10",@"15",@"20",@"25",@"30",@"35",@"40",@"45",@"50",@"All History"];
    defaultExercisesViews = @[@"Custom Exercises",@"Body Zone",@"Recents",@"Advanced Search"];
     defaultWorkoutsViews = @[@"Categories",@"Custom Workouts"];
     defaultLikedViews = @[@"Exercises",@"Workouts"];
    
    //Gets rid of the weird fact that the tableview starts 60px down.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];

}

/*******************************************************/
#pragma mark - TableView Delegate and Datasource Methods
/*******************************************************/

//Returns the height for the tableViews cells.
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 48.0f;
}

//Returns the number of sections for the tableView.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

//Returns the number of rows in each section.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [generalPreferences count];
    }
    else if (section == 1) {
        return [journalPreferences count];
    }
    else if (section == 2) {
        return [exercisesPreferences count];
    }
    else if (section == 3) {
        return [workoutPreferences count];
    }
    else if (section ==  4) {
        return [likedPreferences count];
    }
    else {
        return 1;
    }
}

//Cell for row at index path for the tableViews.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //Define a cell identifier.
    static NSString *CellIdentifier = @"preferencesCell";
    //Define a cell identifier for the reset preferences cell.
    static NSString *resetPreferencesIdentifier = @"resetPreferenceCell";
    
    if (indexPath.section != 5) {
        
        //Create reference to the cell.
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        //If the cell is equal to nil than create one.
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        //Set the accessoryView to nil.
        cell.accessoryView = nil;
        //Set the detail text label to nil.
        cell.detailTextLabel.text = @"";
        //Set the font for the text label.
        cell.textLabel.font = TABLE_VIEW_TITLE_FONT;
        //Set the detail text label.
        cell.detailTextLabel.font = tableViewDetailTextFont;
        //Set the text color and the font for the cell textLabels.
        cell.textLabel.textColor = JOURNAL_COLOR;
        cell.detailTextLabel.textColor = LIGHT_GRAY_COLOR;
        //Disable cell selection.
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //Set the text alignment within the cell.
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        //Set the accessory type within the cell.
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        //General Preferences
        if (indexPath.section == 0) {
            
            //Set the cell attributes.
            cell.textLabel.text = [generalPreferences objectAtIndex:indexPath.row];
            
            //Tutorial Messages
            if (indexPath.row == 0) {
                [self addSwitch:cell key:PREFERENCE_TUTORIAL_MESSAGES];
            }
            //Automatic Database Updates
            else if (indexPath.row == 1) {
                [self addSwitch:cell key:PREFERENCE_AUTO_DATABASE_UPDATES];
            }
            //List View
            else if (indexPath.row == 2) {
                [self addSwitch:cell key:PREFERENCE_LIST_VIEW];
            }
            //Default Module
            else if (indexPath.row == 3) {
                cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_DEFAULT_LAUNCH_MODULE];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
            //Notifications
            else if (indexPath.row == 4) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
        }
        //Journal Preferences
        else if (indexPath.section == 1) {
            
            //Set the cell attributes.
            cell.textLabel.text = [journalPreferences objectAtIndex:indexPath.row];
            
            //Show Calendar Weeks
            if (indexPath.row == 0) {
                [self addSwitch:cell key:PREFERENCE_CALENDAR_WEEKS];
            }
            //Highlight Weekends
            else if (indexPath.row == 1) {
                [self addSwitch:cell key:PREFERENCE_HIGHLIGHT_WEEKENDS];
            }
            //Simple Mode
            else if (indexPath.row == 2) {
                [self addSwitch:cell key:PREFERENCE_SIMPLE_MODE];
            }
            //Default Calendar View
            else if (indexPath.row == 3) {
                cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_CALENDAR_VIEW];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
            //Default Selected Date
            else if (indexPath.row == 4) {
                cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_CALENDAR_SELECTED_DATE];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
            //Logging
            else if (indexPath.row == 5) {
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
        }
        //Exercises Preferences
        else if (indexPath.section == 2) {
            
            //Set the cell attributes.
            cell.textLabel.text = [exercisesPreferences objectAtIndex:indexPath.row];
            
            //Intelligent Mode
            if (indexPath.row == 0) {
                [self addSwitch:cell key:PREFERENCE_INTELLIGENT_MODE];
            }
            //Always Focused Search
            else if (indexPath.row == 1) {
                [self addSwitch:cell key:PREFERENCE_ALWAYS_FOCUSED];
            }
            //Scientific Names
            else if (indexPath.row == 2) {
                [self addSwitch:cell key:PREFERENCE_SCIENTIFIC_NAMES];
            }
            //Recents Shown
            else if (indexPath.row == 3) {
                cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_EXERCISES_RECENTS_SHOWN];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
            //Default View
            else if (indexPath.row == 4) {
                cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_DEFAULT_EXERCISES_VIEW];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
        }
        //Workouts Preferences
        else if (indexPath.section == 3) {
            
            //Set the cell attributes.
            cell.textLabel.text = [workoutPreferences objectAtIndex:indexPath.row];
            
            //Workout Sectioning
            if (indexPath.row == 0) {
                [self addSwitch:cell key:PREFERENCE_WORKOUT_SECTIONS];
            }
            //Default View
            else if (indexPath.row == 1) {
                cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_DEFAULT_WORKOUTS_VIEW];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
        }
        //Liked Preferences
        else if (indexPath.section == 4) {
            //Set the cell attributes.
            cell.textLabel.text = [likedPreferences objectAtIndex:indexPath.row];
            
            //Default View
            if (indexPath.row == 0) {
                cell.detailTextLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_DEFAULT_LIKED_VIEW];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleDefault;
            }
        }
        
        //Set the tableView selection color.
        
        
        //Finally return the cell.
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:resetPreferencesIdentifier];
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:resetPreferencesIdentifier];
        }
        
        //Set the font for the text label.
        cell.textLabel.font = TABLE_VIEW_TITLE_FONT;
        cell.textLabel.text = @"Reset";
        //cell.textLabel.textColor = RED_COLOR;
        cell.detailTextLabel.text = nil;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        
        
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
    if (section == 5) {
        return 35;
    }
    else {
        return 2;
    }
}

//Returns the title for headers in the tableView.
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
         return @"GENERAL";
    }
    else if (section == 1) {
        return @"JOURNAL";
    }
    else if (section == 2) {
        return @"EXERCISES";
    }
    else if (section == 3) {
        return @"WORKOUTS";
    }
    else if (section == 4) {
        return @"LIKED";
    }
    else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.frame = CGRectMake(15, 18, self.view.frame.size.width, 20);
    myLabel.font = TABLE_VIEW_SECTION_TITLE_FONT;
    myLabel.textColor = DARK_GRAY_COLOR;
    myLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    
    UIView *headerView = [[UIView alloc] init];
    [headerView addSubview:myLabel];
    
    return headerView;
}

//----------------------------------
#pragma mark Cell Selection Handling
//----------------------------------

//Called when a user selects a cell.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //Reset Preferences
    if (indexPath.section == 5) {
        [self resetPreferences];
    }
    else if (((indexPath.section == 0) && (indexPath.row == 3)) || ((indexPath.section == 1) && ((indexPath.row == 3) || (indexPath.row == 4))) || ((indexPath.section == 2) && ((indexPath.row == 3) || (indexPath.row == 4))) || ((indexPath.section == 3) && (indexPath.row == 1)) || (indexPath.section == 4)) {
        [self performSegueWithIdentifier:@"showOptions" sender:self];
    }
    else if (indexPath.row == 4 && indexPath.section == 0){
        [self performSegueWithIdentifier:@"NotificationPreferences" sender:nil];
    }
    else if (indexPath.row == 5 && indexPath.section == 1){
        [self performSegueWithIdentifier:@"LoggingPreferences" sender:nil];
    }
    
    //Deselect the tableView cell once the user has selected.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/*****************************************/
#pragma mark - Selection Delegate Methods
/*****************************************/

- (void)selectedItemsWithCount:(NSMutableArray *)selectedItems indexPath:(NSIndexPath *)indexPath passedArrayCount:(NSInteger)passedArrayCount {
    
    UITableViewCell *cell = [self.preferencesTableView cellForRowAtIndexPath:indexPath];
    
    if (indexPath.row == 3 && indexPath.section == 0) {
        cell.detailTextLabel.text = [selectedItems firstObject];
        [[NSUserDefaults standardUserDefaults] setValue:[selectedItems firstObject] forKeyPath:PREFERENCE_DEFAULT_LAUNCH_MODULE];
    }
    else if (indexPath.row == 3 && indexPath.section == 1) {
        cell.detailTextLabel.text = [selectedItems firstObject];
        [[NSUserDefaults standardUserDefaults] setValue:[selectedItems firstObject] forKeyPath:PREFERENCE_CALENDAR_VIEW];
    }
    else if (indexPath.row == 4 && indexPath.section == 1) {
        cell.detailTextLabel.text = [selectedItems firstObject];
        [[NSUserDefaults standardUserDefaults] setValue:[selectedItems firstObject] forKeyPath:PREFERENCE_CALENDAR_SELECTED_DATE];
    }
    else if (indexPath.row == 3 && indexPath.section == 2) {
        cell.detailTextLabel.text = [selectedItems firstObject];
        [[NSUserDefaults standardUserDefaults] setValue:[selectedItems firstObject] forKeyPath:PREFERENCE_EXERCISES_RECENTS_SHOWN];
    }
    else if (indexPath.row == 4 && indexPath.section == 2) {
        cell.detailTextLabel.text = [selectedItems firstObject];
        [[NSUserDefaults standardUserDefaults] setValue:[selectedItems firstObject] forKeyPath:PREFERENCE_DEFAULT_EXERCISES_VIEW];
    }
    else if (indexPath.row == 1 && indexPath.section == 3) {
        cell.detailTextLabel.text = [selectedItems firstObject];
        [[NSUserDefaults standardUserDefaults] setValue:[selectedItems firstObject] forKeyPath:PREFERENCE_DEFAULT_WORKOUTS_VIEW];
    }
    else if (indexPath.row == 0 && indexPath.section == 4) {
        cell.detailTextLabel.text = [selectedItems firstObject];
        [[NSUserDefaults standardUserDefaults] setValue:[selectedItems firstObject] forKeyPath:PREFERENCE_DEFAULT_LIKED_VIEW];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:PREFERENCE_CHANGE_NOTIFICATION object:nil];
}

/****************************/
#pragma mark - Helper Methods
/****************************/

//Adds a switch to a cell in the tableView.
- (void)addSwitch:(UITableViewCell*)tableViewCell key:(NSString*)key {
    //Make reference to the ce
    PreferenceSwitch *switchView = [[PreferenceSwitch alloc] initWithFrame:CGRectZero];
    
    switchView.onTintColor = JOURNAL_COLOR;
    switchView.preferenceKey = key;
    
    [switchView addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:key]) {
        [switchView setOn:TRUE animated:FALSE];
    }
    else {
        [switchView setOn:FALSE animated:FALSE];
    }
    
    tableViewCell.accessoryView = switchView;
}

//Called when a switch is pressed.
- (void)switchValueChanged:(id)sender{
    //Create reference between the sender and the preference switch.
    PreferenceSwitch *preferenceSwitch = (PreferenceSwitch *)sender;
    
    //If the switch is turned off then disable the preference.
    if(![preferenceSwitch isOn]){
        [CommonUtilities updateBoolForKey:preferenceSwitch.preferenceKey boolValue:NO];
    }
    //Otherwise enable the preferences.
    else{
        [CommonUtilities updateBoolForKey:preferenceSwitch.preferenceKey boolValue:YES];
    }
}

//Resets the users preferences.
- (void)resetPreferences {
    
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:@"title" andMessage:nil];
    [alertView addButtonWithTitle:@"Yes"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              //Reset the users preferences.
                              [CommonUtilities resetUserPreferences];
                              //Reload the tableView to reflect the new preferences.
                              [self.preferencesTableView reloadData];
                          }];
    [alertView addButtonWithTitle:@"Cancel"
                             type:SIAlertViewButtonTypeCancel
                          handler:nil];
    alertView.title = @"Are you sure?";
    alertView.message = @"Resetting your preferences will set them back to what we suggest.";
    [alertView show];

}

/********************************/
#pragma mark - Prepare For Segue
/********************************/

//Notifies the view controller that a segue is about to be performed. Do any additional setup before going to the next view.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showOptions"]) {
        NSIndexPath *indexPath = [self.preferencesTableView indexPathForSelectedRow];
        SelectionViewController *selectionViewController = [[SelectionViewController alloc] init];
        selectionViewController = segue.destinationViewController;
        selectionViewController.multipleSelectionMode = NO;
        selectionViewController.selectedIndexPath = indexPath;
        selectionViewController.selectionDelegate = self;
        
        //Default Launch Module
        if (indexPath.row == 3 && indexPath.section == 0) {
            selectionViewController.titleText = @"Launch Module";
            selectionViewController.selectionArray = launchModules;
            selectionViewController.selectedItems = [[NSMutableArray alloc] initWithObjects:[[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_DEFAULT_LAUNCH_MODULE], nil];

        }
        //Default Calendar View
        else if (indexPath.row == 3 && indexPath.section == 1) {
            selectionViewController.titleText = @"Calendar View";
            selectionViewController.selectionArray = calendarViews;
            selectionViewController.selectedItems = [[NSMutableArray alloc] initWithObjects:[[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_CALENDAR_VIEW], nil];
            
        }
        //Default Selected Date
        else if (indexPath.row == 4 && indexPath.section == 1) {
            selectionViewController.titleText = @"Selected Date";
            selectionViewController.selectionArray = defaultSelectedDate;
            selectionViewController.selectedItems = [[NSMutableArray alloc] initWithObjects:[[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_CALENDAR_SELECTED_DATE], nil];
            
        }
        //Recent Exercises Shown
        else if (indexPath.row == 3 && indexPath.section == 2) {
            selectionViewController.titleText = @"Recents Shown";
            selectionViewController.selectionArray = recentsShown;
            selectionViewController.selectedItems = [[NSMutableArray alloc] initWithObjects:[[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_EXERCISES_RECENTS_SHOWN], nil];
            
        }
        //Default Exercises View
        else if (indexPath.row == 4 && indexPath.section == 2) {
            selectionViewController.titleText = @"Default Exercises View";
            selectionViewController.selectionArray = defaultExercisesViews;
            selectionViewController.selectedItems = [[NSMutableArray alloc] initWithObjects:[[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_DEFAULT_EXERCISES_VIEW], nil];
            
        }
        //Default Workouts View
        else if (indexPath.row == 1 && indexPath.section == 3) {
            selectionViewController.titleText = @"Default Workouts View";
            selectionViewController.selectionArray = defaultWorkoutsViews;
            selectionViewController.selectedItems = [[NSMutableArray alloc] initWithObjects:[[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_DEFAULT_WORKOUTS_VIEW], nil];
            
        }
        //Default Liked View
        else if (indexPath.row == 0 && indexPath.section == 4) {
            selectionViewController.titleText = @"Default Liked View";
            selectionViewController.selectionArray = defaultLikedViews;
            selectionViewController.selectedItems = [[NSMutableArray alloc] initWithObjects:[[NSUserDefaults standardUserDefaults] valueForKey:PREFERENCE_DEFAULT_LIKED_VIEW], nil];
            
        }
    }
}

/**************************************/
#pragma mark - View Terminating Methods
/**************************************/

//Handles anything we need to clear or reset when the view is about to disappear.
-(void)viewWillDisappear:(BOOL)animated {
    //Dismiss any outstaning notifications.
    [TSMessage dismissActiveNotification];
}

@end
