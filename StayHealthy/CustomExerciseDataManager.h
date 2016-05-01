//
//  CustomExerciseDataManager.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-19.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomExercise.h"
#import "SHCustomExercise.h"
#import "SHCustomExercise+CustomExercise.h"
#import "DataManagerProtocol.h"

@interface CustomExerciseDataManager : NSObject <DataManagerProtocol>

//Define the app context for the data manager to call to.
@property (nonatomic, strong) NSManagedObjectContext  *appContext;

@end
