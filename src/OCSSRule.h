//
//  OCSSRule.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCSSStyleSheet;

@interface OCSSRule : NSObject

@property (readonly) NSString *cssText;
@property (weak) OCSSStyleSheet *parentStyleSheet;
@property (weak) OCSSRule *parentRule;

@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface CSSRule {
 
 // RuleType
 const unsigned short      UNKNOWN_RULE                   = 0;
 const unsigned short      STYLE_RULE                     = 1;
 const unsigned short      CHARSET_RULE                   = 2;
 const unsigned short      IMPORT_RULE                    = 3;
 const unsigned short      MEDIA_RULE                     = 4;
 const unsigned short      FONT_FACE_RULE                 = 5;
 const unsigned short      PAGE_RULE                      = 6;
 
 readonly attribute unsigned short      type;
 attribute DOMString                    cssText; // raises(dom::DOMException) on setting
 readonly attribute CSSStyleSheet       parentStyleSheet;
 readonly attribute CSSRule             parentRule;
 };
 */

@interface OCSSUnknownRule : OCSSRule

@end

/*
 interface CSSUnknownRule : CSSRule {
 };
*/
