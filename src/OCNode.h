//
//  OCNode.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCXList.h"

@class OCDocument;
@class OCNamedNodeMap;

@interface OCNodeList : OCXList
@end

// http://www.w3.org/TR/DOM-Level-2-Core/idl-definitions.html

/*
 interface NodeList {
 Node                               item(in unsigned long index);
 readonly attribute unsigned long   length;
 };
 */

@interface OCNode : NSObject

+ (unsigned short) ELEMENT_NODE;
+ (unsigned short) ATTRIBUTE_NODE;
+ (unsigned short) TEXT_NODE;
+ (unsigned short) CDATA_SECTION_NODE;
+ (unsigned short) ENTITY_REFERENCE_NODE;
+ (unsigned short) ENTITY_NODE;
+ (unsigned short) PROCESSING_INSTRUCTION_NODE;
+ (unsigned short) COMMENT_NODE;
+ (unsigned short) DOCUMENT_NODE;
+ (unsigned short) DOCUMENT_TYPE_NODE;
+ (unsigned short) DOCUMENT_FRAGMENT_NODE;
+ (unsigned short) NOTATION_NODE;

@property (readonly) NSString *nodeName;
@property NSString *nodeValue;
@property (readonly) unsigned short nodeType;
@property (readonly) OCNodeList *childNodes;
@property (weak) OCDocument *ownerDocument;
- (instancetype) parentNode;
- (instancetype) firstChild;
- (instancetype) lastChild;
- (instancetype) previousSibling;
- (instancetype) nextSibling;
- (OCNamedNodeMap *) attributes;
- (instancetype) appendChild:(OCNode*)newChild;

- (instancetype) initWithName:(NSString *)name;

@end

/*
 interface Node {
 
 // NodeType
 const unsigned short      ELEMENT_NODE                   = 1;
 const unsigned short      ATTRIBUTE_NODE                 = 2;
 const unsigned short      TEXT_NODE                      = 3;
 const unsigned short      CDATA_SECTION_NODE             = 4;
 const unsigned short      ENTITY_REFERENCE_NODE          = 5;
 const unsigned short      ENTITY_NODE                    = 6;
 const unsigned short      PROCESSING_INSTRUCTION_NODE    = 7;
 const unsigned short      COMMENT_NODE                   = 8;
 const unsigned short      DOCUMENT_NODE                  = 9;
 const unsigned short      DOCUMENT_TYPE_NODE             = 10;
 const unsigned short      DOCUMENT_FRAGMENT_NODE         = 11;
 const unsigned short      NOTATION_NODE                  = 12;
 
 readonly attribute DOMString       nodeName;
 attribute DOMString                nodeValue;
 readonly attribute unsigned short  nodeType;
 readonly attribute Node            parentNode;
 readonly attribute NodeList        childNodes;
 readonly attribute Node            firstChild;
 readonly attribute Node            lastChild;
 readonly attribute Node            previousSibling;
 readonly attribute Node            nextSibling;
 readonly attribute NamedNodeMap    attributes;
 readonly attribute Document        ownerDocument;
 Node               insertBefore(in Node newChild, in  Node refChild) raises (DOMException);
 Node               replaceChild(in Node newChild, in  Node oldChild) raises (DOMException);
 Node               removeChild(in Node oldChild) raises (DOMException);
 Node               appendChild(in Node newChild) raises (DOMException);
 boolean            hasChildNodes();
 Node               cloneNode(in boolean deep);
 void               normalize();
 boolean            isSupported(in DOMString feature, in  DOMString version);
 readonly attribute DOMString       namespaceURI;
 attribute DOMString                prefix; // raises(DOMException) on setting
 readonly attribute DOMString       localName;
 boolean                            hasAttributes();
 };
 */

@interface OCCharacterData : OCNode
@property NSString *data;
@end

/*
 interface CharacterData : Node {
 attribute DOMString                data; // raises(DOMException) on setting // raises(DOMException) on retrieval
 readonly attribute unsigned long   length;
 DOMString          substringData(in unsigned long offset, in unsigned long count) raises(DOMException);
 void               appendData(in DOMString arg) raises(DOMException);
 void               insertData(in unsigned long offset, in DOMString arg) raises(DOMException);
 void               deleteData(in unsigned long offset, in unsigned long count) raises(DOMException);
 void               replaceData(in unsigned long offset, in unsigned long count, in DOMString arg) raises(DOMException);
 };
 */

@interface OCText : OCCharacterData
@end

/*
 interface Text : CharacterData {
 Text               splitText(in unsigned long offset) raises(DOMException);
 };
 */

@interface OCComment : OCCharacterData
@end

/*
 interface Comment : CharacterData {
 };
 */

@interface OCCDATASection : OCText
@end

/*
 interface CDATASection : Text {
 };
 */

@interface OCAttr : OCNode
@property (nonatomic,readonly) NSString *name;
@property (nonatomic) NSString *value;
@end

/*
 interface Attr : Node {
 readonly attribute DOMString       name;
 readonly attribute boolean         specified;
 attribute DOMString                value; // raises(DOMException) on setting
 readonly attribute Element         ownerElement;
 };
 */
