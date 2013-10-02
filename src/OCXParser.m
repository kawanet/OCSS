//
//  CSSParser.m
//  AttributedImages
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

- (void) parseForStyleSheet:(OCSSStyleSheet *)stylesheet withString:(NSString*)source {
    _source = source;
    _cursor = 0;
    _length = source.length;
    
    [self whitespace];
    
    OCSSRuleList *rules = [self rules];
    
    // NSLog(@"parseForStyleSheet: %i / %i\n%@", _cursor, _length, [_source substringFromIndex:_cursor]);
    
    stylesheet.cssRules = rules;
}

- (OCSSMediaRule*) atmedia {
    NSString *astr = [self atargument];
    // NSLog(@"atmedia: %@", astr);
    
    if (![self open]) {
        // NSLog(@"@media missing '{'");
        return nil;
    }
    OCSSRuleList *rules = [self rules];
    if (![self close]) {
        // NSLog(@"@media missing '}'");
        return nil;
    }
    
    OCSSMediaRule *media = OCSSMediaRule.new;
    media.media.mediaText = [self trim:astr];
    media.cssRules = rules;
    return media;
}

- (OCSSImportRule*) atimport {
    NSString *astr = [self atargument];
    // NSLog(@"atimport: %@", astr);
    
    OCSSImportRule *import = OCSSImportRule.new;
    import.href = astr;
    
    [self semicolon];
    return import;
}

- (OCSSCharsetRule*) atcharset {
    NSString *astr = [self atargument];
    // NSLog(@"atcharset: %@", astr);
    
    OCSSCharsetRule *charset = OCSSCharsetRule.new;
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
    
    OCSSKeyframesRule *keyframes = OCSSKeyframesRule.new;
    keyframes.name = astr;
    keyframes.cssRules = rules;
    return keyframes;
}

- (OCSSPagesRule*) atpages {
    NSString *astr = [self atargument];
    // NSLog(@"atpages: %@", astr);
    OCSSPagesRule *pages = OCSSPagesRule.new;
    pages.selectorText = astr;
    pages.style = [self declarations];
    return pages;
}

- (OCSSFontFaceRule*) atfontface {
    OCSSFontFaceRule *atrule = OCSSFontFaceRule.new;
    atrule.style = [self declarations];
    return atrule;
}

- (NSString *) atargument {
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^([^\\;\\{]+)" options:0 error:&error];
    NSString *str = [self match:regex];
    str = [self trim:str];
    return str;
}

- (id) atrule {
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^@[\\w\\-]+\\s*" options:0 error:&error];
    NSString *astr = [self match:regex];
    if (!astr) return nil;
    astr = [self trim:astr];
    // NSLog(@"atrule: %@", astr);
    
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
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^/\\*.*?\\*/\\s*" options:NSRegularExpressionDotMatchesLineSeparators error:&error];
    NSString *str = [self match:regex];
    if (str) [self comments]; // loop
    return nil;
}

- (OCXSelectorList*) selector {
    // NSLog(@"selector: %i", _cursor);
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^([^\\{\\}]+)" options:0 error:&error];
    NSString *matched = [self match:regex];

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
    // NSLog(@"rule: %i", _cursor);
    
    // selector
    OCXSelectorList *selectors = [self selector];
    if (!selectors) return nil;
    [self comments];
    
    // { property: value; ... }
    OCSSStyleDeclaration *declarations = [self declarations];
    
    OCSSStyleRule *rule = OCSSStyleRule.new;
    rule.selectors = selectors;
    rule.style = declarations;
    return rule;
}

- (NSString *) colon {
    // NSLog(@"colon: %i", _cursor);
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^:\\s*" options:0 error:&error];
    NSString *matched = [self match:regex];
    return matched;
}

- (NSString *) semicolon {
    // NSLog(@"semicolon: %i", _cursor);
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^;\\s*" options:0 error:&error];
    NSString *matched = [self match:regex];
    return matched;
}

- (NSString *) open {
    // NSLog(@"open: %i", _cursor);
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\{\\s*" options:0 error:&error];
    NSString *matched = [self match:regex];
    return matched;
}

- (NSString *) close {
    // NSLog(@"close: %i", _cursor);
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\}\\s*" options:0 error:&error];
    NSString *matched = [self match:regex];
    return matched;
}

- (OCXDeclaration *) declaration {
    // NSLog(@"declaration: %i", _cursor);
    NSError *error;
    NSRegularExpression *regex;
    
    // property
    regex = [NSRegularExpression regularExpressionWithPattern:@"^(\\*?[-\\/\\*\\w]+)\\s*" options:0 error:&error];
    NSString *pstr = [self match:regex];
    if (!pstr) return nil;
    pstr = [self trim:pstr];
    
    // :
    if (![self colon]) {
        // NSLog(@"property missing ':'");
        return nil;
    }
    
    // value
    regex = [NSRegularExpression regularExpressionWithPattern:@"^((?:'(?:\\'|.)*?'|\"(?:\"|.)*?\"|\\([^\\)]*?\\)|[^\\};])+)" options:NSRegularExpressionDotMatchesLineSeparators error:&error];
    NSString *vstr = [self match:regex];
    if (!vstr) {
        // NSLog(@"property missing value");
        return nil;
    }
    
    // ;
    if (![self semicolon]) {
        // NSLog(@"property missing ';'");
        // return nil; // ignore
    }
    
    // NSLog(@"%@: %@;", pstr, vstr);
    OCXDeclaration *decl = [OCXDeclaration new];
    OCSSPrimitiveValue *value = [OCSSPrimitiveValue new];
    value.cssText = vstr;
    decl.property = pstr;
    decl.value = value;
    
    return decl;
}

- (OCSSStyleDeclaration *) declarations {
    // NSLog(@"declarations: %i", _cursor);
    if (![self open]) {
        // NSLog(@"missing '{'");
        return nil;
    }
    
    [self comments];
    OCXDeclaration *decl;
    OCSSStyleDeclaration *decls = OCSSStyleDeclaration.new;
    
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
    // NSLog(@"rules: %i < %i", _cursor, _length);
    [self whitespace];
    [self comments];
    
    BOOL found = NO;
    OCSSRuleList *rules = OCSSRuleList.new;
    
    while (_cursor < _length) {
        // NSLog(@"rules: %i < %i", _cursor, _length);
        
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
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\s*" options:0 error:&error];
    NSString *matched = [self match:regex];
    return matched;
}

- (NSString *) trim:(NSString*)str {
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
