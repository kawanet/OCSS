//
//  OCXSelector.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCXSelector.h"
#import "OCSS.h"
#import "OCX.h"

enum {
    OCXSelectorSpecificityStyle   = 1000000000,
    OCXSelectorSpecificityID      =   10000000,
    OCXSelectorSpecificityAttr    =     100000,
    OCXSelectorSpecificityTagName =       1000,
};

@implementation OCXSelector{
    NSArray *_parts;
    NSUInteger _specificity;
}

- (NSUInteger) specificity {
    if (_specificity) return _specificity;
    
    NSUInteger score = 0;
    for(OCXSelectorPart *part in self.parts) {
        switch (part.type) {
            case OCSSSelectorUniversal:         // *
            case OCSSSelectorDescendant:        // E F
                // skip
                break;
                
            case OCSSSelectorAttrExists:
            case OCSSSelectorAttrEq:
            case OCSSSelectorAttrTildEq:
            case OCSSSelectorAttrPipeEq:
            case OCSSSelectorAttrHatEq:         // E[foo^="bar"]
            case OCSSSelectorAttrDollarEq:      // E[foo$="bar"]
            case OCSSSelectorAttrStarEq:        // E[foo*="bar"]
            case OCSSSelectorPseudoClass:
            case OCSSSelectorClass:
                score += OCXSelectorSpecificityAttr;
                break;

            case OCSSSelectorID:                  // '#'  #id
                score += OCXSelectorSpecificityID;
                break;

            case OCSSSelectorType:              // E
            case OCSSSelectorChild:             // E > F
            case OCSSSelectorAdjacentSibling:   // E + F
            case OCSSSelectorGeneralSibling:    // E ~ F
                score += OCXSelectorSpecificityTagName;
                break;
        }
    }
    
    return _specificity = score;
}

static NSRegularExpression *_re_parts;

- (NSArray *)parts {
    if (_parts) return _parts;
    NSMutableArray *array = NSMutableArray.new;
    
    // NSLog(@"parts: %@", self.selector);

    if (!_re_parts) {
        NSError *error;
        NSString *pattern = @"\
        (?:\\s*([\\>\\+\\~])\\s*) \
        | (\\:\\:?[^\\.\\#\\:\\>\\+\\*\\[\\s\\(]+(?:\\([^\\)]*\\))?) \
        | \(\\s+) \
        | ([\\.\\#][^\\.\\#\\:\\>\\+\\*\\[\\s]+) \
        | (?:\\[ ([^\\=\\~\\|\\]]+) (?: ([\\~\\|]?=) (?: ([^\"'\\]]*|\"([^\"]*)\"|'([^']*)') ) )? \\]) \
        | ([^\\.\\#\\:\\>\\+\\*\\[\\s]+)";
        _re_parts = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionAllowCommentsAndWhitespace error:&error];
        if (error) {
            NSLog(@"[ERROR] %@", error);
        }
    }
    NSRange range = NSMakeRange(0, self.selector.length);
    
    __block NSUInteger count = 0;
    __weak NSString *source = self.selector;
    [_re_parts enumerateMatchesInString:self.selector options:0 range:range usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
        NSString *hitstr = [source substringWithRange:match.range];
        OCXSelectorPart *part = [OCXSelectorPart new];

        if ([match rangeAtIndex:1].length) {
            // (?:\\s*([\\>\\+\\~])\\s*)
            unichar char1 = [hitstr characterAtIndex:0];
            if (char1 == '>') {
                part.type = OCSSSelectorChild;              // E > F
            } else if (char1 == '+') {
                part.type = OCSSSelectorAdjacentSibling;    // E + F
            } else if (char1 == '~') {
                part.type = OCSSSelectorGeneralSibling;     // E ~ F
            }
        
        } else if ([match rangeAtIndex:2].length) {
            // (\\:\\:?[^\\.\\#\\:\\>\\+\\*\\[\\s]+(?:\\([^\\)]\\))?)
            part.type = OCSSSelectorPseudoClass;
            part.text = hitstr;

        } else if ([match rangeAtIndex:3].length) {
            // \(\\s+)
            part.type = OCSSSelectorDescendant;
        
        } else if ([match rangeAtIndex:4].length) {
            // ([\\.\\#][^\\.\\#\\:\\>\\+\\*\\[\\s]+) 
            unichar char4 = [hitstr characterAtIndex:0];
            if (char4 == '#') {
                part.type = OCSSSelectorID;
                part.text = [hitstr substringFromIndex:1];
            } else if (char4 == '.') {
                part.type = OCSSSelectorClass;
                part.text = [hitstr substringFromIndex:1];
            }
            
        } else if ([match rangeAtIndex:6].length) {
            // (?:\\[ ([^\\=\\~\\|\\]]+) (?: ([\\~\\|]?=) (?: ([^\"'\\]]*|\"([^\"]*)\"|'([^']*)') ) )? \\])
            NSRange range5 = [match rangeAtIndex:5];
            NSRange range6 = [match rangeAtIndex:6];
            NSRange range7 = [match rangeAtIndex:7];
            NSRange range8 = [match rangeAtIndex:8];
            NSRange range9 = [match rangeAtIndex:9];
            
            // attribute name
            part.text = [source substringWithRange:range5];
            part.text = part.text.lowercaseString;

            // comparison type
            unichar char6 = [source characterAtIndex:range6.location];
            if (char6 == '~') {
                part.type = OCSSSelectorAttrTildEq;     // [foo~="warning"]
            } else if (char6 == '^') {
                part.type = OCSSSelectorAttrHatEq;      // E[foo^="bar"]
            } else if (char6 == '$') {
                part.type = OCSSSelectorAttrDollarEq;   // E[foo$="bar"]
            } else if (char6 == '*') {
                part.type = OCSSSelectorAttrStarEq;     // E[foo*="bar"]
            } else if (char6 == '|') {
                part.type = OCSSSelectorAttrPipeEq;     // [lang|="en"]
            } else {
                part.type = OCSSSelectorAttrEq;         // [foo="warning"]
            }

            // attribute value
            if (!range7.length && range8.length) range7 = range8;
            if (!range7.length && range9.length) range7 = range9;
            part.arg = [source substringWithRange:range7];
            
        } else if ([match rangeAtIndex:5].length) {
            // (?:\\[ ([^\\=\\~\\|\\]]+) (?: ([\\~\\|]?=) (?: ([^\"'\\]]*|\"([^\"]*)\"|'([^']*)') ) )? \\])
            part.type = OCSSSelectorAttrExists;        // [foo]
            NSRange range5 = [match rangeAtIndex:5];

            // attribute name
            part.text = [source substringWithRange:range5];
            part.text = part.text.lowercaseString;

        } else {
            // ([^\\.\\#\\:\\>\\+\\*\\[\\s]+)
            part.type = OCSSSelectorType;
            part.text = hitstr.lowercaseString;
        }
        
        [array addObject:part];
        
        // NSLog(@"part: [%c] '%@' '%@' '%@'", part.type, part.text, part.arg, hitstr);
        if (++count >= 100) *stop = YES;
    }];
    
    return _parts = [NSArray arrayWithArray:array];
}

