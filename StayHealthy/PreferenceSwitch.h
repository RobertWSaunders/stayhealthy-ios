//
//  PreferenceSwitch.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-05-13.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PreferenceSwitch : UISwitch

//Preference key that is being set.
@property (strong, nonatomic) NSString *preferenceKey;

@end
