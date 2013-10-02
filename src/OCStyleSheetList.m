//
//  CSSStyleSheetList.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCStyleSheetList.h"

@implementation OCStyleSheetList

- (void) addStyleSheet:(OCSSStyleSheet *) styleSheet {
    [self.list addObject:styleSheet];
}

@end