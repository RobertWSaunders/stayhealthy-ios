//
//  ExerciseCollectionCell.h
//  StayHealthy
//
//  Created by Student on 3/23/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//

/***************************************************HEADER FILE***************************************/
//This file handles the collectionviewcell in the collection view for find a exercise feature.
//Note: Could play around with UI in this, for future versions.

//Our imports.
#import <UIKit/UIKit.h>
//^^^^^^^^Standard UIKit, required.

//^^^^^^^^Our colors.


@interface ExerciseCollectionCell : UICollectionViewCell

//These are what we want in the cell, and their declaration.
@property (nonatomic, weak) IBOutlet UILabel *exerciseName;
@property (nonatomic, weak) IBOutlet UILabel *equipment;
@property (nonatomic, weak) IBOutlet UILabel *difficulty;
@property (nonatomic, weak) IBOutlet UIImageView *exerciseImage;

@end
