//
//  OHTMLDocument.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCNode.h"
#import "OCHTMLElement.h"
#import "OCSSStyleSheet.h"
#import "OCStyleSheetList.h"
#import "OCLocation.h"

@interface OCHTMLDocumentFragment : OCNode
@end

@interface OCHTMLDocument : OCNode

@property OCStyleSheetList *styleSheets;
@property OCLocation *location;
@property (readonly) OCHTMLElement *body;

- (void) addStyleSheet:(OCSSStyleSheet *)styleSheet;

- (OCHTMLElement*)createElement:(NSString*)tagName;
- (OCHTMLDocumentFragment*)createDocumentFragment;
- (OCText*)createTextNode:(NSString*)data;
- (OCComment*)createComment:(NSString*)data;
- (OCCDATASection*)createCDATASection:(NSString*)data;
- (OCAttr*)createAttribute:(NSString*)name;

@end

// http://www.w3.org/TR/DOM-Level-2-Core/idl-definitions.html

/*
 interface Document : Node {
 readonly attribute DocumentType        doctype;
 readonly attribute DOMImplementation   implementation;
 readonly attribute Element             documentElement;
 Element                createElement(in DOMString tagName) raises (DOMException);
 DocumentFragment       createDocumentFragment();
 Text                   createTextNode(in DOMString data);
 Comment                createComment(in DOMString data);
 CDATASection           createCDATASection(in DOMString data) raises (DOMException);
 ProcessingInstruction  createProcessingInstruction(in DOMString target,  in  DOMString data) raises (DOMException);
 Attr                   createAttribute(in DOMString name) raises (DOMException);
 EntityReference        createEntityReference(in DOMString name) raises (DOMException);
 NodeList               getElementsByTagName(in DOMString tagname);
 Node                   importNode(in Node importedNode,  in  boolean deep) raises (DOMException);
 Element                createElementNS(in DOMString namespaceURI,  in  DOMString qualifiedName) raises (DOMException);
 Attr                   createAttributeNS(in DOMString namespaceURI,  in  DOMString qualifiedName) raises (DOMException);
 NodeList               getElementsByTagNameNS(in DOMString namespaceURI,  in  DOMString localName);
 Element                getElementById(in DOMString elementId);
 };
 */

// http://www.w3.org/TR/DOM-Level-2-HTML/idl-definitions.html

/*
 interface HTMLDocument : Document {
 attribute DOMString                title;
 readonly attribute DOMString       referrer;
 readonly attribute DOMString       domain;
 readonly attribute DOMString       URL;
 attribute HTMLElement              body;
 readonly attribute HTMLCollection  images;
 readonly attribute HTMLCollection  applets;
 readonly attribute HTMLCollection  links;
 readonly attribute HTMLCollection  forms;
 readonly attribute HTMLCollection  anchors;
 attribute DOMString                cookie; // raises(dom::DOMException) on setting
 
 void               open();
 void               close();
 void               write(in DOMString text);
 void               writeln(in DOMString text);
 NodeList           getElementsByName(in DOMString elementName);
 };
*/