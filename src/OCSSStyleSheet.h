//
//  AIStyleSheet.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSBaseRule.h"
#import "OCSSRuleList.h"

@class OHTMLDocument;

@interface OCSSStyleSheet : OCSSBaseMap

@property OCSSRuleList *rules;
@property (weak) OHTMLDocument *parentDocument;
@property NSURL* href;
@property (readonly) NSString *cssText;

- (instancetype) initWithString:(NSString *)source;

@end
