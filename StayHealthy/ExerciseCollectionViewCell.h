//
//  ExerciseCollectionViewCell.h
//  StayHealthy
//
//  Created by Robert Saunders on 2016-04-17.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExerciseCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *exerciseName;
@property (nonatomic, weak) IBOutlet UILabel *exerciseDifficultyLabel;
@property (nonatomic, weak) IBOutlet UILabel *exerciseEquipmentLabel;
@property (nonatomic, weak) IBOutlet UIImageView *exerciseImage;
@property (nonatomic, weak) IBOutlet UIImageView *likedImage;
@property (nonatomic, weak) IBOutlet UIImageView *selectedImage;


@end
