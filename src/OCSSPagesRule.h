//
//  CSSPagesRule.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSRule.h"

@class OCSSStyleDeclaration;

@interface OCSSPagesRule : OCSSRule

@property NSString *selectorText;
@property (readonly) OCSSStyleDeclaration *style;

@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface CSSPageRule : CSSRule {
 attribute DOMString                        selectorText; // raises(dom::DOMException) on setting
 readonly attribute CSSStyleDeclaration     style;
 };
 */
