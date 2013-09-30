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
    if (!self.list) {
        self.list = NSArray.new;
    }
    self.list = [self.list arrayByAddingObject:declaration];
}

@end
