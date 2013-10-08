//
//  OCSS.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSS.h"
#import "OCX.h"

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
    NSError *error;
    NSString *source = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    if (!source.length) return;
    
    OCSSStyleSheet *styleSheet = [[OCSSStyleSheet alloc] initWithString:source];
    styleSheet.href = url.absoluteString;
    
    [self.document addStyleSheet:styleSheet];
}

- (OCSSStyleDeclaration *) getComputedStyleForSelector:(NSString *)selector {
    OCXSelector *sel = [OCXSelector new];
    sel.selector = selector;
    
    OCHTMLElement *node;
    OCHTMLUnknownElement *root = [OCHTMLUnknownElement new];
    OCNode *parent = root;
    NSString *old;
    
    for(OCXSelectorPart *part in sel.parts) {
        switch (part.type) {
            case OCSSSelectorUniversal:
                // *	any element
                node = nil;
                break;
                
            case OCSSSelectorType:
                // E	an element of type E
                node = [[OCHTMLElement alloc] initWithName:part.text];
                [parent appendChild:node];
                break;
        }

        if (!node) {
            node = [OCHTMLUnknownElement new];
            [parent appendChild:node];
        }

        switch (part.type) {
            case OCSSSelectorAttrExists:
                // E[foo]	an E element with a "foo" attribute
            case OCSSSelectorPseudoClass:
                // E:pseudo-classes
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
                [node setAttribute:part.text withValue:part.arg];
                break;
                
            case OCSSSelectorClass:
                // E.warning	an E element whose class is "warning" (the document language specifies how class is determined).
                old = node.className;
                if (old.length) {
                    node.className = [NSString stringWithFormat:@"%@ %@", old, part.text];
                } else {
                    node.className = part.text;
                }
                break;
                
            case OCSSSelectorID:
                // E#myid	an E element with ID equal to "myid".
                node.id = part.text;
                break;
                
            case OCSSSelectorDescendant:
                // E F	an F element descendant of an E element
                parent = node;
                node = [OCHTMLUnknownElement new];
                [parent appendChild:node];
                parent = node;
                node = nil;
                break;
                
            case OCSSSelectorChild:
                // E > F	an F element child of an E element
                parent = node;
                node = nil;
                break;
                
            case OCSSSelectorAdjacentSibling:
                // E + F	an F element immediately preceded by an E element
                node = nil;
                break;

            case OCSSSelectorGeneralSibling:
                // E ~ F	an F element preceded by an E element
                node = [OCHTMLUnknownElement new];
                [parent appendChild:node];
                break;
        }
    }
    
    // NSLog(@"\n%@\n%@", selector, root.innerHTML);
    
    return [self.document getComputedStyle:node];
}

@end
