//
//  AppDelegate.h
//  StayHealthy
//
//  Created by Student on 12/7/2013.
//  Copyright (c) 2013 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "LaunchKit.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//The window for the app, mandatory if we use a storyboard.
@property (strong, nonatomic) UIWindow *window;

//Our managed object context, manages our managed objects (objects in our object graph).
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//Generic class that implements all the basic behaivours required for core data.
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//Persists the store, looks through our objects and finds the one that we need.
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//Saves the objects into the context.
- (void)saveContext;
//Returns the URL to the documents directory.
- (NSURL *)applicationDocumentsDirectory;

@end
