//
//  AIMedia.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSRule.h"

@class OCSSRuleList;
@class OCMediaList;

@interface OCSSMediaRule : OCSSRule

@property (nonatomic) OCSSRuleList *cssRules;
@property (readonly) OCMediaList *media;

@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface CSSMediaRule : CSSRule {
 readonly attribute stylesheets::MediaList  media;
 readonly attribute CSSRuleList             cssRules;
 unsigned long                              insertRule(in DOMString rule, in unsigned long index) raises(dom::DOMException);
 void                                       deleteRule(in unsigned long index) raises(dom::DOMException);
 };
*/
