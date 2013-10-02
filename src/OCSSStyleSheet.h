//
//  AIStyleSheet.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCSSRuleList.h"

@class OCHTMLDocument;

@interface OCSSStyleSheet : NSObject

@property OCSSRuleList *cssRules;
@property (weak) OCHTMLDocument *parentDocument;
@property NSURL* href;
@property (readonly) NSString *cssText;

- (instancetype) initWithString:(NSString *)source;

@end
