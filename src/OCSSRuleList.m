//
//  CSSRuleList.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSRuleList.h"

@implementation OCSSRuleList

- (void) addRule:(id)rule {
    [self.list addObject:rule];
}

@end
