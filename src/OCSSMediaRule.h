//
//  AIMedia.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSBaseRule.h"
#import "OCSSRuleList.h"

@interface OCSSMediaRule : OCSSBaseRule

@property (readonly) NSString *cssText;
@property OCSSRuleList *rules;
@property NSString *media;

@end
