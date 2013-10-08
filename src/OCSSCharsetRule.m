//
//  OCSSCharsetRule.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSCharsetRule.h"

@implementation OCSSCharsetRule

- (unsigned short) type {
    return [OCSSRule CHARSET_RULE];
}

- (NSString *)cssText {
    NSString *text = [NSString stringWithFormat:@"@charset %@;\n", self.encoding];
    return text;
}

@end
