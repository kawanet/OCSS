//
//  OCSSStyleRule.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSRule.h"

@class OCSSStyleDeclaration;
@class OCXSelectorList;
@class OCXProperty;

@interface OCSSStyleRule : OCSSRule

@property (readonly) OCSSStyleDeclaration *style;
@property OCXSelectorList *selectors;
@property (readonly) NSString *selectorText;

- (OCXProperty *) declarationForProperty:(NSString *)property;

@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface CSSStyleRule : CSSRule {
 attribute DOMString                        selectorText; // raises(dom::DOMException) on setting
 readonly attribute CSSStyleDeclaration     style;
 };
 */
