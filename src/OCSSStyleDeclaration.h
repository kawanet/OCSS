//
//  OCSSStyleDeclaration.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCList.h"
#import "OCDeclaration.h"

@interface OCSSStyleDeclaration : OCListCSS

- (void) addDeclaration:(OCDeclaration *)declaration;
- (id) objectForKeyedSubscript:(id)key;

@end

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