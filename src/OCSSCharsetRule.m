//
//  CSSCharsetRule.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSCharsetRule.h"

@implementation OCSSCharsetRule

- (NSString *)cssText {
    NSString *text = [NSString stringWithFormat:@"@charset %@;\n", self.encoding];
    return text;
}

@end
