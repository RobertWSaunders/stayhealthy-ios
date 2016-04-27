//
//  ExerciseCreateViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2016-01-17.
//  Copyright © 2016 Robert Saunders. All rights reserved.
//

#import "ExerciseCreateViewController.h"

@interface ExerciseCreateViewController ()

@end

@implementation ExerciseCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
