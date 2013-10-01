//
//  OCSS.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSS.h"

@implementation OCSS {
    OCHTMLDocument *_document;
}

- (instancetype) initWithContentsOfURL:(NSURL *)url {
    self = self.init;
    [self addStyleSheetWithContentsOfURL:url];
    return self;
}

- (OCHTMLDocument *) document {
    if (_document) return _document;
    return _document = [OCHTMLDocument new];
}

- (void) addStyleSheetWithContentsOfURL:(NSURL *)url {
    NSString *source = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    
    OCSSStyleSheet *styleSheet = [[OCSSStyleSheet alloc] initWithString:source];
    
    [self.document addStyleSheet:styleSheet];
}

- (OCSSStyleDeclaration *) getComputedStyleForSelector:(NSString *)selector {
    
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSArray *split = [selector componentsSeparatedByCharactersInSet:set];
    
    OCHTMLElement *node;
    OCHTMLElement *parent;
    OCHTMLElement *root;
    
    for(NSString *str in split) {
        if (!str.length) continue;
        parent = node;
        NSString *tagName = @"div";
        NSString *className;
        NSString *idName;
        if ([str hasPrefix:@"."]) {
            className = [str substringFromIndex:1];
        } else if ([str hasPrefix:@"#"]) {
            idName = [str substringFromIndex:1];
        } else {
            tagName = str;
        }
        node = [self.document createElement:tagName];
        if (className.length) node.className = className;
        if (idName.length) node.id = idName;
        if (!root) root = node;
        [parent appendChild:node];
    }
    
    NSLog(@"%@", root.outerHTML);
    
    NSMutableArray *array = NSMutableArray.new;
    
    for(OCSSStyleSheet *styleSheet in self.document.styleSheets) {
        for(OCSSStyleRule *rule in styleSheet.cssRules) {
            if (![rule isKindOfClass:[OCSSStyleRule class]]) continue;
            // NSLog(@"%@", rule.selectorText);
            for(OCSSSelector *selector in rule.selectors) {
                if ([selector.selector isEqualToString:node.tagName]) {
                    [array addObject:rule];
                    NSLog(@"%@", rule.cssText);
                }
            }
        }
    }

    OCSSStyleDeclaration *style = [OCSSStyleDeclaration new];
    if (!array.count) return style;
    
    for(OCSSStyleRule *rule in array) {
        for(OCSSDeclaration *decl in rule.declarations) {
            [style addDeclaration:decl];            
        }
    }

    NSLog(@"%@", style.cssText);

    return style;
}

@end
