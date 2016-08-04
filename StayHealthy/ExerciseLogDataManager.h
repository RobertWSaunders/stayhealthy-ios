//
//  ExerciseLogDataManager.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-29.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExerciseLog.h"
#import "SHExerciseLog.h"
#import "SHExerciseLog+ExerciseLog.h"
#import "DataManagerProtocol.h"

@interface ExerciseLogDataManager : NSObject <DataManagerProtocol>

//Define the app context for the data manager to call to.
@property (nonatomic, strong) NSManagedObjectContext  *appContext;

@end
