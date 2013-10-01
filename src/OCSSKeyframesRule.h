//
//  CSSKeyframesRule.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSBaseRule.h"
#import "OCSSRuleList.h"

@interface OCSSKeyframesRule : OCSSBaseRule

@property NSString *name;
@property OCSSRuleList *cssRules;

@end
