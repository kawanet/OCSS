//
//  OCStyleSheet.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSStyleSheet.h"
#import "OCSS.h"
#import "OCX.h"

@implementation OCStyleSheet
@end

@implementation OCSSStyleSheet {
    OCSSRuleList *_cssRules;
}

- (OCSSRuleList *)cssRules {
    if (_cssRules) return _cssRules;
    return _cssRules = [OCSSRuleList new];
}

- (void) cssRules:(OCSSRuleList *)cssRules {
    cssRules.parentStyleSheet = self;
    _cssRules = cssRules;
}

- (instancetype) initWithString:(NSString *)source {
    self = self.init;
    OCXParser *parser = [OCXParser new];
    [parser parseForStyleSheet:self withString:source];
    return self;
}

- (NSString *)cssText {
    return self.cssRules.cssText;
}

@end
