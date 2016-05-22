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