- (BOOL) isSelectedForElement:(OCHTMLElement*)element {
    NSArray *parts = [self parts];
    BOOL hit = NO;
    NSString *attr;
    NSString *attrHyphen;
    NSRange range;
    NSArray *array;
    for(int i=parts.count-1; i>=0; i--) {
        OCXSelectorPart *part = parts[i];
        switch (part.type) {
                
            case OCSSSelectorUniversal:
                // *	any element
                hit = YES;
                break;
                
            case OCSSSelectorType:
                // E	an element of type E
                hit = [element.tagName.lowercaseString isEqualToString:part.text];
                break;
                
            case OCSSSelectorAttrExists:
                // E[foo]	an E element with a "foo" attribute
                hit = [element hasAttribute:part.text];
                break;
                
            case OCSSSelectorAttrEq:
                // E[foo="bar"]	an E element whose "foo" attribute value is exactly equal to "bar"
                attr = [element getAttribute:part.text];
                hit = [attr isEqualToString:part.arg];
                break;
                
            case OCSSSelectorAttrTildEq:
                // E[foo~="bar"]	an E element whose "foo" attribute value is a list of whitespace-separated values, one of which is exactly equal to "bar"
                attr = [element getAttribute:part.text];
                hit = NO;
                if (range.length > 0) {
                    array = [attr componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    for(NSString *str in array) {
                        if (![str isEqualToString:part.arg]) continue;
                        hit = YES;
                        break;
                    }
                }
                hit = (range.length > 0);
                break;
                
            case OCSSSelectorAttrHatEq:
                // E[foo^="bar"]	an E element whose "foo" attribute value begins exactly with the string "bar"
                attr = [element getAttribute:part.text];
                hit = [attr hasPrefix:part.arg];
                break;
                
            case OCSSSelectorAttrDollarEq:
                // E[foo$="bar"]	an E element whose "foo" attribute value ends exactly with the string "bar"
                attr = [element getAttribute:part.text];
                hit = [attr hasSuffix:part.arg];
                break;
                
            case OCSSSelectorAttrStarEq:
                // E[foo*="bar"]	an E element whose "foo" attribute value contains the substring "bar"
                attr = [element getAttribute:part.text];
                range = [attr rangeOfString:part.arg];
                hit = (range.length > 0);
                break;
                
            case OCSSSelectorAttrPipeEq:
                // E[foo|="en"]	an E element whose "foo" attribute has a hyphen-separated list of values beginning (from the left) with "en"
                attr = [element getAttribute:part.text];
                attrHyphen = [attr stringByAppendingString:@"-"];
                hit = [attrHyphen hasPrefix:part.arg];
                if (!hit) hit = [attr isEqualToString:part.arg];
                break;
                
            case OCSSSelectorPseudoClass: // TODO:
                // E:pseudo-class
                hit = [element hasAttribute:part.text];
                break;
                
            case OCSSSelectorClass:
                // E.warning	an E element whose class is "warning" (the document language specifies how class is determined).
                hit = [element.classList contains:part.text];
                break;
                
            case OCSSSelectorID:
                // E#myid	an E element with ID equal to "myid".
                hit = [element.id isEqualToString:part.text];
                break;
                
            case OCSSSelectorDescendant:
                // E F	an F element descendant of an E element
                // TODO: search for more ancestors
                element = (OCHTMLElement*)element.parentNode;
                hit = !!element;
                break;
            
            case OCSSSelectorChild:
                // E > F	an F element child of an E element
                element = (OCHTMLElement*)element.parentNode;
                hit = !!element;
                break;
                
            case OCSSSelectorAdjacentSibling: // TODO:
                // E + F	an F element immediately preceded by an E element
                hit = NO;
                break;
                
            case OCSSSelectorGeneralSibling: // TODO:
                // E ~ F	an F element preceded by an E element
                hit = NO;
                break;
        }
        if (!hit) break;
        // NSLog(@"hit: [%c] '%@' '%@' '%@'", part.type, part.text, part.arg, element.tagName);
    }
    return hit;
}

@end
