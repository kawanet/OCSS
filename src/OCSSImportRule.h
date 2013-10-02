//
//  CSSImportRule.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSRule.h"

@class OCMediaList;
@class OCSSStyleSheet;

@interface OCSSImportRule : OCSSRule

@property NSString *href;
@property OCMediaList *media;
@property OCSSStyleSheet *styleSheet;

@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface CSSImportRule : CSSRule {
 readonly attribute DOMString               href;
 readonly attribute stylesheets::MediaList  media;
 readonly attribute CSSStyleSheet           styleSheet;
 };
 */