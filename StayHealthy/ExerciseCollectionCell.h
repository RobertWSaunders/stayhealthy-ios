//
//  ExerciseCollectionCell.h
//  StayHealthy
//
//  Created by Student on 3/23/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ExerciseCollectionCell : UICollectionViewCell

//These are what we want in the cell, and their declaration.
@property (nonatomic, weak) IBOutlet UILabel *exerciseName;
@property (nonatomic, weak) IBOutlet UILabel *equipment;
@property (nonatomic, weak) IBOutlet UILabel *difficulty;
@property (nonatomic, weak) IBOutlet UIImageView *exerciseImage;

@end
