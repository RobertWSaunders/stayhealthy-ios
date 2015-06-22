//
//  ImprovedExerciseController.h
//  StayHealthy
//
//  Created by Student on 3/23/2014.
//  Copyright (c) 2014 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExerciseDetailViewController.h"
#import "ExerciseCollectionCell.h"

@interface ImprovedExerciseController : UIViewController < UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate> 

//TableView View
@property (weak, nonatomic) IBOutlet UIView *tableViewList;
//CollectionView View
@property (weak, nonatomic) IBOutlet UIView *collectionViewGroup;

//Query which is passed to the view.
@property (strong, nonatomic) NSString *query;
//Title which is passed to the view.
@property (strong, nonatomic) NSString *titleText;

//Exercise Data array.
@property(nonatomic,retain) NSMutableArray *exerciseData;

//Exercise CollectionView
@property (weak, nonatomic) IBOutlet UICollectionView *groupCollection;
//Exercise TableView
@property (weak, nonatomic) IBOutlet UITableView *list;

@end
