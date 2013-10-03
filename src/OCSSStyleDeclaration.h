//
//  OCSSStyleDeclaration.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCXList.h"

@class OCSSRule;
@class OCXProperty;

@interface OCSSStyleDeclaration : OCXListCSS

@property (weak) OCSSRule *parentRule;
- (NSString *) getPropertyValue:(NSString *)propertyName1;
- (NSString *) removeProperty:(NSString *)propertyName1;
- (void) setProperty:(NSString *)propertyName1, ...;
- (void) addDeclaration:(OCXProperty *)declaration;
- (id) objectForKeyedSubscript:(id)key;
@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface CSSStyleDeclaration {
 attribute DOMString                cssText; // raises(dom::DOMException) on setting
 DOMString                          getPropertyValue(in DOMString propertyName);
 CSSValue                           getPropertyCSSValue(in DOMString propertyName);
 DOMString                          removeProperty(in DOMString propertyName) raises(dom::DOMException);
 DOMString                          getPropertyPriority(in DOMString propertyName);
 void                               setProperty(in DOMString propertyName, in DOMString value, in DOMString priority) raises(dom::DOMException);
 readonly attribute unsigned long   length;
 DOMString                          item(in unsigned long index);
 readonly attribute CSSRule         parentRule;
 };
 */
