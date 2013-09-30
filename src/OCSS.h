//
//  CSS.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OCSSBaseMap.h"
#import "OCSSBaseRule.h"
#import "OCSSCharsetRule.h"
#import "OCSSDeclaration.h"
#import "OCSSStyleDeclaration.h"
#import "OHTMLDocument.h"
#import "OCSSKeyframesRule.h"
#import "OLocation.h"
#import "OCSSMedia.h"
#import "OCSSMediaRule.h"
#import "OCSSPagesRule.h"
#import "OCSSParser.h"
#import "OCSSRuleList.h"
#import "OCSSSelector.h"
#import "OCSSSelectorList.h"
#import "OCSSStyleRule.h"
#import "OCSSStyleSheet.h"
#import "OCSSStyleSheetList.h"
#import "OCSSValue.h"

@interface OCSS : NSObject

@property (readonly) OHTMLDocument *document;

- (instancetype) initWithContentsOfURL:(NSURL *)url;
- (void) addStyleSheetWithContentsOfURL:(NSURL *)url;

@end
