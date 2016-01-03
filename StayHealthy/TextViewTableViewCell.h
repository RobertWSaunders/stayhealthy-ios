//
//  TextViewTableViewCell.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-12-26.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewTableViewCell : UITableViewCell <UITextViewDelegate>

@property (nonatomic, weak) IBOutlet UITextView *textView;

@end
