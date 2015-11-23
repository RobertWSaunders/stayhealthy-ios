//
//  User.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-18.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * userID;

@end
