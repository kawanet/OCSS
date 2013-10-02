//
//  OHTMLElement.m
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCHTMLElement.h"
#import "OCSS.h"

@implementation OCElement {
    NSMutableDictionary *_attributes;
    OCDOMTokenList *_classList;
}

- (NSMutableDictionary *) attributes {
    if (_attributes) return _attributes;
    return _attributes = [NSMutableDictionary new];
}

- (NSString *)getAttribute:(NSString*)name {
    OCAttr *attr = [self getAttributeNode:name];
    return attr.value;
}

- (OCAttr*)getAttributeNode:(NSString*)name {
    name = name.lowercaseString;
    return self.attributes[name];
}

- (void)setAttributeNode:(OCAttr*)newAttr {
    NSString *name = newAttr.name.lowercaseString;
    self.attributes[name] = newAttr;
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
    OCAttr *node;
    if (self.ownerDocument) {
        node = [self.ownerDocument createAttribute:name];
    } else {
        node = [OCAttr new];
        node.name = name;
    }
    node.value = value;
    [self setAttributeNode:node];
}

@end

@implementation OCHTMLElement

- (NSString *) id {
    return [self getAttribute:@"id"];
}

- (void) setId:(NSString*)value {
    [self setAttribute:@"id" withValue:value];
}

- (NSString *) className {
    return [self getAttribute:@"class"];
    // return [self.classList toString];
}

- (void) setClassName:(NSString*)value {
    [self setAttribute:@"class" withValue:value];
    // _classList = [[OCDOMTokenList alloc] initWithString:self.className];
}

- (OCDOMTokenList *) classList {
    return [[OCDOMTokenList alloc] initWithString:self.className];
    // if (_classList) return _classList;
    // return [[OCDOMTokenList alloc] init];
}

- (NSString *)outerHTML {
    NSString *lower = self.tagName.lowercaseString;
    NSString *inner = self.innerHTML;
    NSMutableArray *array = [NSMutableArray new];
    for(OCAttr *attr in self.attributes.allValues) {
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
    for(OCNode *node in self.childNodes) {
        NSString *str;
        if ([node isKindOfClass:[OCHTMLElement class]]) {
            str = ((OCHTMLElement *)node).outerHTML;
        } else if ([node isKindOfClass:[OCText class]]) {
            str = ((OCText *)node).data;
        }
        if (str) [array addObject:str];
    }
    return [array componentsJoinedByString:@""];
}

- (NSString *)innerText {
    NSMutableArray *array = [NSMutableArray new];
    for(OCNode *node in self.childNodes) {
        NSString *str;
        if ([node isKindOfClass:[OCHTMLElement class]]) {
            str = ((OCHTMLElement *)node).innerText;
        } else if ([node isKindOfClass:[OCText class]]) {
            str = ((OCText *)node).data;
        }
        if (str) [array addObject:str];
    }
    return [array componentsJoinedByString:@""];
}

- (void)setInnerText:(NSString *)text {
    OCText *node;
    if (self.ownerDocument) {
        node = [self.ownerDocument createTextNode:text];
    } else {
        node = [OCText new];
        node.data = text;
    }
    [self.childNodes.list removeAllObjects];
    [self appendChild:node];
}

@end
