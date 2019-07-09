//
//  DXCSearchCellTableViewCell.h
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 29/09/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXCSearchCellTableViewCell : UITableViewCell
@property (nonatomic,copy) void (^viewIn3DButtonClicked)(BOOL);
@property (nonatomic,copy) void (^financeButtonClicked)(BOOL);
@end
