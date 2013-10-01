//
//  OCSS.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSS.h"
#import "OCSSSelectorPart.h"

@interface OCStyleHit : NSObject
@property OCSSSelector *selector;
@property OCSSStyleDeclaration *declarations;
@end

@implementation OCStyleHit
@end

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
    
    OCSSSelector *sel = [OCSSSelector new];
    sel.selector = selector;
    
    OCHTMLElement *node;
    OCHTMLElement *parent;
    OCHTMLElement *root;
    NSString *old;
    
    for(OCSSSelectorPart *part in sel.parts) {
        // NSLog(@"[%c] '%@' '%@'", part.type, part.text, part.arg);
        
        switch (part.type) {
            case OCSSSelectorUniversal:           // '*'  *
                node = [self.document createElement:@"div"];
                [parent appendChild:node];
                break;
            case OCSSSelectorType:                // 'E'  E
                node = [self.document createElement:part.text];
                [parent appendChild:node];
                break;
            case OCSSSelectorDescendant:          // ' '  E F
            case OCSSSelectorChild:               // '>'  E > F
            case OCSSSelectorAdjacent:            // '+'  E + F
                parent = node;
                node = nil;
                break;
            case OCSSSelectorPseudoClass:         // ':'  :pseudo
            case OCSSSelectorAttributeExists:     // '['  [foo]
                if (!node) {
                    node = [self.document createElement:@"div"];
                    [parent appendChild:node];
                }
                [node setAttribute:part.text withValue:part.text];
                break;
            case OCSSSelectorAttributeIsEqual:    // '='  [foo="warning"]
            case OCSSSelectorAttributeIncludes:   // '~'  [foo~="warning"]
            case OCSSSelectorAttributeBeginWith:  // '|'  [lang|="en"]
                if (!node) {
                    node = [self.document createElement:@"div"];
                    [parent appendChild:node];
                }
                [node setAttribute:part.text withValue:part.arg];
                break;
            case OCSSSelectorClass:               // '.'  .class
                if (!node) {
                    node = [self.document createElement:@"div"];
                    [parent appendChild:node];
                }
                old = node.className;
                if (old.length) {
                    node.className = [NSString stringWithFormat:@"%@ %@", old, part.text];
                } else {
                    node.className = part.text;
                }
                break;
            case OCSSSelectorID:                  // '#'  #id
                if (!node) {
                    node = [self.document createElement:@"div"];
                    [parent appendChild:node];
                }
                node.id = part.text;
                break;
        }
        
        if (!root) {
            root = node;
        }
    }
    
    NSLog(@"getComputedStyleForSelector: %@", root.outerHTML);

    return [self getComputedStyle:node];
}

- (OCSSStyleDeclaration *) getComputedStyle:(OCHTMLElement *)element {
    NSMutableArray *array = NSMutableArray.new;
    
    for(OCSSStyleSheet *styleSheet in self.document.styleSheets) {
        for(OCSSStyleRule *rule in styleSheet.cssRules) {
            if (![rule isKindOfClass:[OCSSStyleRule class]]) continue;
            // NSLog(@"%@", rule.selectorText);
            for(OCSSSelector *selector in rule.selectors) {
                if (![selector isSelectedForElement:element]) continue;
                OCSSStyleDeclaration *decls = rule.declarations;
                OCStyleHit *hit = [OCStyleHit new];
                hit.selector = selector;
                hit.declarations = decls;
                [array addObject:hit];
                // NSLog(@"%@", rule.cssText);
            }
        }
    }

    OCSSStyleDeclaration *style = [OCSSStyleDeclaration new];
    if (!array.count) return style;
    
    for(OCStyleHit *hit in array) {
        for(OCSSDeclaration *decl in hit.declarations) {
            [style addDeclaration:decl];            
        }
    }

    // NSLog(@"%@", style.cssText);

    return style;
}

@end
