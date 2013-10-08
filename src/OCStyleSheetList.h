//
//  OCSSStyleSheetList.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCXList.h"

@class OCSSStyleSheet;

@interface OCStyleSheetList : OCXListCSS

- (void) addStyleSheet:(OCSSStyleSheet *) styleSheet;

@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface StyleSheetList {
 readonly attribute unsigned long   length;
 StyleSheet                         item(in unsigned long index);
 };
 */
