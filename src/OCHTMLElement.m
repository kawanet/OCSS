//
//  OHTMLElement.m
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCHTMLElement.h"
#import "OCHTMLDocument.h"

@implementation OCHTMLElement {
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
    OCHTMLAttr *attr = [self getAttributeNode:name];
    return attr.value;
}

- (OCHTMLAttr*)getAttributeNode:(NSString*)name {
    return self.attributes[name];
}

- (void)setAttributeNode:(OCHTMLAttr*)newAttr {
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
    OCHTMLAttr *node;
    if (self.ownerDocument) {
        node = [self.ownerDocument createAttribute:name];
    } else {
        node = [OCHTMLAttr new];
        node.name = name;
    }
    node.value = value;
    [self setAttributeNode:node];
}

- (NSString *)outerHTML {
    NSString *lower = self.tagName.lowercaseString;
    NSString *inner = self.innerHTML;
    NSMutableArray *array = [NSMutableArray new];
    for(OCHTMLAttr *attr in self.attributes.allValues) {
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
    for(OCHTMLNode *node in self.childNodes) {
        NSString *str;
        if ([node isKindOfClass:[OCHTMLElement class]]) {
            str = ((OCHTMLElement *)node).outerHTML;
        } else if ([node isKindOfClass:[OCHTMLTextNode class]]) {
            str = ((OCHTMLTextNode *)node).data;
        }
        if (str) [array addObject:str];
    }
    return [array componentsJoinedByString:@""];
}

- (NSString *)innerText {
    NSMutableArray *array = [NSMutableArray new];
    for(OCHTMLNode *node in self.childNodes) {
        NSString *str;
        if ([node isKindOfClass:[OCHTMLElement class]]) {
            str = ((OCHTMLElement *)node).innerText;
        } else if ([node isKindOfClass:[OCHTMLTextNode class]]) {
            str = ((OCHTMLTextNode *)node).data;
        }
        if (str) [array addObject:str];
    }
    return [array componentsJoinedByString:@""];
}

- (void)setInnerText:(NSString *)text {
    OCHTMLTextNode *node;
    if (self.ownerDocument) {
        node = [self.ownerDocument createTextNode:text];
    } else {
        node = [OCHTMLTextNode new];
        node.data = text;
    }
    [self.childNodes.list removeAllObjects];
    [self appendChild:node];
}

@end
