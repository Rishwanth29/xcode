//
//  DXCSearchPropertyViewController.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 26/09/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCSearchPropertyViewController.h"
#import "DXCNavigationViewController.h"
#import "DXCSmartContractCancellation.h"
#import "DXCPopupOverlayAnimatedTransitioning.h"

@interface DXCSearchPropertyViewController ()

@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (strong, nonatomic) NSArray *progressViews;
@property (strong, nonatomic) DXCSmartContractCancellation *smartContractViewController;
@property (nonatomic) id<UIViewControllerTransitioningDelegate> transitioningDelegate;

@end

@implementation DXCSearchPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.progressViews=@[self.searchCriteriaImageView,self.searchResultsImageView,self.financingImageView,self.financingImageView,self.auctionImageView,self.settlementImageView];
       _transitioningDelegate = [[DXCPopupOverlayTransitioningDelegate alloc] init];
    __weak DXCSearchPropertyViewController *weakSelf=self;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    self.smartContractViewController = [storyboard instantiateViewControllerWithIdentifier:@"SmartConfirmationViewController"];
    self.smartContractViewController.modalPresentationStyle = UIModalPresentationCustom;
    [self.smartContractViewController setTransitioningDelegate:[self transitioningDelegate]];
    [self.smartContractViewController setProceedConfirm:^(BOOL flag) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        });
    }];
    // Do any additional setup after loading the view.
}
-(void)goBack {
    UITabBarController *progressTabBarController=(UITabBarController *)self.childViewControllers[0];
     progressTabBarController.selectedIndex=progressTabBarController.selectedIndex-1;
    
    ((UIImageView *)self.progressViews[progressTabBarController.selectedIndex+1]).image=[UIImage imageNamed:@"greybar"];
    ((UIImageView *)self.progressViews[progressTabBarController.selectedIndex]).image=[UIImage imageNamed:@"blackbar"];
}
- (IBAction)backButtonClicked:(UIButton *)sender {
    [sender setEnabled:FALSE];
    [self.homeButton setEnabled:FALSE];
    UITabBarController *progressTabBarController=(UITabBarController *)self.childViewControllers[0];
    __weak DXCSearchPropertyViewController *weakSelf=self;
    if (progressTabBarController.selectedIndex>0) {
        if (progressTabBarController.selectedIndex==3) {
            [self.smartContractViewController setProceedConfirm:^(BOOL flag) {
                [weakSelf goBack];
            }];
             [self presentViewController:self.smartContractViewController animated:YES completion:nil];
        } else {
            [self goBack];
        }
        
        
    } else
        [(DXCNavigationViewController *)self.navigationController homeButtonClicked];
    dispatch_async(dispatch_get_main_queue(), ^{
       if (progressTabBarController.selectedIndex<=3) {
        [sender setEnabled:TRUE];
         [self.homeButton setEnabled:TRUE];
       }
    });
}


- (IBAction)homeButtonClicked:(UIButton *)sender {
    UITabBarController *progressTabBarController=(UITabBarController *)self.childViewControllers[0];
    __weak DXCSearchPropertyViewController *weakSelf=self;
     if (progressTabBarController.selectedIndex==3) {
         [self.smartContractViewController setProceedConfirm:^(BOOL flag) {
             [(DXCNavigationViewController *)weakSelf.navigationController homeButtonClicked];
         }];
          [self presentViewController:self.smartContractViewController animated:YES completion:nil];
     } else
    [(DXCNavigationViewController *)self.navigationController homeButtonClicked];
}
- (IBAction)logoutButtonClicked:(UIButton *)sender {
    [(DXCNavigationViewController *)self.navigationController logoutButtonClicked];
}

-(void)viewSearchResults {
    UITabBarController *progressTabBarController=(UITabBarController *)self.childViewControllers[0];
        [progressTabBarController setSelectedIndex:1];
        self.searchCriteriaImageView.image=[UIImage imageNamed:@"greenbar"];
        self.searchResultsImageView.image=[UIImage imageNamed:@"blackbar"];
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
