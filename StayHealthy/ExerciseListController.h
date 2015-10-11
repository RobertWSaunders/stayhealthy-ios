//
//  ExerciseListController.h
//  StayHealthy
//
//  Created by Student on 3/23/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseDetailViewController.h"
#import "ExerciseCollectionCell.h"
#import "SHDataHandler.h"

@interface ExerciseListController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *exerciseData;
}

//PASSED PROPERTIES
//Query which is passed to the view.
@property (strong, nonatomic) NSString *exerciseQuery;
//Title which is passed to the view.
@property (strong, nonatomic) NSString *viewTitle;


//COLLECTION VIEW AND TABLEVIEW
//Exercise CollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *collectonView;
//Exercise TableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
