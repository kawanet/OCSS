//
//  OCSSRuleList.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCXList.h"

@class OCSSRule;
@class OCSSStyleSheet;

@interface OCSSRuleList : OCXListCSS
@property (weak) OCSSRule *parentRule;
@property (weak) OCSSStyleSheet *parentStyleSheet;
- (void) addRule:(OCSSRule*)rule;
@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface CSSRuleList {
 readonly attribute unsigned long   length;
 CSSRule                            item(in unsigned long index);
 };
 */
