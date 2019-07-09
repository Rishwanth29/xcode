//
//  DXCFinanceBankCell.h
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 06/10/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXCFinanceBankCell : UICollectionViewCell
@property (nonatomic,copy) void (^getApprovalButtonClicked)(BOOL);
@end
