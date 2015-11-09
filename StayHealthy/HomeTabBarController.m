//
//  HomeTabBarController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-03-19.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import "HomeTabBarController.h"


@implementation HomeTabBarController

- (void)viewDidLoad {
    
    
    UITabBarItem *findExerciseItem = [[self.tabBar items] objectAtIndex:0];
    [findExerciseItem setSelectedImage:[UIImage imageNamed:@"Exercise Filled-50.png"]];
    
    //UITabBarItem *workoutsItem = [[self.tabBar items] objectAtIndex:1];
    //[workoutsItem setSelectedImage:[UIImage imageNamed:@"Barbell Filled-25"]];
    
    UITabBarItem *likedItem = [[self.tabBar items] objectAtIndex:1];
    [likedItem setSelectedImage:[UIImage imageNamed:@"likeSelectedBig.png"]];
    
    UITabBarItem *settingsItem = [[self.tabBar items] objectAtIndex:2];
    [settingsItem setSelectedImage:[UIImage imageNamed:@"Settings Filled-50.png"]];
    
  

    
    
    
    //self.navigationController.view.window.tintColor = STAYHEALTHY_BLUE;
   // self.tabBarController.tabBar.tintColor = STAYHEALTHY_BLUE;

}

-(void)viewDidAppear:(BOOL)animated {
    //Show the initial walkthrough if the user is launching the app for the first time.
    if (![[NSUserDefaults standardUserDefaults] boolForKey:USER_FIRST_LAUNCH]) {
        [self performSegueWithIdentifier:@"walkThrough" sender:nil];
    }
}



@end
