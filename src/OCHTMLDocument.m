//
//  OHTMLDocument.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCHTMLDocument.h"

@implementation OCHTMLDocumentFragment
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
        self.styleSheets = OCSSStyleSheetList.new;
    }
    styleSheet.parentDocument = self;

    [self.styleSheets addStyleSheet:styleSheet];
}

- (OCHTMLElement*)createElement:(NSString*)tagName {
    OCHTMLElement *element = [[OCHTMLElement alloc] init];
    element.ownerDocument = self;
    element.tagName = tagName;
    return element;
}

- (OCHTMLDocumentFragment*)createDocumentFragment {
    OCHTMLDocumentFragment *node = [[OCHTMLDocumentFragment alloc] init];
    node.ownerDocument = self;
    return node;
}

- (OCHTMLTextNode*)createTextNode:(NSString*)data {
    OCHTMLTextNode *node = [[OCHTMLTextNode alloc] init];
    node.ownerDocument = self;
    node.data = data;
    return node;
}

- (OCHTMLCommentNode*)createComment:(NSString*)data {
    OCHTMLCommentNode *node = [[OCHTMLCommentNode alloc] init];
    node.ownerDocument = self;
    node.data = data;
    return node;
}

- (OCHTMLCDATASection*)createCDATASection:(NSString*)data {
    OCHTMLCDATASection *node = [[OCHTMLCDATASection alloc] init];
    node.ownerDocument = self;
    return node;
}

- (OCHTMLAttr*)createAttribute:(NSString*)name {
    OCHTMLAttr *node = [[OCHTMLAttr alloc] init];
    node.ownerDocument = self;
    node.name = name;
    return node;
}

@end
