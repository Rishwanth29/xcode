//
//  DXCLogoutViewController.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 30/09/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCLogoutViewController.h"

@interface DXCLogoutViewController ()

@end

@implementation DXCLogoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButtonClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (IBAction)logoutConfirmationButtonClicked:(UIButton *)sender {
     self.logoutConfirmation(YES);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
