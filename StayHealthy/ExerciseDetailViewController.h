//
//  ExerciseDetailViewController.h
//  StayHealthy
//
//  Created by Student on 12/21/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHExercise.h"
#import "SHDataHandler.h"

@interface ExerciseDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate> {
    //ScrollView
    IBOutlet UIScrollView *scroller;
    //Exercise Information TableView
    IBOutlet UITableView *detailTableView;
    //Instruction Label
    IBOutlet UILabel *instructionLabel;
    //Database
    IBOutlet UIImageView *favouriteImageView;
    sqlite3 * db;
    //Exercise Types
    NSArray *exerciseTypesNames;
    //Array contains titles for exercise tableview information.
    NSArray *tableViewTitles;
    
    //Stores a temporary exercise type for the update.
    NSString *tempExerciseType;
    
    SHExercise *coreDataExercise;

}

- (IBAction)actionSheetPressed:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *closeButton;
- (IBAction)closeButtonTapped:(id)sender;

//Favorites UIBarButton
@property (strong, nonatomic) IBOutlet UIBarButtonItem *likeButton;
//Exercise Image
@property (weak, nonatomic) IBOutlet UIImageView *exerciseImageView;
//Instructions Label
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

//Passed Values
//Exercise Instructions
@property (strong, nonatomic) SHExercise *exerciseToDisplay;
@property (nonatomic, assign) BOOL modalView;
@property (strong, nonatomic) UIImage *exerciseImage;
@property (strong, nonatomic) NSString *viewTitle;


//Action called when favorite button pressed.
- (IBAction)update:(id)sender;


@end
