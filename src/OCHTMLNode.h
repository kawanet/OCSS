//
//  OHTMLNode.h
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCList.h"
@class OCHTMLDocument;

@interface OCHTMLNodeList : OCList
@end

@interface OCHTMLNode : NSObject
@property (weak) OCHTMLNode *parentNode;
@property (readonly) OCHTMLNodeList *childNodes;
@property (weak) OCHTMLDocument *ownerDocument;
- (OCHTMLNode *) appendChild:(OCHTMLNode*)newChild;
@end

@interface OCHTMLCharacterData : OCHTMLNode
@property NSString *data;
@end

@interface OCHTMLTextNode : OCHTMLCharacterData
@end

@interface OCHTMLCDATASection : OCHTMLTextNode
@end

@interface OCHTMLCommentNode : OCHTMLCharacterData
@end

@interface OCHTMLAttr : OCHTMLNode
@property NSString *name;
@property NSString *value;
@end
