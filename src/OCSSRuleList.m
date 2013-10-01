//
//  CSSRuleList.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSRuleList.h"
#import "OCSSMediaRule.h"
#import "OCSSStyleRule.h"

@implementation OCSSRuleList

- (void) addRule:(id)rule {
    [self.list addObject:rule];
}

@end
