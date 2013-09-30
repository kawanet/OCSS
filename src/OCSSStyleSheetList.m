//
//  CSSStyleSheetList.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSStyleSheetList.h"

@implementation OCSSStyleSheetList

- (void) addStyleSheet:(OCSSStyleSheet *) styleSheet {
    if (self.list) {
        self.list = [self.list arrayByAddingObject:styleSheet];
    } else {
        self.list = [NSArray arrayWithObject:styleSheet];
    }
}

@end
