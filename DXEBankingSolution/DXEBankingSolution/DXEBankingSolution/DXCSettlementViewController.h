//
//  DXCSettlementViewController.h
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 10/10/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXCSettlementViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *buyerNameValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyerPublicKeyValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyerAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyerIDLabel;

@property (weak, nonatomic) IBOutlet UILabel *sellerNameValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *sellerPublicKeyValueLabel;

@property (weak, nonatomic) IBOutlet UILabel *amountDepositedLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankTokenIDLabel;

@property (weak, nonatomic) IBOutlet UILabel *bankTokenLenderAmount;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *returnToHomeButton;

@property (weak, nonatomic) IBOutlet UILabel *transactionHash;
@property (weak, nonatomic) IBOutlet UILabel *bankPropertyId;


@end
