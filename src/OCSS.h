//
//  OCSS.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OCSSRule.h"
#import "OCSSCharsetRule.h"
#import "OCXDeclaration.h"
#import "OCSSStyleDeclaration.h"
#import "OCHTMLDocument.h"
#import "OCSSKeyframesRule.h"
#import "OCLocation.h"
#import "OCSSMediaRule.h"
#import "OCSSPagesRule.h"
#import "OCXParser.h"
#import "OCSSRuleList.h"
#import "OCXSelector.h"
#import "OCXSelectorList.h"
#import "OCSSStyleRule.h"
#import "OCSSStyleSheet.h"
#import "OCStyleSheetList.h"
#import "OCSSValue.h"

@interface OCSS : NSObject

@property (readonly) OCHTMLDocument *document;

- (instancetype) initWithContentsOfURL:(NSURL *)url;
- (void) addStyleSheetWithContentsOfURL:(NSURL *)url;
- (OCSSStyleDeclaration *) getComputedStyleForSelector:(NSString *)selector;

@end
