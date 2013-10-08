//
//  OCNode.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCNode.h"
#import "OCSS.h"

@implementation OCNodeList
@end

@implementation OCNode {
    OCNodeList *_childNodes;
    __weak OCNode *_parentNode;
    OCNamedNodeMap *_attributes;
    __weak OCDocument *_ownerDocument;
}

+ (unsigned short) ELEMENT_NODE { return 1; }
+ (unsigned short) ATTRIBUTE_NODE { return 2; }
+ (unsigned short) TEXT_NODE { return 3; }
+ (unsigned short) CDATA_SECTION_NODE { return 4; }
+ (unsigned short) ENTITY_REFERENCE_NODE { return 5; }
+ (unsigned short) ENTITY_NODE { return 6; }
+ (unsigned short) PROCESSING_INSTRUCTION_NODE { return 7; }
+ (unsigned short) COMMENT_NODE { return 8; }
+ (unsigned short) DOCUMENT_NODE { return 9; }
+ (unsigned short) DOCUMENT_TYPE_NODE { return 10; }
+ (unsigned short) DOCUMENT_FRAGMENT_NODE { return 11; }
+ (unsigned short) NOTATION_NODE { return 12; }

- (instancetype) parentNode {
    return _parentNode;
}

// private
- (void) setParentNode:(OCNode*)parentNode {
    _parentNode = parentNode;
}

- (OCNodeList *) childNodes {
    if (_childNodes) return _childNodes;
    return _childNodes = [OCNodeList new];
}

- (OCDocument *) ownerDocument {
    return _ownerDocument;
}

// private
- (void) setOwnerDocument:(OCDocument *)ownerDocument {
    _ownerDocument = ownerDocument;
}

- (instancetype) firstChild {
    OCNodeList *nodes = self.childNodes;
    return nodes.length ? nodes[0] : nil;
}

- (instancetype) lastChild {
    OCNodeList *nodes = self.childNodes;
    return nodes.length ? nodes[nodes.length-1] : nil;
}

- (instancetype) previousSibling {
    OCNode *parent = self.parentNode;
    NSUInteger index = [parent.childNodes.list indexOfObject:self];
    if (index > 0) {
        index --;
        return parent.childNodes.list[index];
    } else {
        return nil; // == 0 or NSNotFound
    }
}

- (instancetype) nextSibling {
    OCNode *parent = self.parentNode;
    NSUInteger index = [parent.childNodes.list indexOfObject:self];
    index ++;
    if (index < parent.childNodes.length) {
        return parent.childNodes.list[index];
    } else {
        return nil; // >= length or NSNotFound
    }
}

- (OCNamedNodeMap *) attributes {
    if (_attributes) return _attributes;
    return _attributes = [OCNamedNodeMap new];
}

- (instancetype) appendChild:(OCNode*)newChild {
    newChild.parentNode = self;
    newChild.ownerDocument = self.ownerDocument;
    [self.childNodes.list addObject:newChild];
    return newChild;
}

- (instancetype) initWithName:(NSString *)name {
    self = [self init];
    _nodeName = name;
    return self;
}

@end

@implementation OCCharacterData
@end

@implementation OCText
- (unsigned short) nodeType {
    return [OCNode ELEMENT_NODE];
}
@end

@implementation OCCDATASection
- (unsigned short) nodeType {
    return [OCNode CDATA_SECTION_NODE];
}
@end

@implementation OCComment
- (unsigned short) nodeType {
    return [OCNode COMMENT_NODE];
}
@end

@implementation OCAttr
- (unsigned short) nodeType {
    return [OCNode ATTRIBUTE_NODE];
}

- (NSString *) name {
    return self.nodeName;
}
- (NSString *) value {
    return self.nodeValue;
}
- (void) setValue:(NSString *)value {
    self.nodeValue = value;
}

@end
