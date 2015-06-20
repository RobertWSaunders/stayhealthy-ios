//
//  PopupViewController.m
//  StayHealthy
//
//  Created by Student on 4/18/2014.
//  Copyright (c) 2014 Mark Saunders. All rights reserved.
//

#import "PopupViewController.h"

@interface PopupViewController ()

@end

@implementation PopupViewController

@synthesize delegate;

@synthesize exerciseImage,descriptionLabel,repsText,secText,priText,difficultyText,text,title,title1,reps,sets,material,difficulty,pri,sec,materialsText,setsText,titleLabel,favoriteButton,exerciseType,ident,checkIfFavorite;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(300, 735)];
    
    titleLabel.text = self.title1;
    exerciseImage.image = self.image;
    descriptionLabel.text = self.text;
    repsText.text = self.reps;
    setsText.text = self.sets;
    materialsText.text = self.material;
    difficultyText.text = self.difficulty;
    priText.text = self.pri;
    secText.text = self.sec;
    
    [self performFavoriteSearch:exerciseType exerciseID:ident];
    
    if (checkIfFavorite.count > 0)
        [favoriteButton setImage:[UIImage imageNamed:@"Star-50C.png"] forState:UIControlStateNormal];
    else
        [favoriteButton setImage:[UIImage imageNamed:@"Star Filled-50C.png"] forState:UIControlStateNormal];
    
    if ([difficultyText.text isEqualToString:@"Easy"]) {
        difficultyText.textColor = [UIColor emerlandColor];
    }
    if ([difficultyText.text isEqualToString:@"Intermediate"]) {
        difficultyText.textColor = [UIColor belizeHoleColor];
    }
    if ([difficultyText.text isEqualToString:@"Hard"]) {
        difficultyText.textColor = [UIColor alizarinColor];
    }
    if ([difficultyText.text isEqualToString:@"Very Hard"]) {
        difficultyText.textColor = [UIColor alizarinColor];
    }
    
    if ([materialsText.text isEqualToString:@"Very Hard"]) {
        difficultyText.textColor = [UIColor alizarinColor];
    }
    
    NSString *string = materialsText.text;
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    if ([trimmedString isEqualToString:@"null"]) {
        materialsText.text = @"No Equipment";
    }
    NSString *string1 = secText.text;
    NSString *trimmedString1 = [string1 stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
    if ([trimmedString1 isEqualToString:@"null"]) {
        secText.text = @"No Secondary Muscle";
    }
    
    //Fetching all the arrays data from the findExercise.plist
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"findExercise" ofType:@"plist"];
    NSDictionary *findExerciseData = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    exerciseTypes = findExerciseData[@"exerciseTypes"];
    tableViewTitles = @[@"Sets",@"Reps",@"Primary Muscle",@"Secondary Muscle",@"Equipment",@"Difficulty"];


}
//Change the exercise type to something that is readable.
-(void)changeToReadable {
    if ([self.exerciseType isEqualToString:@"strength"])
        self.stretchingRefined = exerciseTypes[0];
    else if ([self.exerciseType isEqualToString:@"stretching"])
        self.stretchingRefined = exerciseTypes[1];
    else if ([self.exerciseType isEqualToString:@"warmup"])
        self.stretchingRefined = exerciseTypes[2];
}


- (IBAction)doneButton:(id)sender {
    [self dismissPopupViewControllerWithanimationType:MJPopupViewAnimationFade];
    [self.delegate cancelButtonClicked:self];
    
}

