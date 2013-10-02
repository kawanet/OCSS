//
//  OCNode.m
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCNode.h"

@implementation OCHTMLNodeList
@end

@implementation OCNode {
    OCHTMLNodeList *_childNodes;
}

- (OCHTMLNodeList *) childNodes {
    if (_childNodes) return _childNodes;
    return _childNodes = [OCHTMLNodeList new];
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
