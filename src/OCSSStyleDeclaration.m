//
//  OCSSStyleDeclaration.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSStyleDeclaration.h"
#import "OCSS.h"
#import "OCX.h"

@implementation OCSSStyleDeclaration

- (OCXProperty *) getProperty:(NSString *)propertyName {
    OCXProperty *hit;
    for(OCXProperty *decl in self.list) {
        // return last definition
        if ([propertyName isEqualToString:decl.propertyName]) {
            hit = decl;
        }
    }
    return hit;
}

- (OCSSValue *) getPropertyCSSValue:(NSString *)propertyName {
    OCXProperty *hit = [self getProperty:propertyName];
    return hit.value;
}

- (NSString *) getPropertyValue:(NSString *)propertyName {
    OCSSValue *value = [self getPropertyCSSValue:propertyName];
    return value.cssText;
}

- (NSString *) removeProperty:(NSString *)propertyName {
    OCXProperty *hit;
    NSMutableArray *removes = NSMutableArray.new;
    for(OCXProperty *decl in self.list) {
        if ([propertyName isEqualToString:decl.propertyName]) {
            hit = decl;
            [removes addObject:decl];
        }
    }

    for(OCXProperty *decl in removes) {
        [self.list removeObject:decl];
    }
    
    return hit.value.cssText;
}

- (void) setProperty:(NSString *)propertyName, ... {
    va_list arguments;
    va_start(arguments, propertyName);
    NSString* value = propertyName;
    value = va_arg(arguments, typeof(NSString*));
    va_end(arguments);
    
    [self setProperty:propertyName withValue:value];
}

- (void) setProperty:(NSString *)propertyName withValue:(NSString*)value {
    OCXProperty *decl = [OCXProperty new];
    decl.propertyName = propertyName;
    decl.value.cssText = value;
    
    [self removeProperty:propertyName];
    [self addDeclaration:decl];
}

- (void) addDeclaration:(OCXProperty *)declaration {
    declaration.parentStyleDeclaration = self;
    [self.list addObject:declaration];
}

- (id)objectForKeyedSubscript:(id)key {
    return [self getPropertyValue:key];
}

- (NSString *) delimiter {
    return @" ";
}

@end
