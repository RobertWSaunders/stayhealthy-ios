//
//  PreferencesViewController.h
//  
//
//  Created by Robert Saunders on 2015-07-12.
//
//

#import <UIKit/UIKit.h>

@interface PreferencesViewController : UIViewController {
    
    //Array filled with overall application preferences.
    NSArray *generalPreferences;
    
    //Array filled with 'Find Exercise' preferences.
    NSArray *findExercisePreferences;
    
    //Array filled with 'Workout' preferences.
    NSArray *workoutPreferences;
    
    //Array filled with 'Favorites' preferences.
    NSArray *favouritesPreferences;
}

@property (weak, nonatomic) IBOutlet UITableView *preferencesTableView;

@end
