//
//  OHTMLElement.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCNode.h"

@class OCDOMTokenList;

@interface OCElement : OCNode
- (NSString *)tagName;
- (NSString *)getAttribute:(NSString*)name;
- (OCAttr *)getAttributeNode:(NSString*)name;
- (void)setAttributeNode:(OCAttr*)newAttr;
- (void)setAttribute:(NSString*)name, ...;
- (void)setAttribute:(NSString*)name withValue:(NSString*)value;
- (BOOL)hasAttribute:(NSString*)name;
@end

// http://www.w3.org/TR/DOM-Level-2-Core/idl-definitions.html

/*
 interface Element : Node {
 readonly attribute DOMString        tagName;
 DOMString          getAttribute(in DOMString name);
 void               setAttribute(in DOMString name, in DOMString value) raises (DOMException);
 void               removeAttribute(in DOMString name) raises (DOMException);
 Attr               getAttributeNode(in DOMString name);
 Attr               setAttributeNode(in Attr newAttr) raises (DOMException);
 Attr               removeAttributeNode(in Attr oldAttr) raises (DOMException);
 NodeList           getElementsByTagName(in DOMString name);
 DOMString          getAttributeNS(in DOMString namespaceURI, in DOMString localName);
 void               setAttributeNS(in DOMString namespaceURI, in DOMString qualifiedName, in DOMString value) raises (DOMException);
 void               removeAttributeNS(in DOMString namespaceURI, in DOMString localName) raises (DOMException);
 Attr               getAttributeNodeNS(in DOMString namespaceURI, in DOMString localName);
 Attr               setAttributeNodeNS(in Attr newAttr) raises (DOMException);
 NodeList           getElementsByTagNameNS(in DOMString namespaceURI, in DOMString localName);
 boolean            hasAttribute(in DOMString name);
 boolean            hasAttributeNS(in DOMString namespaceURI, in DOMString localName);
 };
 */

@interface OCHTMLElement : OCElement
@property (nonatomic) NSString* id;
@property (nonatomic) NSString* className;
@property (readonly) OCDOMTokenList* classList;
@property (nonatomic) NSString* innerText;
@property (readonly) NSString* outerHTML;
@property (readonly) NSString* innerHTML;
@end

// http://www.w3.org/TR/DOM-Level-2-HTML/idl-definitions.html

/*
 interface HTMLElement : Element {
 attribute DOMString       id;
 attribute DOMString       title;
 attribute DOMString       lang;
 attribute DOMString       dir;
 attribute DOMString       className;
 };
*/

// http://www.w3.org/TR/html5/dom.html#htmlunknownelement

@interface OCHTMLUnknownElement : OCHTMLElement

@end

/*
 interface HTMLUnknownElement : HTMLElement { };
*/
