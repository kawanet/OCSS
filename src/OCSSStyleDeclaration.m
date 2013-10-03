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

- (NSString *) getPropertyValue:(NSString *)propertyName {
    OCXProperty *hit;
    for(OCXProperty *decl in self.list) {
        // return last definition
        if ([propertyName isEqualToString:decl.propertyName]) hit = decl;
    }
    return hit.propertyValue.cssText;
}

- (NSString *) removeProperty:(NSString *)propertyName {
    NSString *value;
    for(OCXProperty *decl in self.list) {
        if ([propertyName isEqualToString:decl.propertyName]) {
            value = decl.propertyValue.cssText;
            [self.list removeObject:decl];
        }
    }
    return value;
}

- (void) setProperty:(NSString *)propertyName, ... {
    va_list arguments;
    va_start(arguments, propertyName);
    NSString* value = propertyName;
    value = va_arg(arguments, typeof(NSString*));
    va_end(arguments);
    
    OCXProperty *decl = [OCXProperty new];
    decl.propertyName = propertyName;
    decl.propertyValue.cssText = value;
    
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
