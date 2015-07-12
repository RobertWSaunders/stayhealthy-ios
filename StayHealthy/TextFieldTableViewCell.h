//
//  TextFieldTableViewCell.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-07-06.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldTableViewCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UILabel *cellLabel;
@property (nonatomic, weak) IBOutlet UITextField *textField;


@end
