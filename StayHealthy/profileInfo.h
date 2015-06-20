//
//  profileInfo.h
//  StayHealthy
//
//  Created by Student on 2/19/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface profileInfo : NSObject

@property(nonatomic,assign) NSInteger ID;
@property(nonatomic,copy) NSString *Name;
@property(nonatomic,assign) NSInteger Weight;
@property(nonatomic,assign) NSInteger Height;
@property(nonatomic,copy) NSString *Birthday;
@property(nonatomic,copy) NSString *Gender;
@property(nonatomic,copy) NSString *Bio;
@property(nonatomic,copy) NSString *UserFacebookID;
@property(nonatomic,copy) NSString *sport;
@property(nonatomic,copy) NSString *focus;


@end
