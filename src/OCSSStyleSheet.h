//
//  AIStyleSheet.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCSSRuleList.h"
#import "OCMediaList.h"

@class OCHTMLDocument;

@interface OCStyleSheet : NSObject

@property NSURL* href;
@property OCMediaList* media;

@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface StyleSheet {
 readonly attribute DOMString       type;
 attribute boolean                  disabled;
 readonly attribute Node            ownerNode;
 readonly attribute StyleSheet      parentStyleSheet;
 readonly attribute DOMString       href;
 readonly attribute DOMString       title;
 readonly attribute MediaList       media;
 };
 */

@interface OCSSStyleSheet : OCStyleSheet

@property OCSSRuleList *cssRules;
@property (readonly) NSString *cssText;

- (instancetype) initWithString:(NSString *)source;

@end

/*
 interface CSSStyleSheet : stylesheets::StyleSheet {
 readonly attribute CSSRule         ownerRule;
 readonly attribute CSSRuleList     cssRules;
 unsigned long                      insertRule(in DOMString rule, in unsigned long index) raises(dom::DOMException);
 void                               deleteRule(in unsigned long index) raises(dom::DOMException);
 };
*/