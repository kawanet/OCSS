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

const unsigned short      OC_ELEMENT_NODE                   = 1;
const unsigned short      OC_ATTRIBUTE_NODE                 = 2;
const unsigned short      OC_TEXT_NODE                      = 3;
const unsigned short      OC_CDATA_SECTION_NODE             = 4;
const unsigned short      OC_ENTITY_REFERENCE_NODE          = 5;
const unsigned short      OC_ENTITY_NODE                    = 6;
const unsigned short      OC_PROCESSING_INSTRUCTION_NODE    = 7;
const unsigned short      OC_COMMENT_NODE                   = 8;
const unsigned short      OC_DOCUMENT_NODE                  = 9;
const unsigned short      OC_DOCUMENT_TYPE_NODE             = 10;
const unsigned short      OC_DOCUMENT_FRAGMENT_NODE         = 11;
const unsigned short      OC_NOTATION_NODE                  = 12;

@implementation OCNode {
    OCNodeList *_childNodes;
}

- (OCNodeList *) childNodes {
    if (_childNodes) return _childNodes;
    return _childNodes = [OCNodeList new];
}

- (OCNode *) firstChild {
    OCNodeList *nodes = self.childNodes;
    return nodes.length ? nodes[0] : nil;
}

- (OCNode *) lastChild {
    OCNodeList *nodes = self.childNodes;
    return nodes.length ? nodes[nodes.length-1] : nil;
}

- (OCNode *) appendChild:(OCNode*)newChild {
    newChild.parentNode = self;
    newChild.ownerDocument = self.ownerDocument;
    [self.childNodes.list addObject:newChild];
    return newChild;
}

@end

@implementation OCCharacterData
@end

@implementation OCText
@end

@implementation OCCDATASection
@end

@implementation OCComment
@end

@implementation OCAttr
@end
