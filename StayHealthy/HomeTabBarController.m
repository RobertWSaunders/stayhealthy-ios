//
//  HomeTabBarController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-03-19.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import "HomeTabBarController.h"


@implementation HomeTabBarController

/**********************************/
#pragma mark - View Loading Methods
/**********************************/

//Perform any set up for the view once it has loaded.
- (void)viewDidLoad {
    
    //The "Journal" tab bar item on the tab bar.
    UITabBarItem *journalItem = [[self.tabBar items] objectAtIndex:0];
    //Setting the image for the journal item.
    [journalItem setSelectedImage:[UIImage imageNamed:@"JournalTabFilled.png"]];
    
    //The "Find Exercise" tab bar item on the tab bar.
    UITabBarItem *findExerciseItem = [[self.tabBar items] objectAtIndex:1];
    //Setting the image for the find exercise item.
    [findExerciseItem setSelectedImage:[UIImage imageNamed:@"ExerciseTabFilled.png"]];
    
    //The "Workouts" tab bar item on the tab bar.
    UITabBarItem *workoutsItem = [[self.tabBar items] objectAtIndex:2];
    //Setting the image for the workout item.
    [workoutsItem setSelectedImage:[UIImage imageNamed:@"WorkoutsTabFilled.png"]];
    
    //The "Favorites" tab bar item on the tab bar.
    UITabBarItem *favoritesItem = [[self.tabBar items] objectAtIndex:3];
    //Setting the image for the favorites item.
    [favoritesItem setSelectedImage:[UIImage imageNamed:@"FavoritesTabFilled.png"]];
    
    //The "Settings" tab bar item on the tab bar.
    UITabBarItem *settingsItem = [[self.tabBar items] objectAtIndex:4];
    //Setting the image for the settings item.
    [settingsItem setSelectedImage:[UIImage imageNamed:@"SettingsTabFilled.png"]];
    
    //Set the background for both the navigation controller so that we don't get the weird dark tinges sometimes.
    //Set navigation controller background to white.
    self.navigationController.view.backgroundColor = [UIColor whiteColor];
    //Set tabBar controller background to white.
    self.tabBarController.view.backgroundColor = [UIColor whiteColor];
}

/***************************************/
#pragma mark - View Terminating Methods
/***************************************/

//Handles anything we need to clear or reset when the view is about to disappear.
-(void)viewDidAppear:(BOOL)animated {

    //Show the initial walkthrough/legal agreement if the user is launching the app for the first time.
    if (![[NSUserDefaults standardUserDefaults] boolForKey:USER_FIRST_LAUNCH]) {
        //Perform the segue to actually go to the view.
        [self performSegueWithIdentifier:@"walkThrough" sender:nil];
        
        
        //Set the current installed version on the first launch to be "1"
        [[NSUserDefaults standardUserDefaults] setValue:PRELOADED_DATABASE_VERSION forKey:USER_INSTALLED_DATABASE_VERSION];
        //Setting auto database preference.
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:PREFERENCE_AUTO_DATABASE_UPDATES];
        //Save the changes.
        [[NSUserDefaults standardUserDefaults] synchronize];
         
    }
}



@end
