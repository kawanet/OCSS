//
//  CSSStyleSheetList.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSBaseList.h"
#import "OCSSStyleSheet.h"

@interface OCSSStyleSheetList : OCSSBaseList

- (void) addStyleSheet:(OCSSStyleSheet *) styleSheet;

@end
