//
//  ExerciseDetailViewController.h
//  StayHealthy
//
//  Created by Student on 12/21/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> 
//The favorites uibarbutton item.
@property (strong, nonatomic) UIBarButtonItem *favoriteButton;

//The exercise image.
@property (weak, nonatomic) IBOutlet UIImageView *exerciseImage;

//The labels in the view, represent the data.
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


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
@property (strong, nonatomic) NSString *exerciseType;


//The image for the imageview.
@property (strong, nonatomic) UIImage *image;




//The update method is called when the favorite star is pressed.
- (IBAction)update:(id)sender;


@end
