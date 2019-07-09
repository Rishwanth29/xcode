//
//  DXCNavigationViewController.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 30/09/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCNavigationViewController.h"
#import "DXCPopupOverlayAnimatedTransitioning.h"
#import "DXCHomeConfirmationViewController.h"

#import "DXCLogoutViewController.h"


@interface DXCNavigationViewController ()
@property (strong, nonatomic) DXCHomeConfirmationViewController *homeConfirmViewController;

@property (strong, nonatomic) DXCLogoutViewController *logoutConfirmViewController;
@property (nonatomic) id<UIViewControllerTransitioningDelegate> transitioningDelegate;
@end

@implementation DXCNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    _transitioningDelegate = [[DXCPopupOverlayTransitioningDelegate alloc] init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    self.homeConfirmViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeConfirmationViewController"];
    self.homeConfirmViewController.modalPresentationStyle = UIModalPresentationCustom;
    [self.homeConfirmViewController setTransitioningDelegate:[self transitioningDelegate]];
    __weak DXCNavigationViewController *weakSelf=self;
    [self.homeConfirmViewController setReturnHomeConfirmation:^(BOOL flag) {
        dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf popViewControllerAnimated:YES];
            });
    }];
    
    
    
    
    self.logoutConfirmViewController = [storyboard instantiateViewControllerWithIdentifier:@"LogoutViewController"];
    self.logoutConfirmViewController.modalPresentationStyle = UIModalPresentationCustom;
    [self.logoutConfirmViewController setTransitioningDelegate:[self transitioningDelegate]];
    [self.logoutConfirmViewController setLogoutConfirmation:^(BOOL flag) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                
            }];
        });
        
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)homeButtonClicked {
    [self presentViewController:self.homeConfirmViewController animated:YES completion:nil];
}
- (void)logoutButtonClicked {
    [self presentViewController:self.logoutConfirmViewController animated:YES completion:nil];
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
