//
//  BodyViewCollectionViewCell.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-12-31.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import "BodyViewCollectionViewCell.h"

@implementation BodyViewCollectionViewCell


-(void)setSelected:(BOOL)selected{
    
    self.layer.masksToBounds = NO;
    self.layer.borderColor = selected ? BLUE_COLOR.CGColor:LIGHT_GRAY_COLOR.CGColor;
    self.layer.borderWidth = selected ? 0.5f:0.25f;
   self.backgroundColor = selected?WHITE_COLOR:[UIColor whiteColor];
    [super setSelected:selected];
}

@end
