//
//  ExerciseDetailViewController.h
//  StayHealthy
//
//  Created by Student on 12/21/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
//

/***************************************************HEADER FILE***************************************/
//Make sure to always have all imports in here.

#import <UIKit/UIKit.h>
//^^^^^^^^Standard UIKit
#import <sqlite3.h>
//^^^^^^^^The sqlite import.
#import "FlatUIKit.h"
//^^^^^^^^Our FlatUI Colors.
//^^^^^^^^The swipe out menu.
#define IPHONE5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
//^^^^^^^^Defines the size of iPhone 5 Screen, for if statements.
#import "sqlColumns.h"
//^^^^^^^^Our database objects.
#import "favoriteColumns.h"
//^^^^^^^^Our database objects.
#import "CommonDataOperations.h"
#import "CommonSetUpOperations.h"


@interface ExerciseDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    IBOutlet UIScrollView *scroller;
    //^^^^^^^^^^The scroller for the page, allows us to see more information.
    IBOutlet UITableView *detailTableView;
    
    __weak IBOutlet UILabel *instructionLabel;
    sqlite3 * db;
    //^^^^^^^^^^The database.
    
    NSArray *exerciseTypes;
    //^^^^^^^^^^Exercise types array, from plist.
    
    NSArray *tableViewTitles;
    
    NSArray *dailyActivityArray;
    
    NSMutableArray *checkIfFavorites;
}

//The favorites uibarbutton item.
@property (strong, nonatomic) UIBarButtonItem *favoriteButton;

//The exercise image.
@property (weak, nonatomic) IBOutlet UIImageView *exerciseImage;

//The labels in the view, represent the data.
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *isFavorite;
@property (weak, nonatomic) IBOutlet UILabel *repsText;
@property (weak, nonatomic) IBOutlet UILabel *setsText;
@property (weak, nonatomic) IBOutlet UILabel *materialsText;
@property (weak, nonatomic) IBOutlet UILabel *difficultyText;
@property (weak, nonatomic) IBOutlet UILabel *priText;
@property (weak, nonatomic) IBOutlet UILabel *secText;

//The strings for the labels.
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *title1;
@property (strong, nonatomic) NSString *reps;
@property (strong, nonatomic) NSString *sets;
@property (strong, nonatomic) NSString *material;
@property (strong, nonatomic) NSString *difficulty;
@property (strong, nonatomic) NSString *pri;
@property (strong, nonatomic) NSString *sec;
@property (strong, nonatomic) NSString *ident;
@property (strong, nonatomic) NSString *favorite;

//The image for the imageview.
@property (strong, nonatomic) UIImage *image;

//THe views name.
@property (weak, nonatomic) IBOutlet UIView *detailView;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) NSString *exerciseType;
@property (strong, nonatomic) NSString *stretchingRefined;
@property (strong, nonatomic) NSString *table;

//The update method is called when the favorite star is pressed.
- (IBAction)update:(id)sender;


@end
