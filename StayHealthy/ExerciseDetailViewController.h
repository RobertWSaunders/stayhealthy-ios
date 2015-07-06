//
//  ExerciseDetailViewController.h
//  StayHealthy
//
//  Created by Student on 12/21/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseDetailViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

//Favorites UIBarButton
@property (strong, nonatomic) UIBarButtonItem *favoriteButton;
//Exercise Image
@property (weak, nonatomic) IBOutlet UIImageView *exerciseImageView;
//Instructions Label
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

//Passed Values
//Exercise Instructions
@property (strong, nonatomic) NSString *exerciseInstructions;
//Exercise Name
@property (strong, nonatomic) NSString *exerciseTitle;
//Exercise Reps
@property (strong, nonatomic) NSString *exerciseReps;
//Exercise Sets
@property (strong, nonatomic) NSString *exerciseSets;
//Exericse Equipment
@property (strong, nonatomic) NSString *exerciseEquipment;
//Exercise Difficulty
@property (strong, nonatomic) NSString *exerciseDifficulty;
//Exercise Primary Muslce
@property (strong, nonatomic) NSString *exercisePrimaryMuscle;
//Exercise Secondary Muslce
@property (strong, nonatomic) NSString *exerciseSecondaryMuscle;
//Exercise ID
@property (strong, nonatomic) NSString *exerciseIdentifier;
//Exercise Type
@property (strong, nonatomic) NSString *exerciseType;
//Exercise Image
@property (strong, nonatomic) UIImage *exerciseImage;

//Action called when favorite button pressed.
- (IBAction)update:(id)sender;


@end
