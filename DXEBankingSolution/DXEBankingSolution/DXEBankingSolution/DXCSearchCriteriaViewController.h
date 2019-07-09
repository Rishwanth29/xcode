//
//  DXCSearchCriteriaViewController.h
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 10/9/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AIExpert/AIExpert.h>

@interface DXCSearchCriteriaViewController : UIViewController<AIChatViewProtocol>
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *propertyTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceFromLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceToLabel;
@property (weak, nonatomic) IBOutlet UILabel *bedroomsLabel;
@property (weak, nonatomic) IBOutlet UILabel *bathroomsLabel;
@property (weak, nonatomic) IBOutlet UILabel *parkingLabel;
@property (weak, nonatomic) IBOutlet UILabel *keywordsLabel;

@end
