//
//  workoutFavoriteObjects.h
//  StayHealthy
//
//  Created by Student on 7/27/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface workoutFavoriteObjects : NSObject

@property(nonatomic,copy) NSString *WorkoutID;
@property(nonatomic,assign) NSInteger TimesCompleted;
@property(nonatomic,copy) NSString *isFavorite;

@end
