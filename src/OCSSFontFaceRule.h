//
//  OCSSFontFaceRule.h
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSRule.h"
#import "OCSSStyleDeclaration.h"

@interface OCSSFontFaceRule : OCSSRule

@property OCSSStyleDeclaration *style;
- (NSString *)cssText;

@end
