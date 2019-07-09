//
//  DXCApprovalViewController.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 07/10/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCApprovalViewController.h"
#import "DXCSearchPropertyViewController.h"

@interface DXCApprovalViewController ()



@end

@implementation DXCApprovalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
     
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)joinAuctionButtonClicked:(UIButton *)sender {
    [self.tabBarController setSelectedIndex:4];
    DXCSearchPropertyViewController *searchPropertyViewController=(DXCSearchPropertyViewController *)self.tabBarController.parentViewController;
    searchPropertyViewController.financingImageView.image=[UIImage imageNamed:@"greenbar"];
    searchPropertyViewController.auctionImageView.image=[UIImage imageNamed:@"blackbar"];
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
