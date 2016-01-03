//
//  SHUser.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-18.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHUser : NSObject

@property(nonatomic,copy) NSString *email;
@property(nonatomic,copy) NSString *firstName;
@property(nonatomic,copy) NSString *lastName;
@property(nonatomic,copy) NSString *userID;

- (id) initWithDefaults;

@end
