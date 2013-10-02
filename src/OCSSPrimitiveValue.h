//
//  OCSSPrimitiveValue.h
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/02.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSValue.h"

@interface OCSSPrimitiveValue : OCSSValue

@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface CSSPrimitiveValue : CSSValue {
 
 // UnitTypes
 const unsigned short      CSS_UNKNOWN                    = 0;
 const unsigned short      CSS_NUMBER                     = 1;
 const unsigned short      CSS_PERCENTAGE                 = 2;
 const unsigned short      CSS_EMS                        = 3;
 const unsigned short      CSS_EXS                        = 4;
 const unsigned short      CSS_PX                         = 5;
 const unsigned short      CSS_CM                         = 6;
 const unsigned short      CSS_MM                         = 7;
 const unsigned short      CSS_IN                         = 8;
 const unsigned short      CSS_PT                         = 9;
 const unsigned short      CSS_PC                         = 10;
 const unsigned short      CSS_DEG                        = 11;
 const unsigned short      CSS_RAD                        = 12;
 const unsigned short      CSS_GRAD                       = 13;
 const unsigned short      CSS_MS                         = 14;
 const unsigned short      CSS_S                          = 15;
 const unsigned short      CSS_HZ                         = 16;
 const unsigned short      CSS_KHZ                        = 17;
 const unsigned short      CSS_DIMENSION                  = 18;
 const unsigned short      CSS_STRING                     = 19;
 const unsigned short      CSS_URI                        = 20;
 const unsigned short      CSS_IDENT                      = 21;
 const unsigned short      CSS_ATTR                       = 22;
 const unsigned short      CSS_COUNTER                    = 23;
 const unsigned short      CSS_RECT                       = 24;
 const unsigned short      CSS_RGBCOLOR                   = 25;
 
 readonly attribute unsigned short  primitiveType;
 void               setFloatValue(in unsigned short unitType, in float floatValue) raises(dom::DOMException);
 float              getFloatValue(in unsigned short unitType) raises(dom::DOMException);
 void               setStringValue(in unsigned short stringType, in DOMString stringValue) raises(dom::DOMException);
 DOMString          getStringValue() raises(dom::DOMException);
 Counter            getCounterValue() raises(dom::DOMException);
 Rect               getRectValue() raises(dom::DOMException);
 RGBColor           getRGBColorValue() raises(dom::DOMException);
 };
 
 // Introduced in DOM Level 2:
 interface CSSValueList : CSSValue {
 readonly attribute unsigned long   length;
 CSSValue                           item(in unsigned long index);
 };
 
 // Introduced in DOM Level 2:
 interface RGBColor {
 readonly attribute CSSPrimitiveValue  red;
 readonly attribute CSSPrimitiveValue  green;
 readonly attribute CSSPrimitiveValue  blue;
 };
 
 // Introduced in DOM Level 2:
 interface Rect {
 readonly attribute CSSPrimitiveValue  top;
 readonly attribute CSSPrimitiveValue  right;
 readonly attribute CSSPrimitiveValue  bottom;
 readonly attribute CSSPrimitiveValue  left;
 };
 
 // Introduced in DOM Level 2:
 interface Counter {
 readonly attribute DOMString        identifier;
 readonly attribute DOMString        listStyle;
 readonly attribute DOMString        separator;
 };
 */