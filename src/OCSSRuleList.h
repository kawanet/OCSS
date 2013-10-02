//
//  CSSRuleList.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCList.h"

@class OCSSRule;

@interface OCSSRuleList : OCListCSS

- (void) addRule:(id)rule;

@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface CSSRuleList {
 readonly attribute unsigned long   length;
 CSSRule                            item(in unsigned long index);
 };
 */