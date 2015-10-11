//
//  TableViewContainerViewController.m
//  StayHealthy
//
//  Created by Robert Saunders on 2015-06-20.
//  Copyright (c) 2015 Mark Saunders. All rights reserved.
//

#import "TableViewContainerViewController.h"

@interface TableViewContainerViewController ()

@end

@implementation TableViewContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.websiteLabel.text = WEBSITE;
    self.copyrightOneLabel.text = [NSString stringWithFormat:@"© %@",IOSDEVELOPER];
    self.copyrightTwoLabel.text = [NSString stringWithFormat:@"© %@",ANDROIDDEVELOPER];
    self.versionLabel.text = [NSString stringWithFormat:@"version %@",[CommonUtilities shortAppVersionNumber]];
    self.websiteLabel.font = subtleFont;
    self.copyrightOneLabel.font = subtleFont;
    self.copyrightTwoLabel.font = subtleFont;
    self.versionLabel.font = subtleFont;
    
    self.websiteLabel.textColor = STAYHEALTHY_DARKGRAYCOLOR;
    self.copyrightOneLabel.textColor = STAYHEALTHY_DARKGRAYCOLOR;
    self.copyrightTwoLabel.textColor = STAYHEALTHY_DARKGRAYCOLOR;
    self.versionLabel.textColor = STAYHEALTHY_DARKGRAYCOLOR;
}



@end
