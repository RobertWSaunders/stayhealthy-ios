//
//  PopupViewController.h
//  StayHealthy
//
//  Created by Student on 4/18/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+MJPopupViewController.h"


@protocol MJSecondPopupDelegate;

@interface PopupViewController : UIViewController {
    IBOutlet UIScrollView *scroller;
    NSMutableArray *checkIfFavorite;
    sqlite3 * db;
    //^^^^^^^^^^The database.
    NSArray *tableViewTitles;
    NSArray *exerciseTypes;
}
@property (weak, nonatomic) IBOutlet UITableView *infoTableView;

@property(nonatomic,retain) NSMutableArray *checkIfFavorite;

-(NSMutableArray *) checkIfFavorite;

- (IBAction)doneButton:(id)sender;
@property (strong, nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *exerciseImage;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *repsText;
@property (weak, nonatomic) IBOutlet UILabel *setsText;
@property (weak, nonatomic) IBOutlet UILabel *materialsText;
@property (weak, nonatomic) IBOutlet UILabel *difficultyText;
@property (weak, nonatomic) IBOutlet UILabel *priText;
@property (weak, nonatomic) IBOutlet UILabel *secText;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *title1;
@property (strong, nonatomic) NSString *reps;
@property (strong, nonatomic) NSString *sets;
@property (strong, nonatomic) NSString *material;
@property (strong, nonatomic) NSString *difficulty;
@property (strong, nonatomic) NSString *pri;
@property (strong, nonatomic) NSString *sec;
@property (strong, nonatomic) NSString *ident;
@property (strong, nonatomic) NSString *exerciseType;
@property (strong, nonatomic) NSString *stretchingRefined;
- (IBAction)favorite:(id)sender;

@property (assign, nonatomic) id <MJSecondPopupDelegate>delegate;

@end

@protocol MJSecondPopupDelegate<NSObject>
@optional
- (void)cancelButtonClicked:(PopupViewController*)secondDetailViewController;

@end