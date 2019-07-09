//
//  DXCSearchPropertyViewController.h
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 26/09/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AIExpert/AIExpert.h>

@interface DXCSearchPropertyViewController : UIViewController<AIChatSearchResultsViewProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *searchCriteriaImageView;
@property (weak, nonatomic) IBOutlet UIImageView *searchResultsImageView;
@property (weak, nonatomic) IBOutlet UIImageView *financingImageView;
@property (weak, nonatomic) IBOutlet UIImageView *auctionImageView;
@property (weak, nonatomic) IBOutlet UIImageView *settlementImageView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@property (weak, nonatomic) IBOutlet UIButton *logoutButton;
@end
