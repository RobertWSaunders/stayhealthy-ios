//
//  advancedOptionsSelect.h
//  StayHealthy
//
//  Created by Robert Saunders on 2015-03-21.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AdvancedOptionsDelegate;

@interface advancedOptionsSelect : UITableViewController <UITableViewDataSource, UITableViewDelegate> {

}
- (IBAction)donePressed:(id)sender;
- (IBAction)cancelPressed:(id)sender;
@property(nonatomic,retain) NSArray *arrayForTableView;
@property (strong, nonatomic) NSString *titleText;
@property (nonatomic, assign) BOOL isExerciseType;
@property (nonatomic, assign) NSInteger num;

@property (assign, nonatomic) id <AdvancedOptionsDelegate>delegate;

@end

@protocol AdvancedOptionsDelegate<NSObject>

@optional

- (void)done:(NSString*)selectedValue num:(NSInteger*)cell;



@end
