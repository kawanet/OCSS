//
//  CSSStyleSheetList.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCList.h"
#import "OCSSStyleSheet.h"

@interface OCStyleSheetList : OCListCSS

- (void) addStyleSheet:(OCSSStyleSheet *) styleSheet;

@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface StyleSheetList {
 readonly attribute unsigned long   length;
 StyleSheet                         item(in unsigned long index);
 };
 */