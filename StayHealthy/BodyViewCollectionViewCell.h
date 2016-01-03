//
//  BodyViewCollectionViewCell.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-12-31.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BodyViewCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *bodyZoneLabel;
@property (nonatomic, weak) IBOutlet UILabel *bodyZoneMuscleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *bodyZoneImage;

@end
