//
//  SHUser+t.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-18.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import "SHUser.h"
#import "User.h"

@interface SHUser (User)

- (void)map:(User *)user;
- (void)bind:(User *)user;

@end
