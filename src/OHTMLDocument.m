//
//  CSSDocument.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OHTMLDocument.h"

@implementation OHTMLDocument

- (void) addStyleSheet:(OCSSStyleSheet*)styleSheet {
    if (!self.styleSheets) {
        self.styleSheets = OCSSStyleSheetList.new;
    }
    styleSheet.parentDocument = self;

    [self.styleSheets addStyleSheet:styleSheet];
}

@end
