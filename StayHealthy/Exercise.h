//
//  Exercise.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-08-08.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Exercise : NSManagedObject

@property (nonatomic, retain) NSString * exerciseID;
@property (nonatomic, retain) NSString * exerciseType;
@property (nonatomic, retain) NSNumber * liked;
@property (nonatomic, retain) NSDate * lastViewed;
@property (nonatomic, retain) NSNumber *timesViewed;

@end
