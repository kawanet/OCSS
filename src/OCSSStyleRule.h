//
//  AIRule.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSBaseRule.h"
#import "OCSSDeclaration.h"
#import "OCSSSelectorList.h"
#import "OCSSStyleDeclaration.h"

@interface OCSSStyleRule : OCSSBaseRule

@property OCSSStyleDeclaration *declarations;
@property OCSSSelectorList *selectors;
@property (readonly) NSString *cssText;
@property (readonly) NSString *selectorText;

- (OCSSDeclaration *) declarationForProperty:(NSString *)property;

@end
