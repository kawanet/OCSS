//
//  CSSImportRule.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSImportRule.h"

@implementation OCSSImportRule

- (NSString *)cssText {
    NSString *text = [NSString stringWithFormat:@"@import %@;\n", self.href];
    return text;
}

@end
