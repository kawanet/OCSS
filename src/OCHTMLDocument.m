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
            case OCSSSelectorUniversal:
                // *	any element
                node = [self createElement:@"div"];
                [parent appendChild:node];
                break;
                
            case OCSSSelectorType:
                // E	an element of type E
                node = [self createElement:part.text];
                [parent appendChild:node];
                break;
                
            case OCSSSelectorAttrExists:
                // E[foo]	an E element with a "foo" attribute
            case OCSSSelectorPseudoClass:
                // E:pseudo-classes
                if (!node) {
                    node = [self createElement:@"div"];
                    [parent appendChild:node];
                }
                [node setAttribute:part.text withValue:part.text];
                break;
                
            case OCSSSelectorAttrEq:
                // E[foo="bar"]	an E element whose "foo" attribute value is exactly equal to "bar"
            case OCSSSelectorAttrTildEq:
                // E[foo~="bar"]	an E element whose "foo" attribute value is a list of whitespace-separated values, one of which is exactly equal to "bar"
            case OCSSSelectorAttrHatEq:
                // E[foo^="bar"]	an E element whose "foo" attribute value begins exactly with the string "bar"
            case OCSSSelectorAttrDollarEq:
                // E[foo$="bar"]	an E element whose "foo" attribute value ends exactly with the string "bar"
            case OCSSSelectorAttrStarEq:
                // E[foo*="bar"]	an E element whose "foo" attribute value contains the substring "bar"
            case OCSSSelectorAttrPipeEq:
                // E[foo|="en"]	an E element whose "foo" attribute has a hyphen-separated list of values beginning (from the left) with "en"
                if (!node) {
                    node = [self createElement:@"div"];
                    [parent appendChild:node];
                }
                [node setAttribute:part.text withValue:part.arg];
                break;
                
            case OCSSSelectorClass:
                // E.warning	an E element whose class is "warning" (the document language specifies how class is determined).
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
                
            case OCSSSelectorID:
                // E#myid	an E element with ID equal to "myid".
                if (!node) {
                    node = [self createElement:@"div"];
                    [parent appendChild:node];
                }
                node.id = part.text;
                break;
                
            case OCSSSelectorDescendant:
                // E F	an F element descendant of an E element
            case OCSSSelectorChild:
                // E > F	an F element child of an E element
                parent = node;
                node = nil;
                break;
                
            case OCSSSelectorAdjacentSibling:
            case OCSSSelectorGeneralSibling:
                // E ~ F	an F element preceded by an E element
                // E + F	an F element immediately preceded by an E element
                node = nil;
                break;
        }
        
        if (!root) {
            root = node;
        }
    }
    
    // NSLog(@"createElementWithSelector: %@", root.outerHTML);
    
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
            OCSSStyleDeclaration *parent = decl.parentStyleDeclaration;
            [style addDeclaration:decl];
            decl.parentStyleDeclaration = parent; // restore
        }
    }
    
    return style;
}

@end
