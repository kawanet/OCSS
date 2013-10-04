//
//  CSSParser.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCXParser.h"
#import "OCSS.h"
#import "OCX.h"

@implementation OCXParser {
    NSString *_source;
    NSInteger _cursor;
    NSInteger _length;
    NSError *_error;
}

static NSRegularExpression *_re_atargument;
static NSRegularExpression *_re_atrule;
static NSRegularExpression *_re_comments;
static NSRegularExpression *_re_selector;
static NSRegularExpression *_re_colon;
static NSRegularExpression *_re_semicolon;
static NSRegularExpression *_re_open;
static NSRegularExpression *_re_close;
static NSRegularExpression *_re_decl_property;
static NSRegularExpression *_re_decl_value;
static NSRegularExpression *_re_whitespace;

- (void) parseForStyleSheet:(OCSSStyleSheet *)stylesheet withString:(NSString*)source {
    _source = source;
    _cursor = 0;
    _length = source.length;
    
    [self whitespace];
    
    OCSSRuleList *rules = [self rules];
    
    stylesheet.cssRules = rules;
}

- (OCSSMediaRule*) atmedia {
    NSString *astr = [self atargument];
    
    if (![self open]) {
        // NSLog(@"@media missing '{'");
        return nil;
    }
    OCSSRuleList *rules = [self rules];
    if (![self close]) {
        // NSLog(@"@media missing '}'");
        return nil;
    }
    
    OCSSMediaRule *media = [OCSSMediaRule new];
    media.media.mediaText = [self trim:astr];
    media.cssRules = rules;
    return media;
}

- (OCSSImportRule*) atimport {
    NSString *astr = [self atargument];
    OCSSImportRule *import = [OCSSImportRule new];
    import.href = astr;
    [self semicolon];
    return import;
}

- (OCSSCharsetRule*) atcharset {
    NSString *astr = [self atargument];
    OCSSCharsetRule *charset = [OCSSCharsetRule new];
    charset.encoding = astr;
    [self semicolon];
    return charset;
}

- (OCSSKeyframesRule*) atkeyframes {
    NSString *astr = [self atargument];
    // NSLog(@"atkeyframes: %@", astr);
    
    if (![self open]) {
        // NSLog(@"@media missing '{'");
        return nil;
    }
    [self comments];
    OCSSRuleList *rules = [self rules];
    if (![self close]) {
        // NSLog(@"@media missing '}'");
        return nil;
    }
    
    OCSSKeyframesRule *keyframes = [OCSSKeyframesRule new];
    keyframes.name = astr;
    keyframes.cssRules = rules;
    return keyframes;
}

- (OCSSPagesRule*) atpages {
    NSString *astr = [self atargument];
    OCSSPagesRule *pages = [OCSSPagesRule new];
    pages.selectorText = astr;
    pages.style = [self declarations];
    return pages;
}

- (OCSSFontFaceRule*) atfontface {
    OCSSFontFaceRule *atrule = [OCSSFontFaceRule new];
    atrule.style = [self declarations];
    return atrule;
}

- (NSString *) atargument {
    NSError *error;
    if (!_re_atargument) _re_atargument = [NSRegularExpression regularExpressionWithPattern:@"^([^\\;\\{]+)" options:0 error:&error];
    NSString *str = [self match:_re_atargument];
    str = [self trim:str];
    return str;
}

- (id) atrule {
    NSError *error;
    if (!_re_atrule) _re_atrule = [NSRegularExpression regularExpressionWithPattern:@"^@[\\w\\-]+\\s*" options:0 error:&error];
    NSString *astr = [self match:_re_atrule];
    if (!astr) return nil;
    astr = [self trim:astr];
    
    if ([astr isEqualToString:@"@media"]) {
        OCSSMediaRule *media = [self atmedia];
        if (media) return media;
    } else if ([astr isEqualToString:@"@charset"]) {
        OCSSCharsetRule *charset = [self atcharset];
        if (charset) return charset;
    } else if([astr isEqualToString:@"@import"]) {
        OCSSImportRule *import = [self atimport];
        if (import) return import;
    } else if([astr hasSuffix:@"keyframes"]) {
        OCSSKeyframesRule *keyframes = [self atkeyframes];
        if (keyframes) return keyframes;
    } else if([astr isEqualToString:@"@page"]) {
        OCSSPagesRule *pages = [self atpages];
        if (pages) return pages;
    } else if([astr isEqualToString:@"@font-face"]) {
        OCSSFontFaceRule *fontface = [self atfontface];
        if (fontface) return fontface;
    }
    
    return nil;
}

- (OCSSStyleRule*) comments {
    NSError *error;
    if (!_re_comments) _re_comments = [NSRegularExpression regularExpressionWithPattern:@"^/\\*.*?\\*/\\s*" options:NSRegularExpressionDotMatchesLineSeparators error:&error];
    NSString *str = [self match:_re_comments];
    if (str) [self comments]; // loop
    return nil;
}

