//
//  DXCSearchCriteriaContainerViewController.m
//  DXEBankingSolution
//
//  Created by Anil on 10/09/2018.
//  Copyright © 2018 Mphasis. All rights reserved.
//

#import "DXCSearchCriteriaContainerViewController.h"
#import "DXCSearchCriteriaViewController.h"
#import "DXCSearchPropertyViewController.h"
#import <AIExpert/AIExpert.h>

#define INITIAL_CONVERSION_DICT @{@"initial_conversation":@YES,@"username":@"Fay",@"age":@"30 years old",@"interests":@"beach",@"gender":@"female",@"marital_status":@"single",@"family_members":@1,@"work":@"Adelaide CBD"}

@interface DXCSearchCriteriaContainerViewController () {
    AIExpert *expert;
    DXCSearchCriteriaViewController *searchCriteriaController;
    DXCSearchPropertyViewController *searchPropertyController;
};
@property(weak,nonatomic) IBOutlet UIView *rightContainerView;

@end

@implementation DXCSearchCriteriaContainerViewController
-(void)awakeFromNib {
    expert = [[AIExpert alloc] init];
    expert.initialConversionDict = INITIAL_CONVERSION_DICT;
    [expert setUp];
    [super awakeFromNib];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    searchCriteriaController = (DXCSearchCriteriaViewController *)self.childViewControllers[0];
    searchPropertyController = (DXCSearchPropertyViewController *)self.tabBarController.parentViewController;
    [expert searchResultsController:searchCriteriaController];
    [expert searchPropertyController:searchPropertyController];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
   
    [self addChildViewController:expert.controller];
     [self.rightContainerView addSubview:expert.view];
    expert.view.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint constraintWithItem:expert.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:expert.view.superview attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0].active = true;
    [NSLayoutConstraint constraintWithItem:expert.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:expert.view.superview attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0].active = true;
    [NSLayoutConstraint constraintWithItem:expert.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:expert.view.superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:0].active = true;
    [NSLayoutConstraint constraintWithItem:expert.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:expert.view.superview attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0].active = true;
    [super viewWillAppear:animated];
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
