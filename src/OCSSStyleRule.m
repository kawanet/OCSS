//
//  AIRule.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSStyleRule.h"
#import "OCSSSelector.h"

@implementation OCSSStyleRule

- (OCSSDeclaration *) declarationForProperty:(NSString *)property {
    OCSSDeclaration *match;
    for(OCSSDeclaration *decl in self.declarations) {
        if ([decl.property isEqualToString:property]) {
            match = decl;
        }
    }
    return match;
}

- (NSString *) cssText {
    NSString *selector = self.selectorText;
    NSMutableArray *array = NSMutableArray.new;
    for(OCSSDeclaration *decl in self.declarations) {
        [array addObject:decl.cssText];
    }
    NSString *rules = [array componentsJoinedByString:@" "];
    return [NSString stringWithFormat:@"%@ { %@ }\n", selector, rules];
}

- (NSString *) selectorText {
    NSMutableArray *array = NSMutableArray.new;
    for(OCSSSelector *selector in self.selectors) {
        if (!selector.selector) {
            NSLog(@"!!! %@ !!!", self.declarations.cssText);
        }
        if (!selector.selector) continue;
        [array addObject:selector.selector];
    }
    NSString *text = [array componentsJoinedByString:@", "];
    return text;
}

@end
