//
//  SelectionTableViewCell.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-05-18.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectionTableViewCell : UITableViewCell

//Accessory Image
@property (nonatomic, weak) IBOutlet UIImageView *accessoryImage;
@property (nonatomic, weak) IBOutlet UILabel *label;

@end
