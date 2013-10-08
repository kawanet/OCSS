//
//  OCSSFontFaceRule.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSFontFaceRule.h"
#import "OCSS.h"

@implementation OCSSFontFaceRule {
    OCSSStyleDeclaration *_style;
}

- (unsigned short) type {
    return [OCSSRule FONT_FACE_RULE];
}

- (OCSSStyleDeclaration *)style {
    if (_style) return _style;
    _style = [OCSSStyleDeclaration new];
    _style.parentRule = self;
    return _style;
}

- (NSString *)cssText {
    NSString *text = [NSString stringWithFormat:@"@font-face {\n%@}\n", self.style.cssText];
    return text;
}

@end
