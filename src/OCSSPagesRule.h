//
//  CSSPagesRule.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSBaseRule.h"
#import "OCSSStyleDeclaration.h"

@interface OCSSPagesRule : OCSSBaseRule

@property NSString *selectorText;
@property OCSSStyleDeclaration *style;

@end
