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
    self.backgroundColor = selected?LIGHT_GRAY_COLOR:[UIColor whiteColor];
    [super setSelected:selected];
}

-(void)setHighlighted:(BOOL)highlighted {
    self.layer.masksToBounds = NO;
    self.backgroundColor = highlighted?LIGHT_GRAY_COLOR:[UIColor whiteColor];
    [super setHighlighted:highlighted];
    
}
@end
