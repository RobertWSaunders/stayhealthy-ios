//
//  ExerciseTableViewCell.h
//  
//
//  Created by Robert Saunders on 2015-07-13.
//
//

#import <UIKit/UIKit.h>
#import "MGSwipeTableCell.h"
#import "MGSwipeButton.h"

@interface ExerciseTableViewCell : MGSwipeTableCell


//Exercise Name
@property (nonatomic, weak) IBOutlet UILabel *exerciseName;
//Exercise Equipment
@property (nonatomic, weak) IBOutlet UILabel *equipment;
//Exercise Difficulty
@property (nonatomic, weak) IBOutlet UILabel *difficulty;
//Exercise ImageView
@property (nonatomic, weak) IBOutlet UIImageView *exerciseImage;
//Like Exercise ImageView
@property (nonatomic, weak) IBOutlet UIImageView *likeExerciseImage;

//Constant Labels
//Equipment Label
@property (nonatomic, weak) IBOutlet UILabel *equipmentStandards;
//Difficulty Label
@property (nonatomic, weak) IBOutlet UILabel *difficultyStandards;


@end
