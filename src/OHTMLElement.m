//
//  OHTMLElement.m
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OHTMLElement.h"
#import "OHTMLDocument.h"

@implementation OHTMLElement {
    NSMutableDictionary *_attributes;
}

- (NSMutableDictionary *) attributes {
    if (_attributes) return _attributes;
    return _attributes = [NSMutableDictionary new];
}

- (NSString *)getAttribute:(NSString*)name {
    OHTMLAttr *attr = [self getAttributeNode:name];
    return attr.value;
}

- (OHTMLAttr*)getAttributeNode:(NSString*)name {
    return self.attributes[name];
}

- (void)setAttributeNode:(OHTMLAttr*)newAttr {
    self.attributes[newAttr.name] = newAttr;
}

- (NSString *)outerHTML {
    NSString *lower = self.tagName.lowercaseString;
    NSString *inner = self.innerHTML;
    return [NSString stringWithFormat:@"<%@>%@</%@>", lower, inner, lower];
}

- (NSString *)innerHTML {
    NSMutableArray *array = [NSMutableArray new];
    for(OHTMLNode *node in self.childNodes) {
        NSString *str;
        if ([node isKindOfClass:[OHTMLElement class]]) {
            str = ((OHTMLElement *)node).outerHTML;
        } else if ([node isKindOfClass:[OHTMLTextNode class]]) {
            str = ((OHTMLTextNode *)node).data;
        }
        if (str) [array addObject:str];
    }
    return [array componentsJoinedByString:@""];
}

- (NSString *)innerText {
    NSMutableArray *array = [NSMutableArray new];
    for(OHTMLNode *node in self.childNodes) {
        NSString *str;
        if ([node isKindOfClass:[OHTMLElement class]]) {
            str = ((OHTMLElement *)node).innerText;
        } else if ([node isKindOfClass:[OHTMLTextNode class]]) {
            str = ((OHTMLTextNode *)node).data;
        }
        if (str) [array addObject:str];
    }
    return [array componentsJoinedByString:@""];
}

- (void)setInnerText:(NSString *)text {
    OHTMLTextNode *node;
    if (self.ownerDocument) {
        node = [self.ownerDocument createTextNode:text];
    } else {
        node = [OHTMLTextNode new];
        node.data = text;
    }
    [self.childNodes.list removeAllObjects];
    [self appendChild:node];
}

@end
