//
//  CSSPagesRule.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSPagesRule.h"
#import "OCSS.h"

@implementation OCSSPagesRule

- (unsigned short) type {
    return [OCSSRule PAGE_RULE];
}

- (NSString *)cssText {
    NSString *text = [NSString stringWithFormat:@"@pages %@ {\n%@ }\n", self.selectorText, self.style.cssText];
    return text;
}

@end
