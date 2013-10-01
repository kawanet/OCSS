//
//  AIMedia.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSRule.h"
#import "OCSSRuleList.h"

@interface OCSSMediaRule : OCSSRule

@property (readonly) NSString *cssText;
@property OCSSRuleList *rules;
@property NSString *media;

@end
