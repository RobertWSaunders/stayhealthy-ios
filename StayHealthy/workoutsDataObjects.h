//
//  workoutsDataObjects.h
//  StayHealthy
//
//  Created by Student on 3/25/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface workoutsDataObjects : NSObject

@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *summary;
@property(nonatomic,copy) NSString *targetMuscles;
@property(nonatomic,copy) NSString *Sports;
@property(nonatomic,copy) NSString *exerciseIDs;
@property(nonatomic,copy) NSString *exerciseTypes;
@property(nonatomic,copy) NSString *workoutType;
@property(nonatomic,copy) NSString *gender;
@property(nonatomic,copy) NSString *Difficulty;
@property(nonatomic,copy) NSString *equipment;

@end
