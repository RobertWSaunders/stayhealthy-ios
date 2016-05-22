//
//  PreferencesViewController.h
//  
//
//  Created by Robert Saunders on 2015-07-12.
//
//

#import <UIKit/UIKit.h>
#import "PreferenceSwitch.h"
#import "SelectionViewController.h"

@interface PreferencesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SelectionDelegate> {
    //Array filled with overall application preferences.
    NSArray *generalPreferences;
    //Array filled with the Exercises module preferences.
    NSArray *journalPreferences;
    //Array filled with the Exercises module preferences.
    NSArray *exercisesPreferences;
    //Array filled with the Workouts module preferences.
    NSArray *workoutPreferences;
    //Array filled with Liked module preferences.
    NSArray *likedPreferences;
    NSString *currentPreferenceKey;
    
    NSArray *launchModules;
    NSArray *calendarViews;
    NSArray *defaultSelectedDate;
    NSArray *recentsShown;
    NSArray *defaultExercisesViews;
    NSArray *defaultWorkoutsViews;
    NSArray *defaultLikedViews;
}

//UITableView used to present the preferences.
@property (weak, nonatomic) IBOutlet UITableView *preferencesTableView;

@end
