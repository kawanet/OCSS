//
//  CSSPagesRule.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSPagesRule.h"
#import "OCSS.h"

@implementation OCSSPagesRule {
    OCSSStyleDeclaration *_style;
}

- (unsigned short) type {
    return [OCSSRule PAGE_RULE];
}

- (OCSSStyleDeclaration *)style {
    if (_style) return _style;
    _style = [OCSSStyleDeclaration new];
    _style.parentRule = self;
    return _style;
}

- (NSString *)cssText {
    NSString *text = [NSString stringWithFormat:@"@pages %@ {\n%@ }\n", self.selectorText, self.style.cssText];
    return text;
}

@end
