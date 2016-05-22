//
//  SelectionViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-05-18.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectionTableViewCell.h"

@interface SelectionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

//Selection TableView
@property (weak, nonatomic) IBOutlet UITableView *selectionTableView;

//Array that is passed to the view controller to display.
@property(strong,retain) NSArray *selectionArray;
//Array that holds the information regarding which items the user has selected.
@property(strong,retain) NSMutableArray *selectedItems;
//Title text which is passed to the view controller to display.
@property (strong, nonatomic) NSString *titleText;
//Trigger to set selection controller to allow for multiple selection.
@property (nonatomic, assign) BOOL multipleSelectionMode;
//Trigger to set the view to only a user to read the list.
@property (nonatomic, assign) BOOL readOnlyMode;
//The module that the view should be rendered.
@property (nonatomic, assign) modules moduleRender;

//Index path of the cell pressed to get to this view controller.
@property (retain,strong) NSIndexPath *selectedIndexPath;

//Selection Delegate
@property (assign, nonatomic) id <SelectionDelegate> selectionDelegate;

@end
