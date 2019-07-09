//
//  DXCWelcomeViewController.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 26/09/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCWelcomeViewController.h"
#import "DXCNavigationViewController.h"

@interface DXCWelcomeViewController ()

@end

@implementation DXCWelcomeViewController
-(void)awakeFromNib {
    [super awakeFromNib];
    self.navigationController.navigationBar.hidden=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)logoutButtonClicked:(UIButton *)sender {
    [(DXCNavigationViewController *)self.navigationController logoutButtonClicked];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
