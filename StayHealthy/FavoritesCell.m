//
//  FavoritesCell.m
//  StayHealthy
//
//  Created by Student on 1/20/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//

/***************************************************IMPLEMENTATION FILE***************************************/
//This handles the selection of the cell.

#import "FavoritesCell.h"
//^^^^^^^Implementation of the header file.

//Start of implementation.
@implementation FavoritesCell

//This is the boolean method that checks whether the cell is selected or not, if it is it will give it a blue border.
-(void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
    
    if (selected) {
        self.contentView.layer.borderColor = STAYHEALTHY_BLUE.CGColor;
        self.contentView.layer.borderWidth = 1;
    } else {
        self.contentView.layer.borderWidth = 0;
    }
}
//End of file.
@end
