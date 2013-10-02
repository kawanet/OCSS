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

- (OCSSStyleDeclaration *)style {
    if (_style) return _style;
    return _style = [OCSSStyleDeclaration new];
}

- (void) setStyle:(OCSSStyleDeclaration *)style {
    style.parentRule = self;
    _style = style;
}

- (OCXDeclaration *) declarationForProperty:(NSString *)property {
    OCXDeclaration *match;
    for(OCXDeclaration *decl in self.style) {
        if ([decl.property isEqualToString:property]) {
            match = decl;
        }
    }
    return match;
}

- (NSString *) cssText {
    NSString *selector = self.selectorText;
    NSMutableArray *array = NSMutableArray.new;
    for(OCXDeclaration *decl in self.style) {
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
