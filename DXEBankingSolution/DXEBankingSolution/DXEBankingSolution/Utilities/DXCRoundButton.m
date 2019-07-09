//
//  DXCRoundButton.m
//  DXCBankingSolution
//
//  Created by anilbhandarkar on 1/7/16.
//  Copyright © 2017 Mphasis. All rights reserved.

#import "DXCRoundButton.h"
#import <QuartzCore/QuartzCore.h>
@interface DXCRoundButton()

@end

@implementation DXCRoundButton
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        self.layer.cornerRadius = self.frame.size.height/2.0;
        self.backgroundColor =[UIColor clearColor];
        
        self.layer.borderColor=[UIColor whiteColor].CGColor;
        self.layer.borderWidth = 2;
    }
    return self;
}
-(void)layoutSubviews {
    
    [super layoutSubviews];

    self.layer.borderWidth = 2;
    self.layer.cornerRadius = self.frame.size.height/2.0;
    [super layoutSubviews];
}

- (void) setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    dispatch_async(dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.01 animations:^{
            if (highlighted) {
                
                self.backgroundColor = [UIColor whiteColor];
                
                self.titleLabel.textColor=[UIColor blackColor];
                
                
            }
            else {
                
                self.backgroundColor =[UIColor clearColor];
                
                self.titleLabel.textColor=[UIColor whiteColor];
                
                
            }
        } completion:^(BOOL finished) {
            if (highlighted) {
                
                self.backgroundColor = [UIColor whiteColor];
                
                self.titleLabel.textColor=[UIColor blackColor];
                
                
            }
            else {
                
                self.backgroundColor =[UIColor clearColor];
                
                self.titleLabel.textColor=[UIColor whiteColor];
                
                
            }
        }];
    });
    
    
}
@end
