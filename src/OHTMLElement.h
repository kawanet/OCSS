//
//  OHTMLElement.h
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OHTMLNode.h"

@interface OHTMLElement : OHTMLNode

@property (nonatomic) NSString* id;
@property NSString* tagName;
@property (readonly) NSMutableDictionary *attributes;
@property (nonatomic) NSString* innerText;
@property (readonly) NSString* outerHTML;
@property (readonly) NSString* innerHTML;

- (NSString *)getAttribute:(NSString*)name;
- (OHTMLAttr *)getAttributeNode:(NSString*)name;
- (void)setAttributeNode:(OHTMLAttr*)newAttr;
- (void)setAttribute:(NSString*)name, ...;
- (void)setAttribute:(NSString*)name withValue:(NSString*)value;
    
@end
