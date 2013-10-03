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
