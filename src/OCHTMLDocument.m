//
//  OHTMLDocument.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCHTMLDocument.h"
#import "OCSSStyleRule.h"

@interface OCStyleHit : NSObject
@property OCXSelector *selector;
@property OCSSStyleDeclaration *declarations;
@end

@implementation OCStyleHit
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

- (OCSSStyleDeclaration *) getComputedStyle:(OCHTMLElement *)element {
    NSMutableArray *array = NSMutableArray.new;
    
    for(OCSSStyleSheet *styleSheet in self.styleSheets) {
        for(OCSSStyleRule *rule in styleSheet.cssRules) {
            if (![rule isKindOfClass:[OCSSStyleRule class]]) continue;
            // NSLog(@"%@", rule.selectorText);
            for(OCXSelector *selector in rule.selectors) {
                if (![selector isSelectedForElement:element]) continue;
                OCStyleHit *hit = [OCStyleHit new];
                hit.selector = selector;
                hit.declarations = rule.style;
                [array addObject:hit];
                // NSLog(@"%@", rule.cssText);
            }
        }
    }
    
    OCSSStyleDeclaration *style = [OCSSStyleDeclaration new];
    if (!array.count) return style;
    
    for(OCStyleHit *hit in array) {
        for(OCXDeclaration *decl in hit.declarations) {
            [style addDeclaration:decl];
        }
    }
    
    // NSLog(@"%@", style.cssText);
    
    return style;
}

@end
