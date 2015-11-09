/**
 `ExerciseSelectionViewController` is responsible for allowing the user to find exercises. Users are able to select exercises by specific muscles, recently viewed, or they can be directed to the advanced search view controller to perform an advanced search. Users can select exercises of three types, warmup, strength or stretching.
 */

// Robert Saunders
// 23/08/15
// 1.0.0

#import <UIKit/UIKit.h>
#import "ExerciseListController.h"
#import "MGSwipeButton.h"
#import "ExerciseTableViewCell.h"

@interface ExerciseSelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate> {
    
    __weak IBOutlet UISegmentedControl *segmentedControl;
    //Array filled with all the front body muscles.
    NSArray *frontBodyMuscles;
    //Array filled with all the front body muscle scientific names.
    NSArray *frontBodyMusclesScientificNames;
    //Array filled with all the back body muscles.
    NSArray *backBodyMuscles;
    //Array filled with all the back body muscle scientific names.
    NSArray *backBodyMusclesScientificNames;
    
    //Array filled with all the recenlty viewed exercises.
    NSMutableArray *recenltyViewedExercises;
    
    //Keeps track of the index the user selected in the alert.
    NSUInteger alertIndex;
    //Keeps track of the indexPath of the cell the user selected in the muscleSelectionTableView.
   // NSIndexPath *selectedTableViewIndex;
    
    //Boolean to track whether the user pressed on the warmup icon or not.
    BOOL warmupPressed;
    
    BOOL checkIndex;
    
    exerciseTypes typeSwiped;
}

/**
 -------------
 @name Properties
 -------------
 */

@property (strong, nonatomic) NSIndexPath *selectedTableViewIndex;

/**
 View that holds `recentlyViewedTableView`.
 */
@property (weak, nonatomic) IBOutlet UIView *recentlyViewedView;
/**
 View that holds `muscleSelectionTableView`.
 */
@property (weak, nonatomic) IBOutlet UIView *muscleSelectionView;
/**
 TableView that holds the recenlty viewed exercises.
 */
@property (weak, nonatomic) IBOutlet UITableView *recentlyViewedTableView;
/**
 TableView that holds the muscles the user can choose from to find exercises.
 */
@property (weak, nonatomic) IBOutlet UITableView *muscleSelectionTableView;

/**
 ----------
@name Actions
 ----------
 */

/**
 Gets called when the user changes the selected segement in the segemented control. This segmented control hides the `muscleSelectionView` and `recentlyViewedView`.
 @param sender Object which sent the message to that selector.
 */
- (IBAction)segmentValueChanged:(id)sender;

/**
 Gets called when the user presses the warmup icon in the navigation bar.
 @param sender Object which sent the message to that selector.
 */
- (IBAction)warmupButtonPressed:(id)sender;

@end
