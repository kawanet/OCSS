//
//  AIMedia.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSMediaRule.h"
#import "OCSSRuleList.h"

@implementation OCSSMediaRule

- (NSString *)cssText {
    NSString *text = [NSString stringWithFormat:@"@media %@ {\n%@}\n", self.media, self.rules.cssText];
    return text;
}

@end
