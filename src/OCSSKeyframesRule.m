//
//  CSSKeyframesRule.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSKeyframesRule.h"

@implementation OCSSKeyframesRule

- (NSString *)cssText {
    NSString *text = [NSString stringWithFormat:@"@keyframes %@ {\n%@}\n", self.name, self.cssRules.cssText];
    return text;
}

@end
