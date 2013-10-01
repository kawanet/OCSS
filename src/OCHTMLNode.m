//
//  OHTMLNode.m
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCHTMLNode.h"

@implementation OCHTMLNodeList
@end

@implementation OCHTMLNode {
    OCHTMLNodeList *_childNodes;
}

- (OCHTMLNodeList *) childNodes {
    if (_childNodes) return _childNodes;
    return _childNodes = [OCHTMLNodeList new];
}

- (OCHTMLNode *) appendChild:(OCHTMLNode*)newChild {
    [self.childNodes.list addObject:newChild];
    return newChild;
}

@end

@implementation OCHTMLCharacterData
@end

@implementation OCHTMLTextNode
@end

@implementation OCHTMLCDATASection
@end

@implementation OCHTMLCommentNode
@end

@implementation OCHTMLAttr
@end
