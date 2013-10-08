//
//  OCNamedNodeMap.h
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/08.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OCNode;

@interface OCNamedNodeMap : NSObject
- (OCNode *)getNamedItem:(NSString*)name;
- (OCNode *)setNamedItem:(OCNode*)node;
- (OCNode *)removeNamedItem:(NSString*)name;

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len;
- (id)objectForKeyedSubscript:(id)key;
- (void)setObject:(id)object forKeyedSubscript:(id)key;
@end

// http://www.w3.org/TR/DOM-Level-2-Core/idl-definitions.html

/*
 interface NamedNodeMap {
 Node               getNamedItem(in DOMString name);
 Node               setNamedItem(in Node arg) raises(DOMException);
 Node               removeNamedItem(in DOMString name) raises(DOMException);
 Node               item(in unsigned long index);
 readonly attribute unsigned long    length;
 Node               getNamedItemNS(in DOMString namespaceURI, in DOMString localName);
 Node               setNamedItemNS(in Node arg) raises(DOMException);
 Node               removeNamedItemNS(in DOMString namespaceURI, in DOMString localName) raises(DOMException);
 };
*/