- (IBAction)favorite:(id)sender {
    [self changeImage];
    [self changeToReadable];
     NSInteger exerciseID = [ident intValue];
    if ([favoriteButton.imageView.image isEqual:[UIImage imageNamed:@"starColoredline"]])
        [CommonDataOperations performInsertQuery:[NSString stringWithFormat:@"DELETE FROM FavoriteExercises WHERE ExerciseID = '%ld' AND ExerciseType = '%@'",(long)exerciseID,self.stretchingRefined] databaseName:@"UserDB1.sqlite" database:db];
    else
        [CommonDataOperations performInsertQuery:[NSString stringWithFormat:@"INSERT INTO FavoriteExercises ('ExerciseID','ExerciseType') VALUES ('%ld','%@')",(long)exerciseID,self.stretchingRefined] databaseName:@"UserDB1.sqlite" database:db];
}

//Changes the favorites image dependant on if its a favorite or not.
-(void)changeImage {
    if ([favoriteButton.imageView.image isEqual:[UIImage imageNamed:@"starColored"]])
        [favoriteButton setImage:[UIImage imageNamed:@"starColoredline"] forState:UIControlStateNormal];
    else if ([favoriteButton.imageView.image isEqual:[UIImage imageNamed:@"starColoredline"]])
        [favoriteButton setImage:[UIImage imageNamed:@"starColored"] forState:UIControlStateNormal];
}

-(void)performFavoriteSearch:(NSString*)exerciseType1 exerciseID:(NSString*)ID {
    NSString *query;
    NSString *type;
    if ([exerciseType1 isEqualToString:@"strength"])
        type = @"strengthexercises";
    else if ([exerciseType1 isEqualToString:@"warmup"])
        type = @"warmup";
    else if ([exerciseType1 isEqualToString:@"stretching"])
        type = @"stretchingexercises";
    query = [NSString stringWithFormat:@"SELECT * FROM FavoriteExercises WHERE ExerciseID = '%@' AND ExerciseType = '%@'",ID,type];
    checkIfFavorite = [CommonDataOperations checkIfExerciseIsFavorite:query databaseName:@"UserDB1.sqlite" database:db];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55.0f;
}

//Design and fill the tableview cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *muscleItem = @"detailItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:muscleItem];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:muscleItem];
    }
    
    cell.textLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.0f];
    cell.textLabel.textColor = [UIColor peterRiverColor];
    cell.detailTextLabel.textColor = [UIColor lightGrayColor];
    cell.detailTextLabel.font = [UIFont fontWithName:@"Avenir-Light" size:16.0f];
    cell.textLabel.text = [tableViewTitles objectAtIndex:indexPath.row];
    
    [cell setUserInteractionEnabled:NO];
    
    //Sets
    if (indexPath.row == 0) {
        cell.detailTextLabel.text = self.sets;
    }
    //Reps
    if (indexPath.row == 1) {
        cell.detailTextLabel.text = self.reps;
    }
    //Primary Muscle
    if (indexPath.row == 2) {
        cell.detailTextLabel.text = self.pri;
    }
    //Secondary Muscle
    if (indexPath.row == 3) {
        NSString *trimmedStrings2 = [self.sec stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([trimmedStrings2 isEqualToString:@"null"]) {
            self.sec = @"No Secondary Muscle";
        }
        cell.detailTextLabel.text = self.sec;
    }
    //Equipment
    if (indexPath.row == 4) {
        NSString *trimmedString = [self.material stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceCharacterSet]];
        if ([trimmedString isEqualToString:@"null"]) {
            self.material = @"No Equipment";
        }
        cell.detailTextLabel.text = self.material;
    }
    //Difficulty
    if (indexPath.row == 5) {
        cell.detailTextLabel.text = self.difficulty;
        if ([self.difficulty isEqualToString:@"Easy"])
            cell.detailTextLabel.textColor = [UIColor emerlandColor];
        if ([self.difficulty isEqualToString:@"Intermediate"])
            cell.detailTextLabel.textColor = [UIColor belizeHoleColor];
        if ([self.difficulty isEqualToString:@"Hard"])
            cell.detailTextLabel.textColor = [UIColor alizarinColor];
        if ([self.difficulty isEqualToString:@"Very Hard"])
            cell.detailTextLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
    
}



@end
