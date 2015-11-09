//
//  PreferencesTableViewController.h
//  
//
//  Created by Robert Saunders on 2015-07-12.
//
//

#import <UIKit/UIKit.h>

@interface PreferencesTableViewController : UITableViewController {
    
    //Array filled with overall application preferences.
    NSArray *generalPreferences;
    
    //Array filled with 'Find Exercise' preferences.
    NSArray *findExercisePreferences;
    
    //Array filled with 'Workout' preferences.
    NSArray *workoutPreferences;
    
    //Array filled with 'Favorites' preferences.
    NSArray *favouritesPreferences;
}


@end
