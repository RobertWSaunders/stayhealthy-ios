//
//  AppDelegate.m
//  StayHealthy
//
//  Created by Student on 12/7/2013.
//  Copyright (c) 2013 Robert Saunders. All rights reserved.
//

#import "AppDelegate.h"


@implementation AppDelegate

//Our managed object context, manages our managed objects (objects in our object graph)
@synthesize managedObjectContext = _managedObjectContext;
//Generic class that implements all the basic behaivours required for core data.
@synthesize managedObjectModel = _managedObjectModel;
//Persists the store, looks through our objects and finds the one that we need.
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

/**********************************/
#pragma mark - App Delegate Methods
/**********************************/

//Called when the application has finished launching.
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
#ifdef DEBUG
    //Set the XcodeColors
    setenv("XcodeColors", "YES", 0);
#endif
    
    //If the application is being launched for the first time set the default preferences.
    if ([CommonUtilities isUsersFirstLaunch]) {
        [CommonUtilities resetUserPreferences];
    }
    
    //Set the tint color all content throughout the application.
    [CommonUtilities setGlobalTintColor:JOURNAL_COLOR];
    
    //Set the iCloud Observers.
    [self setiCloudObservers];
    
    return YES;
}

//Called right before the application is about to move from the active to inactive state.
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

//Called when the application is about to move from the background to the inactive state.
- (void)applicationWillEnterForeground:(UIApplication *)application {
}

//Called when the application is about to move from inactive to active.
- (void)applicationDidBecomeActive:(UIApplication *)application {
}

//Called right before the application terminates.
- (void)applicationWillTerminate:(UIApplication *)application {
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

//-----------------------------
#pragma mark 3D Touch Shortcuts
//-----------------------------

//Called when a user selects a Home screen quick action.
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    //If the shortcut item is find exercise.
    if ([shortcutItem.type isEqualToString:@"exercises"]) {
        UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
        tabBar.selectedIndex = 0;
    }
    //If the shortcut item is workouts.
    else if ([shortcutItem.type isEqualToString:@"workouts"]) {
        UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
        tabBar.selectedIndex = 1;

    }
    //If the shortcut item is favourites.
    else  {
        UITabBarController *tabBar = (UITabBarController *)self.window.rootViewController;
        tabBar.selectedIndex = 2;
    }
}

//------------------------------------
#pragma mark Push Notification Methods
//------------------------------------

//Tells app delegate the application has successfully registered for notifications.
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Store the deviceToken in the current installation and save it to Parse.
  /*  PFInstallation *currentInstallation = [PFInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    currentInstallation.channels = @[ @"global" ];
    [currentInstallation saveInBackground];
   */
}

//Called when the application has recieved a remote notification.
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    //[PFPush handlePush:userInfo];
}

/*****************************/
#pragma mark - Core Data Stack
/*****************************/

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext {
    
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"StayHealthy" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"StayHealthy.sqlite"];
    
    NSError *error = nil;
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
 
 
    //Set the name of the iCloud store, and set the migration options.
    NSDictionary *options = @{NSPersistentStoreUbiquitousContentNameKey:@"StayHealthyiCloud", NSMigratePersistentStoresAutomaticallyOption : @(YES),
                              NSInferMappingModelAutomaticallyOption : @(YES)};
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        
        NSFileManager *fm = [NSFileManager defaultManager];
        
        // Move Incompatible Store
        if ([fm fileExistsAtPath:[storeURL path]]) {
            NSURL *corruptURL = [[self applicationIncompatibleStoresDirectory] URLByAppendingPathComponent:[self nameForIncompatibleStore]];
            
            // Move Corrupt Store
            NSError *errorMoveStore = nil;
            [fm moveItemAtURL:storeURL toURL:corruptURL error:&errorMoveStore];
            
            if (errorMoveStore) {
                NSLog(@"Unable to move corrupt store.");
            }
            
            }
        
        NSError *errorAddingStore = nil;
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&errorAddingStore]) {
            NSLog(@"Unable to create persistent store after recovery. %@, %@", errorAddingStore, errorAddingStore.localizedDescription);
            
        }
        
        // Show Alert View
        NSString *title = @"Warning";
        NSString *applicationName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        NSString *message = [NSString stringWithFormat:@"A serious application error occurred while %@ tried to read your data. Please contact support for help.", applicationName];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        
    }
    
    return _persistentStoreCoordinator;
}

//-----------------------------
#pragma mark Core Data Methods
//-----------------------------

//Saves the core data store.
- (void)saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

