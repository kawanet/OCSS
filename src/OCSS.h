//
//  OCSS.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OCDOMTokenList.h"
#import "OCHTMLDocument.h"
#import "OCHTMLElement.h"
#import "OCLocation.h"
#import "OCMediaList.h"
#import "OCNode.h"
#import "OCSSCharsetRule.h"
#import "OCSSFontFaceRule.h"
#import "OCSSImportRule.h"
#import "OCSSKeyframesRule.h"
#import "OCSSMediaRule.h"
#import "OCSSPagesRule.h"
#import "OCSSPrimitiveValue.h"
#import "OCSSRule.h"
#import "OCSSRuleList.h"
#import "OCSSStyleDeclaration.h"
#import "OCSSStyleRule.h"
#import "OCSSStyleSheet.h"
#import "OCSSValue.h"
#import "OCStyleSheetList.h"

@interface OCSS : NSObject

@property (readonly) OCHTMLDocument *document;

- (instancetype) initWithContentsOfURL:(NSURL *)url;
- (void) addStyleSheetWithContentsOfURL:(NSURL *)url;
- (OCSSStyleDeclaration *) getComputedStyleForSelector:(NSString *)selector;

@end
