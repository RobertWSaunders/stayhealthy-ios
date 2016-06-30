//
//  ExerciseSetLogDataManager.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-06-25.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExerciseSetLog.h"
#import "SHExerciseSetLog.h"
#import "SHExerciseSetLog+ExerciseSetLog.h"
#import "DataManagerProtocol.h"

@interface ExerciseSetLogDataManager : NSObject <DataManagerProtocol>

//Define the app context for the data manager to call to.
@property (nonatomic, strong) NSManagedObjectContext  *appContext;

@end
