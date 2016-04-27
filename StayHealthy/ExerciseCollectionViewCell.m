//
//  ExerciseCollectionViewCell.m
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-17.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "ExerciseCollectionViewCell.h"

@implementation ExerciseCollectionViewCell


-(void)setSelected:(BOOL)selected{
    
    self.layer.masksToBounds = NO;
    self.backgroundColor = selected?WHITE_COLOR:[UIColor whiteColor];
    [super setSelected:selected];
}
-(void)setHighlighted:(BOOL)highlighted {
    self.layer.masksToBounds = NO;
    self.backgroundColor = highlighted?WHITE_COLOR:[UIColor whiteColor];
    [super setHighlighted:highlighted];
    
}
@end
