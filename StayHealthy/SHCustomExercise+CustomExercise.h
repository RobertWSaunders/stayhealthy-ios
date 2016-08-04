//
//  SHCustomExercise+CustomExercise.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-29.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "SHCustomExercise.h"
#import "CustomExercise.h"

@interface SHCustomExercise (CustomExercise)

//Creates CustomExercise Record from SHCustomExercise Record
- (void)map:(CustomExercise *)customExercise;

//Creates SHCustomExercise Record from CustomExercise Record
- (void)bind:(CustomExercise *)customExercise;

@end
