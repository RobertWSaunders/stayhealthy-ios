//
//  WorkoutDetailViewController.h
//  StayHealthy
//
//  Created by Student on 3/26/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "ExerciseDetailViewController.h"
#import "WorkoutViewController.h"
#import "UIViewController+MJPopupViewController.h"
#import "PopupViewController.h"

#import "WorkoutDetailUTableViewCell.h"
#import "ALCustomColoredAccessory.h"

//The delegate that gets called from the calendarviewcontroller.
@protocol backDelegate <NSObject>

-(void)backButtonPressed;

@end


@interface WorkoutDetailViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate,MJSecondPopupDelegate> {
    NSMutableArray *workoutExercises;
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^The array that will hold all the exercise data.
    sqlite3 * db;
    //^^^^^^^^^^^^^^^^^^^^^^^^^^^^The database declaration./the database.
    NSMutableArray *checkIfFavorite;
    NSArray *sportsArray;
    NSArray *muscleArray;
    NSArray *equipmentArray;
    NSArray *allSports;
    NSArray *allMuscles;
    NSArray *detailInformation;
    NSArray *detail;
    NSMutableIndexSet *expandedSections;

}

@property (weak, nonatomic) IBOutlet NSArray *typeArray;
@property (weak, nonatomic) IBOutlet UITableView *workoutExercisesTable;
@property (weak, nonatomic) IBOutlet UITableView *workoutExpandableTable;
@property (weak, nonatomic) IBOutlet NSString *query;
@property (weak, nonatomic) IBOutlet NSString *dummieText;
@property (weak, nonatomic) IBOutlet NSString *queryText;
@property (weak, nonatomic) IBOutlet NSString *titleText;
@property (weak, nonatomic) IBOutlet NSString *summary;
//@property (weak, nonatomic) IBOutlet UICollectionView *workoutDetails;
@property (weak, nonatomic) IBOutlet UIButton *startWorkoutButton;
@property (weak, nonatomic) IBOutlet UILabel *summaryText;
@property (weak, nonatomic) IBOutlet UITableView *exercisesTableView;
@property (weak, nonatomic) IBOutlet NSString *typeText;
@property (weak, nonatomic) IBOutlet NSString *difficultyText;
@property (weak, nonatomic) IBOutlet NSString *genderText;
@property (weak, nonatomic) IBOutlet NSString *completedText;
@property (weak, nonatomic) IBOutlet NSString *sportText;
@property (weak, nonatomic) IBOutlet NSString *equipText;
@property (weak, nonatomic) IBOutlet NSString *muscleText;
@property (weak, nonatomic) IBOutlet NSString *workoutID;

//The favorites uibarbutton item.
@property (strong, nonatomic) UIBarButtonItem *favoriteButton;

- (IBAction)segmentValueChanged:(UISegmentedControl*)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
- (IBAction)readMoreButton:(id)sender;
@property(nonatomic,retain) NSMutableArray *workoutExercises;
//The mutable array.
-(NSMutableArray *) workoutExercises;

@property (assign, nonatomic) id <backDelegate> backDelegate;

@end

