//
//  UIColor (HexToRGB)
//  DXEBankingSolution
//
//  Created by AnilBhandarkar on 29/09/17.
//  Copyright © 2017 Mphasis. All rights reserved.
//
#import "UIColor+HexToRGB.h"

@implementation UIColor (HexToRGB)
+ (UIColor *)colorWithHexString:(NSString *)str {
    NSScanner* scanner = [NSScanner scannerWithString:str];
    unsigned int hex;
    [scanner scanHexInt:&hex];
        // Parsing successful. We have a big int representing the 0xBD8F60 value
    int r = (hex >> 16) & 0xFF; // get the first byte
    int g = (hex >>  8) & 0xFF; // get the middle byte
    int b = (hex      ) & 0xFF; // get the last byte
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:1];
    
}

@end
