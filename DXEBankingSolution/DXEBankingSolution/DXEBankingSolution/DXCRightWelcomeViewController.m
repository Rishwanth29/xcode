//
//  DXCRightWelcomeViewController.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 26/09/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCRightWelcomeViewController.h"

@interface DXCRightWelcomeViewController ()

@end

@implementation DXCRightWelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)searchPropertyButtonClicked:(UIButton *)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *searchPropertyViewController=[storyboard instantiateViewControllerWithIdentifier:@"SearchPropertyViewController"];
    [self.navigationController pushViewController:searchPropertyViewController animated:YES];
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
