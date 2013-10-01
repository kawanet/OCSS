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

- (NSString *) id {
    return [self getAttribute:@"id"];
}

- (void) setId:(NSString*)value {
    [self setAttribute:@"id" withValue:value];
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

- (void)setAttribute:(NSString*)name, ... {
    va_list arguments;
    va_start(arguments, name);
    NSString* value = name;
    value = va_arg(arguments, typeof(NSString*));
    va_end(arguments);
    [self setAttribute:name withValue:value];
}

- (void)setAttribute:(NSString*)name withValue:(NSString*)value {
    OHTMLAttr *node;
    if (self.ownerDocument) {
        node = [self.ownerDocument createAttribute:name];
    } else {
        node = [OHTMLAttr new];
        node.name = name;
    }
    node.value = value;
    [self setAttributeNode:node];
}

- (NSString *)outerHTML {
    NSString *lower = self.tagName.lowercaseString;
    NSString *inner = self.innerHTML;
    NSMutableArray *array = [NSMutableArray new];
    for(OHTMLAttr *attr in self.attributes.allValues) {
        NSString *pair;
        if (attr.value) {
            pair = [NSString stringWithFormat:@"%@=\"%@\"", attr.name, attr.value];
        } else {
            pair = attr.name;
        }
        [array addObject:pair];
    }
    NSString *attr = @"";
    if (array.count) {
        attr = [array componentsJoinedByString:@" "];
        attr = [@" " stringByAppendingString:attr];
    }
    return [NSString stringWithFormat:@"<%@%@>%@</%@>", lower, attr, inner, lower];
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
