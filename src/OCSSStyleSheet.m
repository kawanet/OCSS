//
//  AIStyleSheet.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSStyleSheet.h"
#import "OCSSParser.h"

@implementation OCStyleSheet
@end

@implementation OCSSStyleSheet

- (instancetype) initWithString:(NSString *)source {
    self = self.init;
    OCSSParser *parser = OCSSParser.new;
    [parser parseForStyleSheet:self withString:source];
    return self;
}

- (NSString *)cssText {
    return self.cssRules.cssText;
}

@end
