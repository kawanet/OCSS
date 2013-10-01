//
//  OHTMLNode.m
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OHTMLNode.h"

@implementation OHTMLNodeList 
@end

@implementation OHTMLNode {
    OHTMLNodeList *_childNodes;
}

- (OHTMLNodeList *) childNodes {
    if (_childNodes) return _childNodes;
    return _childNodes = [OHTMLNodeList new];
}

- (OHTMLNode *) appendChild:(OHTMLNode*)newChild {
    [self.childNodes.list addObject:newChild];
    return newChild;
}

@end

@implementation OHTMLCharacterData
@end

@implementation OHTMLTextNode
@end

@implementation OHTMLCDATASection
@end

@implementation OHTMLCommentNode
@end

@implementation OHTMLAttr
@end
