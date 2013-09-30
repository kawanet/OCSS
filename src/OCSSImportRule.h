//
//  CSSImportRule.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013年 Kawanet. All rights reserved.
//

#import "OCSSBaseRule.h"
#import "OCSSStyleSheet.h"

@interface OCSSImportRule : OCSSBaseRule

@property NSString *href;
@property OCSSStyleSheet *styleSheet;

@end
