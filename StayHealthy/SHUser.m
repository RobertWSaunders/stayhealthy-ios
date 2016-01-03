//
//  SHUser.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-18.
//  Copyright © 2015 Robert Saunders. All rights reserved.
//

#import "SHUser.h"

@implementation SHUser

- (id) initWithDefaults
{
    self = [super init];
    
    if (self)
    {
        self.firstName = @"";
        self.lastName = @"";
        self.email = @"";
        self.userID = [CommonUtilities returnUniqueID];
    }
    
    return self;
}

@end
