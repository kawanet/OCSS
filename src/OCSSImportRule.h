//
//  CSSImportRule.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSRule.h"
#import "OCSSStyleSheet.h"
#import "OCMediaList.h"

@interface OCSSImportRule : OCSSRule

@property NSString *href;
@property OCMediaList *media;
@property OCSSStyleSheet *styleSheet;

@end

/*
 interface CSSImportRule : CSSRule {
 readonly attribute DOMString               href;
 readonly attribute stylesheets::MediaList  media;
 readonly attribute CSSStyleSheet           styleSheet;
 };
 */