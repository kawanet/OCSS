//
//  OCSSValue.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCSSValue : NSObject

@property NSString *cssText;

@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface CSSValue {
 
 // UnitTypes
 const unsigned short      CSS_INHERIT                    = 0;
 const unsigned short      CSS_PRIMITIVE_VALUE            = 1;
 const unsigned short      CSS_VALUE_LIST                 = 2;
 const unsigned short      CSS_CUSTOM                     = 3;
 
 attribute DOMString                cssText; // raises(dom::DOMException) on setting
 readonly attribute unsigned short  cssValueType;
 };
 */
