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
/*
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
    if ([item.title isEqualToString:@"Journal"]) {
        
        //Set the appearance of the navigation bar. Set the text color to BLUE_COLOR constant.
        //Set the font of the navigation bar to the STAYHEALTHY_NABBARFONT
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               JOURNAL_COLOR,
                                                               NSForegroundColorAttributeName,
                                                               NAVIGATIONBAR_TITLE_FONT,
                                                               NSFontAttributeName,
                                                               nil]];
        
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                               NSFontAttributeName:NAVIGATIONBAR_BUTTON_FONT,
                                                               NSForegroundColorAttributeName:JOURNAL_COLOR
                                                               } forState:UIControlStateNormal];
    
        
        
        NSLog(@"Timline Pressed");
    }
    else if ([item.title isEqualToString:@"Exercises"]) {
        
        //Set the appearance of the navigation bar. Set the text color to BLUE_COLOR constant.
        //Set the font of the navigation bar to the STAYHEALTHY_NABBARFONT
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               EXERCISES_COLOR,
                                                               NSForegroundColorAttributeName,
                                                               NAVIGATIONBAR_TITLE_FONT,
                                                               NSFontAttributeName,
                                                               nil]];
        
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                               NSFontAttributeName:NAVIGATIONBAR_BUTTON_FONT,
                                                               NSForegroundColorAttributeName:EXERCISES_COLOR
                                                               } forState:UIControlStateNormal];
        
        NSLog(@"People Manager Pressed");
    }
    else if ([item.title isEqualToString:@"Workouts"]) {
        
        //Set the appearance of the navigation bar. Set the text color to BLUE_COLOR constant.
        //Set the font of the navigation bar to the STAYHEALTHY_NABBARFONT
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                               WORKOUTS_COLOR,
                                                               NSForegroundColorAttributeName,
                                                               NAVIGATIONBAR_TITLE_FONT,
                                                               NSFontAttributeName,
                                                               nil]];
        
        [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                                               NSFontAttributeName:NAVIGATIONBAR_BUTTON_FONT,
                                                               NSForegroundColorAttributeName:WORKOUTS_COLOR
                                                               } forState:UIControlStateNormal];

        [[UINavigationBar appearance] setTintColor:WORKOUTS_COLOR];
        //Set the tint color of all tab bars.
        //[[UITabBar appearance] setBarTintColor:WHITE_COLOR];
        [[UITabBar appearance] setTintColor:WORKOUTS_COLOR];
        //Set the tint color of all segmented controls.
        [[UISegmentedControl appearance] setTintColor:WORKOUTS_COLOR];
        
        NSLog(@"Calendar Pressed");
    }
    else {
        
        [[UINavigationBar appearance] setBarTintColor:LIKED_COLOR];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTranslucent:NO];
        
        NSLog(@"Settings Pressed");
    }
    
}
*/
/***************************************/
#pragma mark - View Terminating Methods
/***************************************/

//Handles anything we need to clear or reset when the view is about to disappear.
-(void)viewDidAppear:(BOOL)animated {

    //Show the initial walkthrough/legal agreement if the user is launching the app for the first time.
   /* if (![[NSUserDefaults standardUserDefaults] boolForKey:USER_FIRST_LAUNCH]) {
        //Perform the segue to actually go to the view.
        [self performSegueWithIdentifier:@"walkThrough" sender:nil];
        
        
        //Set the current installed version on the first launch to be "1"
        [[NSUserDefaults standardUserDefaults] setValue:PRELOADED_DATABASE_VERSION forKey:USER_INSTALLED_DATABASE_VERSION];
        //Setting auto database preference.
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:PREFERENCE_AUTO_DATABASE_UPDATES];
        //Save the changes.
        [[NSUserDefaults standardUserDefaults] synchronize];
         
    }*/
}



@end
