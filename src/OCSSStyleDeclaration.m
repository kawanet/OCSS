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

- (void) addDeclaration:(OCXDeclaration *)declaration {
    declaration.parentStyleDeclaration = self;
    [self.list addObject:declaration];
}

- (id)objectForKeyedSubscript:(id)key {
    NSString *name = ((NSString *)key).lowercaseString;
    OCXDeclaration *hit;
    for(OCXDeclaration *decl in self.list) {
        // return last definition
        if ([name isEqualToString:decl.property]) hit = decl;
    }
    return hit.value.cssText;
}

- (NSString *) delimiter {
    return @" ";
}

@end
