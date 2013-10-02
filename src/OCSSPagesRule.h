//
//  CSSPagesRule.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSRule.h"
#import "OCSSStyleDeclaration.h"

@interface OCSSPagesRule : OCSSRule

@property NSString *selectorText;
@property OCSSStyleDeclaration *style;

@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface CSSPageRule : CSSRule {
 attribute DOMString                        selectorText; // raises(dom::DOMException) on setting
 readonly attribute CSSStyleDeclaration     style;
 };
 */