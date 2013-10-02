//
//  OCSSStyleRule.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSStyleRule.h"
#import "OCXSelector.h"

@implementation OCSSStyleRule

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
    return [NSString stringWithFormat:@"%@ { %@ }\n", selector, rules];
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
