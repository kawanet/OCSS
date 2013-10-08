//
//  OCStyleSheet.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCHTMLDocument;
@class OCMediaList;
@class OCSSRuleList;
@class OCSSStyleSheet;

@interface OCStyleSheet : NSObject

@property NSString* href;
@property OCMediaList* media;
@property (weak) OCSSStyleSheet *parentStyleSheet;

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

@property (nonatomic) OCSSRuleList *cssRules;
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
