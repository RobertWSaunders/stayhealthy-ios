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
    
    UITabBarItem *tabBarItem1 = [[self.tabBar items] objectAtIndex:1];
    [tabBarItem1 setSelectedImage:[UIImage imageNamed:@"Barbell Filled-25.png"]];
    
    UITabBarItem *tabBarItem2 = [[self.tabBar items] objectAtIndex:0];
    [tabBarItem2 setSelectedImage:[UIImage imageNamed:@"Exercise Filled-50.png"]];
    
    UITabBarItem *tabBarItem3 = [[self.tabBar items] objectAtIndex:2];
    [tabBarItem3 setSelectedImage:[UIImage imageNamed:@"Star Filled-50.png"]];
    
    UITabBarItem *tabBarItem4 = [[self.tabBar items] objectAtIndex:3];
    [tabBarItem4 setSelectedImage:[UIImage imageNamed:@"Settings Filled-50.png"]];
    
  /*
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"FirstLaunchOfProfile"]) {
        [self performSegueWithIdentifier:@"walkThrough" sender:nil];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstLaunchOfProfile"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    */
    self.navigationController.view.window.tintColor = STAYHEALTHY_BLUE;
    self.tabBarController.tabBar.tintColor = STAYHEALTHY_BLUE;

}



@end
