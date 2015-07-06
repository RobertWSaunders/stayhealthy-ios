//
//  ExerciseCollectionCell.h
//  StayHealthy
//
//  Created by Student on 3/23/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.

#import <UIKit/UIKit.h>

@interface ExerciseCollectionCell : UICollectionViewCell

//Exercise Name
@property (nonatomic, weak) IBOutlet UILabel *exerciseName;
//Exercise Equipment
@property (nonatomic, weak) IBOutlet UILabel *equipment;
//Exercise Difficulty
@property (nonatomic, weak) IBOutlet UILabel *difficulty;
//Exercise ImageView
@property (nonatomic, weak) IBOutlet UIImageView *exerciseImage;
//Equipment Label
@property (nonatomic, weak) IBOutlet UILabel *equipmentStandards;
//Difficulty Label
@property (nonatomic, weak) IBOutlet UILabel *difficultyStandards;

@end