//Returns the applications stores directory url.
- (NSURL *)applicationStoresDirectory {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *applicationApplicationSupportDirectory = [[fm URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL *URL = [applicationApplicationSupportDirectory URLByAppendingPathComponent:@"Stores"];
    
    if (![fm fileExistsAtPath:[URL path]]) {
        NSError *error = nil;
        [fm createDirectoryAtURL:URL withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (error) {
            NSLog(@"Unable to create directory for data stores.");
            
            return nil;
        }
    }
    return URL;
}

//Returns the application url if stores are incompatible.
- (NSURL *)applicationIncompatibleStoresDirectory {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *URL = [[self applicationStoresDirectory] URLByAppendingPathComponent:@"Incompatible"];
    
    if (![fm fileExistsAtPath:[URL path]]) {
        NSError *error = nil;
        [fm createDirectoryAtURL:URL withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (error) {
            NSLog(@"Unable to create directory for corrupt data stores.");
            
            return nil;
        }
    }
    
    return URL;
}

//Returns the name of a incompatible store name.
- (NSString *)nameForIncompatibleStore {
    // Initialize Date Formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // Configure Date Formatter
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    
    return [NSString stringWithFormat:@"%@.sqlite", [dateFormatter stringFromDate:[NSDate date]]];
}

//-------------------------
#pragma mark iCloud Methods
//-------------------------

//iCloud Observers - observes for any changes to the iCloud store.
- (void)setiCloudObservers {
    //iCloud Observers - observes for any changes to the iCloud store.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(storesWillChange) name:NSPersistentStoreCoordinatorStoresWillChangeNotification object:self.managedObjectContext.persistentStoreCoordinator];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(storesDidChange:) name:NSPersistentStoreCoordinatorStoresDidChangeNotification object:self.managedObjectContext.persistentStoreCoordinator];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mergeContent:) name:NSPersistentStoreDidImportUbiquitousContentChangesNotification object:self.managedObjectContext.persistentStoreCoordinator];
}

//Called just before the stores change.
- (void)storesWillChange {
    
   LogDataSuccess(@"Stores are about to change...");
    
    //Disable user interaction so the user can't corrupt store.
    [[UIApplication sharedApplication]beginIgnoringInteractionEvents];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //Save/Reset Store
        if (self.managedObjectContext.hasChanges) {
            [self.managedObjectContext save:nil];
        } else {
            [self.managedObjectContext reset];
        }
    });
    
    
}

//Called after the stores have changes.
- (void)storesDidChange:(NSNotification *)notification {
    
    LogDataSuccess(@"Stores did change...");
    
    //Update the UI by posting the notification for the observers to pick up.
    [[NSNotificationCenter defaultCenter] postNotificationName:CLOUD_UPDATE_NOTIFICATION object:self.managedObjectContext];

    LogDataSuccess(@"Updating UI...");
    
    //
    NSNumber *transitionType = [notification.userInfo objectForKey:NSPersistentStoreUbiquitousTransitionTypeKey];
    int transitionReason = [transitionType intValue];
    
    switch (transitionReason) {
        case NSPersistentStoreUbiquitousTransitionTypeAccountAdded: {
            LogInfo(@"Stores changed because a iCloud account was added.");
        }
            break;
        case NSPersistentStoreUbiquitousTransitionTypeAccountRemoved: {
            LogInfo(@"Stores changed because an iCloud account was deleted.");
        }
        case NSPersistentStoreUbiquitousTransitionTypeContentRemoved: {
            LogInfo(@"Stores changed because iCloud data was deleted.");
        }
        case NSPersistentStoreUbiquitousTransitionTypeInitialImportCompleted: {
            LogInfo(@"Stores changed because initial import completed.");
        }
        default:
            break;
    }
    
    LogDataSuccess(@"Successful iCloud Update.");
    
    //Re-enable the UI so the user can use the app.
    [[UIApplication sharedApplication]endIgnoringInteractionEvents];
}

//Called to merge the stores content.
- (void)mergeContent:(NSNotification *)notification {
    
    LogDataSuccess(@"Merging incoming data...");
    
    dispatch_async(dispatch_get_main_queue(), ^{
    // Merge incoming data updates in the managed object context
    [self.managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
    });
    
    LogDataSuccess(@"Updating UI...");
    
    
    // Post notification to trigger UI updates
    [[NSNotificationCenter defaultCenter] postNotificationName:CLOUD_UPDATE_NOTIFICATION object:self.managedObjectContext];
}

//--------------------------------------------
#pragma mark Application's Documents Directory
//--------------------------------------------

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
