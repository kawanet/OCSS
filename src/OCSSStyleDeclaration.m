//
//  CSSDeclarationList.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSStyleDeclaration.h"

@implementation OCSSStyleDeclaration

- (void) addDeclaration:(OCSSDeclaration *)declaration {
    [self.list addObject:declaration];
}

- (id)objectForKeyedSubscript:(id)key {
    NSString *name = ((NSString *)key).lowercaseString;
    OCSSDeclaration *hit;
    for(OCSSDeclaration *decl in self.list) {
        if ([name isEqualToString:decl.property]) hit = decl;
    }
    return hit.value.value;
}

@end
