//
//  workoutCell.h
//  StayHealthy
//
//  Created by Student on 3/24/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

/***************************************************HEADER FILE***************************************/
//This file handles the collectionviewcell in the collection view for find a exercise feature.
//Note: Could play around with UI in this, for future versions.

//Our imports.
#import <UIKit/UIKit.h>
//^^^^^^^^Standard UIKit, required.
#import "FlatUIKit.h"
//^^^^^^^^Our colors.

@interface workoutCell : UICollectionViewCell

//These are what we want in the cell, and their declaration.
@property (nonatomic, weak) IBOutlet UILabel *workoutName;
@property (nonatomic, weak) IBOutlet UILabel *difficulty;
@property (nonatomic, weak) IBOutlet UIImageView *workoutImage;

@end
