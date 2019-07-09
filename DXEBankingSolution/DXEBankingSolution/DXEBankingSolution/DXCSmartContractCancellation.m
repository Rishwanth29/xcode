//
//  DXCHomeConfirmationViewController.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 30/09/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCSmartContractCancellation.h"


@interface DXCSmartContractCancellation ()

@end

@implementation DXCSmartContractCancellation

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
- (IBAction)proceedButtonClicked:(UIButton *)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.proceedConfirm(YES);
    });
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}



@end
