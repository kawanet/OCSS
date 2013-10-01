//
//  OHTMLDocument.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OHTMLNode.h"
#import "OHTMLElement.h"
#import "OCSSStyleSheet.h"
#import "OCSSStyleSheetList.h"
#import "OLocation.h"

@interface OHTMLDocumentFragment : OHTMLNode
@end

@interface OHTMLDocument : OHTMLNode

@property OCSSStyleSheetList *styleSheets;
@property OLocation *location;
@property (readonly) OHTMLElement *body;

- (void) addStyleSheet:(OCSSStyleSheet *)styleSheet;

- (OHTMLElement*)createElement:(NSString*)tagName;
- (OHTMLDocumentFragment*)createDocumentFragment;
- (OHTMLTextNode*)createTextNode:(NSString*)data;
- (OHTMLCommentNode*)createComment:(NSString*)data;
- (OHTMLCDATASection*)createCDATASection:(NSString*)data;
- (OHTMLAttr*)createAttribute:(NSString*)name;

@end
