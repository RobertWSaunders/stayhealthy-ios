//
//  CommonRequests.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-06-20.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import "CommonRequests.h"

@implementation CommonRequests

+ (NSString *) shortAppVersion
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
}

+ (NSString *) appBuild
{
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
}


@end
