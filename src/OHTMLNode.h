//
//  OHTMLNode.h
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCSSBaseList.h"
@class OHTMLDocument;

@interface OHTMLNodeList : OCSSBaseList
@end

@interface OHTMLNode : NSObject
@property (weak) OHTMLNode *parentNode;
@property (readonly) OHTMLNodeList *childNodes;
@property (weak) OHTMLDocument *ownerDocument;
- (OHTMLNode *) appendChild:(OHTMLNode*)newChild;
@end

@interface OHTMLCharacterData : OHTMLNode
@property NSString *data;
@end

@interface OHTMLTextNode : OHTMLCharacterData
@end

@interface OHTMLCDATASection : OHTMLTextNode
@end

@interface OHTMLCommentNode : OHTMLCharacterData
@end

@interface OHTMLAttr : OHTMLNode
@property NSString *name;
@property NSString *value;
@end
