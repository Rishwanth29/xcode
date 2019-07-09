//
//  DXCSettlementViewController.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 10/10/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCSettlementViewController.h"
#import "DXCNavigationViewController.h"

@interface DXCSettlementViewController ()

@end

@implementation DXCSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnHomeButtonClicked:(UIButton *)sender {
     [(DXCNavigationViewController *)self.navigationController homeButtonClicked];
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
