//
//  AnalysisCell.h
//  StayHealthy
//
//  Created by Student on 4/7/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+FlatUI.h"

@interface AnalysisCell : UICollectionViewCell


@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *equipmentLabel;
@property (nonatomic, weak) IBOutlet UIImageView *exerciseImage;

@end
