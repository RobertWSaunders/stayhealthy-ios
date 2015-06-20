//
//  sqlColumns.h
//  StayHealthy
//
//  Created by Student on 12/20/2013.
//  Copyright (c) 2013 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface sqlColumns : NSObject

@property(nonatomic,copy) NSString *ID;
@property(nonatomic,copy) NSString *Name;
@property(nonatomic,copy) NSString *Muscle;
@property(nonatomic,copy) NSString *Description;
@property(nonatomic,copy) NSString *File;
@property(nonatomic,copy) NSString *Sets;
@property(nonatomic,copy) NSString *Reps;
@property(nonatomic,copy) NSString *Equipment;
@property(nonatomic,copy) NSString *PrimaryMuscle;
@property(nonatomic,copy) NSString *SecondaryMuscle;
@property(nonatomic,copy) NSString *Difficulty;
@property(nonatomic,copy) NSString *isFavorite;
@property(nonatomic,copy) NSString *ExerciseType;

@end
