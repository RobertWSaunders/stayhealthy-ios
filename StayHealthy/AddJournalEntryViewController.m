//
//  AddJournalEntryViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2016-05-21.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "AddJournalEntryViewController.h"

@interface AddJournalEntryViewController ()

@end

@implementation AddJournalEntryViewController

/**********************************/
#pragma mark - View Loading Methods
/**********************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set the title for the view controller.
    self.title = @"Add Journal Entry";
    
    //Fill the journal entry options array.
    journalEntryOptions = @[@"Exercise Log",@"Workout Log"];
    //Fill the journal entry options images array.
    journalEntryOptionsImages = @[@"ExerciseLog.png",@"WorkoutLog.png"];
    
    //Don't adjust scroll view insets, adds weird gap to views.
    self.automaticallyAdjustsScrollViewInsets = NO;
    //Set the collectionview to not scroll if space.
    self.JournalEntryOptionCollectionView.alwaysBounceVertical = NO;
}

/**************************************************************/
#pragma mark - UICollectionView Delegate and Datasource Methods
/**************************************************************/

//Returns the number of sections that should be displayed in the tableView.
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//Returns the number of rows in a section that should be displayed in the tableView.
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [journalEntryOptions count];
}

//Configures the cells at a specific indexPath.
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

        BodyViewCollectionViewCell *cell = (BodyViewCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
        [CommonSetUpOperations styleCollectionViewCellBodyZone:cell];
    
        cell.bodyZoneLabel.text = [journalEntryOptions objectAtIndex:indexPath.row];
    
        cell.bodyZoneImage.image = [UIImage imageNamed:[journalEntryOptionsImages objectAtIndex:indexPath.row]];
        cell.bodyZoneLabel.textColor = JOURNAL_COLOR;
        
        return cell;
}

//--------------------------------------------------
#pragma mark Collection View Cell Selection Handling
//--------------------------------------------------

//What happens when the user selects a cell in the tableView.
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    selectedIndexPath = indexPath;

    if (indexPath.item == 0) {
            [self performSegueWithIdentifier:@"ExerciseLog" sender:nil];
    }
    else {
            [self performSegueWithIdentifier:@"WorkoutLog" sender:nil];
        }

    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

//-------------------------------------------
#pragma mark Collection Layout Configuration
//-------------------------------------------

//Controls the size of the collection view cells for different phones.
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
        if (IS_IPHONE_6P) {
            return CGSizeMake(207.f, 207.f);
        }
        else if (IS_IPHONE_6) {
            return CGSizeMake(187.5f, 187.5f);
        }
        else {
            return CGSizeMake(160.f, 160.f);
        }
}

/**********************/
#pragma mark - Actions
/**********************/

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
