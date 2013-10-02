//
//  OHTMLDocument.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCHTMLDocument.h"
#import "OCSS.h"
#import "OCX.h"

@interface OCStyleHit : NSObject
@property OCXSelector *selector;
@property OCSSStyleDeclaration *declarations;
@property NSUInteger specificity;
@end

@implementation OCStyleHit

- (NSComparisonResult) compareSpecificity:(OCStyleHit*)hit {
    if (self.specificity > hit.specificity) {
        return NSOrderedDescending;
    } else if (self.specificity < hit.specificity) {
        return NSOrderedAscending;
    } else {
        return NSOrderedSame;
    }  
}

@end

@implementation OCDocumentFragment
@end

@implementation OCDocument

- (OCHTMLElement*)createElement:(NSString*)tagName {
    OCHTMLElement *element = [[OCHTMLElement alloc] init];
    element.ownerDocument = self;
    element.tagName = tagName;
    return element;
}

- (OCDocumentFragment*)createDocumentFragment {
    OCDocumentFragment *node = [[OCDocumentFragment alloc] init];
    node.ownerDocument = self;
    return node;
}

- (OCText*)createTextNode:(NSString*)data {
    OCText *node = [[OCText alloc] init];
    node.ownerDocument = self;
    node.data = data;
    return node;
}

- (OCComment*)createComment:(NSString*)data {
    OCComment *node = [[OCComment alloc] init];
    node.ownerDocument = self;
    node.data = data;
    return node;
}

- (OCCDATASection*)createCDATASection:(NSString*)data {
    OCCDATASection *node = [[OCCDATASection alloc] init];
    node.ownerDocument = self;
    return node;
}

- (OCAttr*)createAttribute:(NSString*)name {
    OCAttr *node = [[OCAttr alloc] init];
    node.ownerDocument = self;
    node.name = name;
    return node;
}

@end

@implementation OCHTMLDocument {
    OCHTMLElement *_body;
}

- (OCHTMLElement *)body {
    if (_body) return _body;
    // TODO: _body = [self getElementByTagName:@"BODY"];
    _body = [self createElement:@"BODY"];
    [self appendChild:_body];
    return _body;
}

- (void) addStyleSheet:(OCSSStyleSheet*)styleSheet {
    if (!self.styleSheets) {
        self.styleSheets = [OCStyleSheetList new];
    }

    [self.styleSheets addStyleSheet:styleSheet];
}

- (OCHTMLElement *) createElementWithSelector:(NSString*)selector {
    
    OCXSelector *sel = [OCXSelector new];
    sel.selector = selector;
    
    OCHTMLElement *node;
    OCHTMLElement *parent;
    OCHTMLElement *root;
    NSString *old;
    
    for(OCXSelectorPart *part in sel.parts) {
        // NSLog(@"[%c] '%@' '%@'", part.type, part.text, part.arg);
        
        switch (part.type) {
            case OCSSSelectorUniversal:           // '*'  *
                node = [self createElement:@"div"];
                [parent appendChild:node];
                break;
            case OCSSSelectorType:                // 'E'  E
                node = [self createElement:part.text];
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
                    node = [self createElement:@"div"];
                    [parent appendChild:node];
                }
                [node setAttribute:part.text withValue:part.text];
                break;
            case OCSSSelectorAttributeIsEqual:    // '='  [foo="warning"]
            case OCSSSelectorAttributeIncludes:   // '~'  [foo~="warning"]
            case OCSSSelectorAttributeBeginWith:  // '|'  [lang|="en"]
                if (!node) {
                    node = [self createElement:@"div"];
                    [parent appendChild:node];
                }
                [node setAttribute:part.text withValue:part.arg];
                break;
            case OCSSSelectorClass:               // '.'  .class
                if (!node) {
                    node = [self createElement:@"div"];
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
                    node = [self createElement:@"div"];
                    [parent appendChild:node];
                }
                node.id = part.text;
                break;
        }
        
        if (!root) {
            root = node;
        }
    }
    
    // NSLog(@"getComputedStyleForSelector: %@", root.outerHTML);
    
    return node;
}

- (OCSSStyleDeclaration *) getComputedStyle:(OCHTMLElement *)element {
    NSMutableArray *array = NSMutableArray.new;
    
    NSUInteger counter = 0;
    for(OCSSStyleSheet *styleSheet in self.styleSheets) {
        for(OCSSStyleRule *rule in styleSheet.cssRules) {
            if (![rule isKindOfClass:[OCSSStyleRule class]]) continue;
            for(OCXSelector *selector in rule.selectors) {
                if (![selector isSelectedForElement:element]) continue;
                OCStyleHit *hit = [OCStyleHit new];
                hit.selector = selector;
                hit.specificity = selector.specificity + counter;
                counter ++;
                hit.declarations = rule.style;
                [array addObject:hit];
                // NSLog(@"hit: %@", rule.cssText);
            }
        }
    }
    
    OCSSStyleDeclaration *style = [OCSSStyleDeclaration new];
    if (!array.count) return style;

    NSArray *sorted = [array sortedArrayUsingSelector:@selector(compareSpecificity:) ];
    
    for(OCStyleHit *hit in sorted) {
        for(OCXDeclaration *decl in hit.declarations) {
            [style addDeclaration:decl];
        }
    }
    
    return style;
}

@end
