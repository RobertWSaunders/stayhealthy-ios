//
//  workoutCell.h
//  StayHealthy
//
//  Created by Student on 3/24/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//


//Our imports.
#import <UIKit/UIKit.h>
//^^^^^^^^Standard UIKit, required.

//^^^^^^^^Our colors.

@interface workoutCell : UICollectionViewCell

//These are what we want in the cell, and their declaration.
@property (nonatomic, weak) IBOutlet UILabel *workoutName;
@property (nonatomic, weak) IBOutlet UILabel *difficulty;
@property (nonatomic, weak) IBOutlet UIImageView *workoutImage;

@end
