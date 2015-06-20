//
//  FavoritesCell.h
//  StayHealthy
//
//  Created by Student on 1/20/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//

/***************************************************HEADER FILE***************************************/
//This file handles the collectionviewcell in the collection view for find the favorites.
//Note: Could play around with UI in this, for future versions.

//Our imports.
#import <UIKit/UIKit.h>
//^^^^^^^^The standard UIKit
#import "UIColor+FlatUI.h"
//^^^^^^^^Our colors.

//@interface implementation.
@interface FavoritesCell : UICollectionViewCell

//The UI for the cell
//Our labels.
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *difficultyLabel;
@property (nonatomic, weak) IBOutlet UILabel *equipmentLabel;
//The image.
@property (nonatomic, weak) IBOutlet UIImageView *exerciseImage;

@end
