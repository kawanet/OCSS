//
//  OCSSRuleList.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSRuleList.h"
#import "OCSS.h"

@implementation OCSSRuleList

- (void) addRule:(OCSSRule *)rule {
    rule.parentStyleSheet = self.parentStyleSheet;
    rule.parentRule = self.parentRule;
    [self.list addObject:rule];
}

- (NSString *) delimiter {
    return @"\n";
}

@end
