//
//  OCSSStyleRule.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSStyleRule.h"
#import "OCSS.h"
#import "OCX.h"

@implementation OCSSStyleRule {
    OCSSStyleDeclaration *_style;
}

- (unsigned short) type {
    return [OCSSRule STYLE_RULE];
}

- (OCSSStyleDeclaration *)style {
    if (_style) return _style;
    _style = [OCSSStyleDeclaration new];
    _style.parentRule = self;
    return _style;
}

- (OCXProperty *) declarationForProperty:(NSString *)property {
    OCXProperty *match;
    for(OCXProperty *decl in self.style) {
        if ([decl.propertyName isEqualToString:property]) {
            match = decl;
        }
    }
    return match;
}

- (NSString *) cssText {
    NSString *selector = self.selectorText;
    NSMutableArray *array = NSMutableArray.new;
    for(OCXProperty *decl in self.style) {
        [array addObject:decl.cssText];
    }
    NSString *rules = [array componentsJoinedByString:@" "];
    return [NSString stringWithFormat:@"%@ { %@ }", selector, rules];
}

- (NSString *) selectorText {
    NSMutableArray *array = NSMutableArray.new;
    for(OCXSelector *selector in self.selectors) {
        if (!selector.selector) continue;
        [array addObject:selector.selector];
    }
    NSString *text = [array componentsJoinedByString:@", "];
    return text;
}

@end
