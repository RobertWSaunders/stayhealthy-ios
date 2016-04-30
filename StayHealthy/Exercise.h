//
//  Exercise.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-08.
//  Copyright (c) 2015 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Exercise : NSManagedObject

//Exercise Identifier
@property(nonatomic,retain) NSString *exerciseIdentifier;
//Exercise Name
@property(nonatomic,retain) NSString *exerciseName;
//Exercise Name
@property(nonatomic,retain) NSString *exerciseShortName;
//Exercise Instructions
@property(nonatomic,retain) NSString *exerciseInstructions;
//Exercise Image File
@property(nonatomic,retain) NSString *exerciseImageFile;
//Exercise Sets
@property(nonatomic,retain) NSString *exerciseSets;
//Exercise Reps
@property(nonatomic,retain) NSString *exerciseReps;
//Exercise Equipment
@property(nonatomic,retain) NSString *exerciseEquipment;
//Exercise Primary Muscle
@property(nonatomic,retain) NSString *exercisePrimaryMuscle;
//Exercise SecondaryMuscle
@property(nonatomic,retain) NSString *exerciseSecondaryMuscle;
//Exercise Difficulty
@property(nonatomic,retain) NSString *exerciseDifficulty;
//Exercise Type
@property(nonatomic,retain) NSString *exerciseType;
//Exercise Mechanics Type
@property(nonatomic,retain) NSString *exerciseMechanicsType;
//Exercise Force Type
@property(nonatomic,retain) NSString *exerciseForceType;
//Exercise Different Variations Exercise Identifiers
@property(nonatomic,retain) NSString *exerciseDifferentVariationsExerciseIdentifiers;
//Exercise Liked
@property (nonatomic, retain) NSNumber *exerciseLiked;
//Exercise Last Viewed
@property (nonatomic, retain) NSDate *exerciseLastViewed;
//Exercise Edited Date
@property (nonatomic, retain) NSDate *exerciseEditedDate;
//Exercise Times Viewed
@property (nonatomic, retain) NSNumber *exerciseTimesViewed;
//Exercise isEdited
@property (nonatomic, retain) NSNumber *exerciseIsEdited;

@end
