//
//  MyBankProfileImageView.m
//  MyBankDemo
//
//  Created by AnilBhandarkar on 28/05/17.
//  Copyright © 2017 Kuragin Dmitriy. All rights reserved.
//

#import "DXCProfileImageView.h"

@implementation DXCProfileImageView

-(void)layoutSubviews {
    self.layer.cornerRadius=self.frame.size.width/2.0;
    self.layer.borderWidth=1.0;
    self.layer.borderColor=(__bridge CGColorRef _Nullable)([UIColor blueColor]);
    self.layer.masksToBounds = true;
    [super layoutSubviews];
}

@end
