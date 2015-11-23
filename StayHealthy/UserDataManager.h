//
//  UserDataManager.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-11-18.
//  Copyright © 2015 Mark Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManagerProtocol.h"
#import "User.h"
#import "SHUser.h"
#import "SHUser+User.h"

@interface UserDataManager : NSObject <DataManagerProtocol>

@property (nonatomic, strong) NSManagedObjectContext  *appContext;

- (NSString*)getUserID;
- (BOOL)userIsCreated;

@end