- (OCXSelectorList*) selector {
    NSError *error;
    if (!_re_selector) _re_selector = [NSRegularExpression regularExpressionWithPattern:@"^([^\\{\\}]+)" options:0 error:&error];
    NSString *matched = [self match:_re_selector];

    OCXSelectorList *selectors = [OCXSelectorList new];

    NSString *str1;
    for(str1 in [matched componentsSeparatedByString:@","]) {
        str1 = [self trim:str1];
        if (!str1.length) continue;
        OCXSelector *selector = [OCXSelector new];
        selector.selector = str1;
        [selectors addSelector:selector];
    }
    
    return selectors;
}

- (OCSSStyleRule*) rule {
    // selector
    OCXSelectorList *selectors = [self selector];
    if (!selectors) return nil;
    [self comments];
    
    // { property: value; ... }
    OCSSStyleDeclaration *declarations = [self declarations];
    
    OCSSStyleRule *rule = [OCSSStyleRule new];
    rule.selectors = selectors;
    rule.style = declarations;
    return rule;
}

- (NSString *) colon {
    NSError *error;
    if (!_re_colon) _re_colon = [NSRegularExpression regularExpressionWithPattern:@"^:\\s*" options:0 error:&error];
    NSString *matched = [self match:_re_colon];
    return matched;
}

- (NSString *) semicolon {
    NSError *error;
    if (!_re_semicolon) _re_semicolon = [NSRegularExpression regularExpressionWithPattern:@"^;\\s*" options:0 error:&error];
    NSString *matched = [self match:_re_semicolon];
    return matched;
}

- (NSString *) open {
    NSError *error;
    if (!_re_open) _re_open = [NSRegularExpression regularExpressionWithPattern:@"^\\{\\s*" options:0 error:&error];
    NSString *matched = [self match:_re_open];
    return matched;
}

- (NSString *) close {
    NSError *error;
    if (!_re_close) _re_close = [NSRegularExpression regularExpressionWithPattern:@"^\\}\\s*" options:0 error:&error];
    NSString *matched = [self match:_re_close];
    return matched;
}

- (OCXProperty *) declaration {
    NSError *error;
    
    // property
    if (!_re_decl_property) _re_decl_property = [NSRegularExpression regularExpressionWithPattern:@"^(\\*?[-\\/\\*\\w]+)\\s*" options:0 error:&error];
    NSString *pstr = [self match:_re_decl_property];
    if (!pstr) return nil;
    pstr = [self trim:pstr];
    
    // :
    if (![self colon]) {
        // NSLog(@"property missing ':'");
        return nil;
    }
    
    // value
    if (!_re_decl_value) _re_decl_value
= [NSRegularExpression regularExpressionWithPattern:@"^((?:'(?:\\'|.)*?'|\"(?:\"|.)*?\"|\\([^\\)]*?\\)|[^\\};])+)" options:NSRegularExpressionDotMatchesLineSeparators error:&error];
    NSString *vstr = [self match:_re_decl_value];
    if (!vstr) {
        // NSLog(@"property missing value");
        return nil;
    }
    
    // ;
    if (![self semicolon]) {
        // NSLog(@"property missing ';'");
        // return nil; // ignore
    }
    
    OCXProperty *decl = [OCXProperty new];
    decl.propertyName = pstr;
    decl.value.cssText = vstr;
    
    return decl;
}

- (OCSSStyleDeclaration *) declarations {
    if (![self open]) {
        // NSLog(@"missing '{'");
        return nil;
    }
    
    [self comments];
    OCXProperty *decl;
    OCSSStyleDeclaration *decls = [OCSSStyleDeclaration new];
    
    BOOL found = NO;
    while((decl = [self declaration])) {
        found = YES;
        [decls addDeclaration:decl];
        [self comments];
    }
    if (!found) return nil;
    
    [self comments];
    if (![self close]) {
        // NSLog(@"missing '}'");
    }
    [self comments];
    
    return decls;
}

- (unichar) nextChar {
    return [_source characterAtIndex:_cursor];
}

- (OCSSRuleList *) rules {
    [self whitespace];
    [self comments];
    
    BOOL found = NO;
    OCSSRuleList *rules = [OCSSRuleList new];
    
    while (_cursor < _length) {
        if (self.nextChar == '}') break;
        
        id media = [self atrule];
        if (media) {
            found = YES;
            [rules addRule:media];
        } else {
            OCSSStyleRule *style = [self rule];
            if (style) {
                found = YES;
                [rules addRule:style];
            } else {
                break;
            }
        }
        [self comments];
    }
    if (!found) return nil;
    [self comments];

    return rules;
}

- (NSString *) match:(NSRegularExpression *)regex {
    NSRange range = [regex rangeOfFirstMatchInString:_source options:0 range:NSMakeRange(_cursor, _length-_cursor)];
    if (!range.length) return nil;
    _cursor = range.location + range.length;
    NSString *matched = [_source substringWithRange:range];
    return matched;
}

- (NSString *) whitespace {
    NSError *error;
    if (!_re_whitespace) _re_whitespace= [NSRegularExpression regularExpressionWithPattern:@"^\\s*" options:0 error:&error];
    NSString *matched = [self match:_re_whitespace];
    return matched;
}

- (NSString *) trim:(NSString*)str {
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
