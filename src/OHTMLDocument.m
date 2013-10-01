//
//  OHTMLDocument.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OHTMLDocument.h"

@implementation OHTMLDocumentFragment
@end

@implementation OHTMLDocument {
    OHTMLElement *_body;
}

- (OHTMLElement *)body {
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

- (OHTMLElement*)createElement:(NSString*)tagName {
    OHTMLElement *element = [[OHTMLElement alloc] init];
    element.ownerDocument = self;
    element.tagName = tagName;
    return element;
}

- (OHTMLDocumentFragment*)createDocumentFragment {
    OHTMLDocumentFragment *node = [[OHTMLDocumentFragment alloc] init];
    node.ownerDocument = self;
    return node;
}

- (OHTMLTextNode*)createTextNode:(NSString*)data {
    OHTMLTextNode *node = [[OHTMLTextNode alloc] init];
    node.ownerDocument = self;
    node.data = data;
    return node;
}

- (OHTMLCommentNode*)createComment:(NSString*)data {
    OHTMLCommentNode *node = [[OHTMLCommentNode alloc] init];
    node.ownerDocument = self;
    node.data = data;
    return node;
}

- (OHTMLCDATASection*)createCDATASection:(NSString*)data {
    OHTMLCDATASection *node = [[OHTMLCDATASection alloc] init];
    node.ownerDocument = self;
    return node;
}

- (OHTMLAttr*)createAttribute:(NSString*)name {
    OHTMLAttr *node = [[OHTMLAttr alloc] init];
    node.ownerDocument = self;
    node.name = name;
    return node;
}

@end
