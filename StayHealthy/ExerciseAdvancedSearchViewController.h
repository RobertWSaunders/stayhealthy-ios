//
//  ExerciseAdvancedSearchViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-07-05.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "advancedOptionsSelect.h"

@interface ExerciseAdvancedSearchViewController : UIViewController <AdvancedOptionsDelegate> {
    //Array filled with the advanced search options.
    NSArray *exerciseAdvancedSearchOptions;
    //Array filled with the advanced search options defaults.
    NSArray *exerciseAdvancedSearchOptionsDefaults;
    
    NSMutableArray *primaryMuscles;
    NSMutableArray *secondaryMuscles;
    NSMutableArray *equipmentList;
    NSMutableArray *difficultyList;
    
    
    NSMutableArray *selectedTypes;
    NSMutableArray *selectedColumns;
    NSMutableArray *selectedValues;
    
    
    NSString *primaryText;
    NSString *secondaryText;
    NSString *difficultyText;
    NSString *equipmentText;
    NSString *searchQuery;
    NSString *searchName;
    
}

@end
