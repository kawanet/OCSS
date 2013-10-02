//
//  OHTMLDocument.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCHTMLNode.h"
#import "OCHTMLElement.h"
#import "OCSSStyleSheet.h"
#import "OCStyleSheetList.h"
#import "OCLocation.h"

@interface OCHTMLDocumentFragment : OCHTMLNode
@end

@interface OCHTMLDocument : OCHTMLNode

@property OCStyleSheetList *styleSheets;
@property OCLocation *location;
@property (readonly) OCHTMLElement *body;

- (void) addStyleSheet:(OCSSStyleSheet *)styleSheet;

- (OCHTMLElement*)createElement:(NSString*)tagName;
- (OCHTMLDocumentFragment*)createDocumentFragment;
- (OCHTMLTextNode*)createTextNode:(NSString*)data;
- (OCHTMLCommentNode*)createComment:(NSString*)data;
- (OCHTMLCDATASection*)createCDATASection:(NSString*)data;
- (OCHTMLAttr*)createAttribute:(NSString*)name;

@end
