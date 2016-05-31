//
//  AddJournalEntryViewController.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-05-21.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BodyViewCollectionViewCell.h"

@interface AddJournalEntryViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource> {
    NSArray *journalEntryOptions;
    NSArray *journalEntryOptionsImages;
    NSIndexPath *selectedIndexPath;
}

@property (weak, nonatomic) IBOutlet UICollectionView *JournalEntryOptionCollectionView;

- (IBAction)closeButtonPressed:(id)sender;

@end
