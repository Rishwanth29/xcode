//
//  DXCHomeConfirmationViewController.h
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 30/09/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXCHomeConfirmationViewController : UIViewController
@property (nonatomic,copy) void (^returnHomeConfirmation)(BOOL);
@end
