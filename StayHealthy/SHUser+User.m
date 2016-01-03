//
//  SHUser+t.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-18.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import "SHUser+User.h"

@implementation SHUser (User)

- (void)map:(User *)user {
    SHUser *SHuser = self;
    [user setValue:SHuser.email forKey:@"email"];
    [user setValue:SHuser.firstName forKey:@"firstName"];
    [user setValue:SHuser.lastName forKey:@"lastName"];
    [user setValue:SHuser.userID forKey:@"userID"];
}

- (void)bind:(User *)user {
    SHUser *SHUser = self;
    SHUser.firstName = user.firstName;
    SHUser.lastName = user.lastName;
    SHUser.email = user.email;
    SHUser.userID = user.userID;
}


@end
