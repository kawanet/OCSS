//
//  OCSSFontFaceRule.m
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSFontFaceRule.h"

@implementation OCSSFontFaceRule

- (NSString *)cssText {
    NSString *text = [NSString stringWithFormat:@"@font-face {\n%@}\n", self.style.cssText];
    return text;
}

@end
