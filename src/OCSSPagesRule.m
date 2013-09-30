//
//  CSSPagesRule.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSPagesRule.h"

@implementation OCSSPagesRule

- (NSString *)cssText {
    NSString *text = [NSString stringWithFormat:@"@pages %@ {\n%@ }\n", self.selectorText, self.style.cssText];
    return text;
}

@end
