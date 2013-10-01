//
//  OHTMLElement.h
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCHTMLNode.h"

@interface OCHTMLElement : OCHTMLNode

@property (nonatomic) NSString* id;
@property NSString* tagName;
@property NSString* className;
@property (readonly) NSMutableDictionary *attributes;
@property (nonatomic) NSString* innerText;
@property (readonly) NSString* outerHTML;
@property (readonly) NSString* innerHTML;

- (NSString *)getAttribute:(NSString*)name;
- (OCHTMLAttr *)getAttributeNode:(NSString*)name;
- (void)setAttributeNode:(OCHTMLAttr*)newAttr;
- (void)setAttribute:(NSString*)name, ...;
- (void)setAttribute:(NSString*)name withValue:(NSString*)value;
    
@end
