//
//  CSSCharsetRule.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013年 Kawanet. All rights reserved.
//

#import "OCSSRule.h"

@interface OCSSCharsetRule : OCSSRule

@property NSString *encoding;

@end

/*
 interface CSSCharsetRule : CSSRule {
 attribute DOMString        encoding; // raises(dom::DOMException) on setting
 };
*/