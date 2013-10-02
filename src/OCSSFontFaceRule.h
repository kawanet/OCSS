//
//  OCSSFontFaceRule.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSRule.h"

@class OCSSStyleDeclaration;

@interface OCSSFontFaceRule : OCSSRule

@property OCSSStyleDeclaration *style;

@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface CSSFontFaceRule : CSSRule {
 readonly attribute CSSStyleDeclaration  style;
 };
 */
