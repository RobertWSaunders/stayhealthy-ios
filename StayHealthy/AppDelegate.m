//
//  AppDelegate.m
//  StayHealthy
//
//  Created by Student on 12/7/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

//Our managed object context, manages our managed objects (objects in our object graph)
@synthesize managedObjectContext = _managedObjectContext;
//Generic class that implements all the basic behaivours required for core data.
@synthesize managedObjectModel = _managedObjectModel;
//Persists the store, looks through our objects and finds the one that we need.
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - App Delegate Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    setenv("XcodeColors", "YES", 0);
    
    //Set the appearance of the navigation bar. Set the text color to STAYHEALTHY_BLUE constant.
    //Set the font of the navigation bar to the STAYHEALTHY_NABBARFONT
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                            STAYHEALTHY_BLUE,
                                                            NSForegroundColorAttributeName,
                                                            STAYHEALTHY_NAVBARFONT,
                                                            NSFontAttributeName,
                                                           nil]];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{
                                         NSFontAttributeName: [UIFont fontWithName:@"Avenir" size:18.0],
                                         NSForegroundColorAttributeName: STAYHEALTHY_BLUE
                                         } forState:UIControlStateNormal];
    
    //Set the tint color of all tab bars.
    [[UITabBar appearance] setTintColor:STAYHEALTHY_BLUE];
    //Set the tint color of all segmented controls.
    [[UISegmentedControl appearance] setTintColor:STAYHEALTHY_BLUE];
    //Set the tint color for all the navigation bars.
    [[UINavigationBar appearance] setTintColor:STAYHEALTHY_BLUE];
    
    [Parse setApplicationId:@"WV7lo14mPjcjRmuc4vgdOXuQg6aWihFO7s6oqBNy"
                  clientKey:@"dYyFOqO28p3WcdiWAVmK7YIna1gVWQOpyEhHZnZq"];
    
    UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                    UIUserNotificationTypeBadge |
                                                    UIUserNotificationTypeSound);
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                             categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"advancedOptionsSelect-FirstSelection"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    if ([shortcutItem.type isEqualToString:@"findExercise"]) {
        UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
        tabBar.selectedIndex = 0;
    }
    else  {
        UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
        tabBar.selectedIndex = 1;
    }
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
    PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[ @"global" ];
    [currentInstallation saveInBackground];
}

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo {
     [PFPush handlePush:userInfo];
}
- (void)applicationWillResignActive:(UIApplication *)application {
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
}
- (void)applicationWillTerminate:(UIApplication *)application {
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

//All of the core data methods.
#pragma mark - Core Data Stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"StayHealthy" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"StayHealthy.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

//Saves objects into the context.
- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}



@end
