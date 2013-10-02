//
//  AIMedia.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSMediaRule.h"
#import "OCSS.h"

@implementation OCSSMediaRule {
    OCMediaList *_media;
    OCSSRuleList *_cssRules;
}

- (NSString *)cssText {
    NSString *text = [NSString stringWithFormat:@"@media %@ {\n%@\n}\n", self.media.mediaText, self.cssRules.cssText];
    return text;
}

- (OCMediaList *)media {
    if (_media) return _media;
    return _media = [OCMediaList new];
}

- (OCSSRuleList *)cssRules {
    if (_cssRules) return _cssRules;
    return _cssRules = [OCSSRuleList new];
}

- (void) setCssRules:(OCSSRuleList *)rules {
    rules.parentRule = self;
    _cssRules = rules;
}

@end
