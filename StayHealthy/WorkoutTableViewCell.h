//
//  WorkoutTableViewCell.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-22.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkoutTableViewCell : UITableViewCell

//Workout Name
@property (nonatomic, weak) IBOutlet UILabel *workoutName;
//Workout Equipment
@property (nonatomic, weak) IBOutlet UILabel *workoutType;
//Workout Difficulty
@property (nonatomic, weak) IBOutlet UILabel *workoutDifficulty;
//Workout Exercises
@property (nonatomic, weak) IBOutlet UILabel *workoutExercises;
//Workout ImageView
@property (nonatomic, weak) IBOutlet UIImageView *workoutImage;
//Like Workout ImageView
@property (nonatomic, weak) IBOutlet UIImageView *likeWorkoutImage;

//Constant Labels
//Equipment Label
@property (nonatomic, weak) IBOutlet UILabel *typeStandards;
//Difficulty Label
@property (nonatomic, weak) IBOutlet UILabel *difficultyStandards;
//Exercises Label
@property (nonatomic, weak) IBOutlet UILabel *exercisesStandards;

@end
