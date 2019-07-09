//
//  DXCSearchCellTableViewCell.m
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 29/09/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import "DXCSearchCellTableViewCell.h"

@implementation DXCSearchCellTableViewCell


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)viewIn3DButtonClicked:(UIButton *)sender {
    self.viewIn3DButtonClicked(YES);
    
}
- (IBAction)financeButtonClicked:(UIButton *)sender {
    self.financeButtonClicked(YES);
    
}
@end
