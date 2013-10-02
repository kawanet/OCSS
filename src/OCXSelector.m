//
//  OCSSSelector.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCXSelector.h"
#import "OCSS.h"
#import "OCX.h"

@implementation OCXSelector{
    NSArray *_parts;
}

- (NSArray *)parts {
    if (_parts) return _parts;
    NSMutableArray *array = NSMutableArray.new;
    
    // NSLog(@"parts: %@", self.selector);

    NSError *error;
    NSString *pattern = @"(\\s*\\>\\s*) | (\\s*\\+\\s*) | (\\s+) | ([\\.\\#\\:][^\\.\\#\\:\\>\\+\\*\\[\\s]+) | (?:\\[ ([^\\=\\~\\|\\]]+) (?: ([\\~\\|]?=) (?: ([^\"'\\]]*|\"([^\"]*)\"|'([^']*)') ) )? \\]) | ([^\\.\\#\\:\\>\\+\\*\\[\\s]+)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionAllowCommentsAndWhitespace error:&error];
    NSRange range = NSMakeRange(0, self.selector.length);
    
    __block NSUInteger count = 0;
    __weak NSString *source = self.selector;
    [regex enumerateMatchesInString:self.selector options:0 range:range usingBlock:^(NSTextCheckingResult *match, NSMatchingFlags flags, BOOL *stop){
        NSString *hitstr = [source substringWithRange:match.range];
        OCXSelectorPart *part = [OCXSelectorPart new];

        if ([match rangeAtIndex:1].length) {
            part.type = OCSSSelectorChild;
        } else if ([match rangeAtIndex:2].length) {
            part.type = OCSSSelectorAdjacent;
        } else if ([match rangeAtIndex:3].length) {
            part.type = OCSSSelectorDescendant;
        } else if ([match rangeAtIndex:4].length) {
            unichar char4 = [hitstr characterAtIndex:0];
            if (char4 == '#') {
                part.type = OCSSSelectorID;
                part.text = [hitstr substringFromIndex:1];
            } else if (char4 == ':') {
                part.type = OCSSSelectorPseudoClass;
                part.text = [hitstr substringFromIndex:1];
            } else if (char4 == '.') {
                part.type = OCSSSelectorClass;
                part.text = [hitstr substringFromIndex:1];
            }
        } else if ([match rangeAtIndex:6].length) {
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
                part.type = OCSSSelectorAttributeIncludes;  // [foo~="warning"]
            } else if (char6 == '|') {
                part.type = OCSSSelectorAttributeBeginWith; // [lang|="en"]
            } else {
                part.type = OCSSSelectorAttributeIsEqual;   // [foo="warning"]
            }

            // attribute value
            if (!range7.length && range8.length) range7 = range8;
            if (!range7.length && range9.length) range7 = range9;
            part.arg = [source substringWithRange:range7];
            
        } else if ([match rangeAtIndex:5].length) {
            part.type = OCSSSelectorAttributeExists;        // [foo]
            NSRange range5 = [match rangeAtIndex:5];

            // attribute name
            part.text = [source substringWithRange:range5];
            part.text = part.text.lowercaseString;

        } else {
            part.type = OCSSSelectorType;
            part.text = hitstr.lowercaseString;
        }
        
        [array addObject:part];
        
       // NSLog(@"part: [%c] '%@' '%@' '%@'", part.type, part.text, part.arg, hitstr);
        if (++count >= 100) *stop = YES;
    }];
    
    if (error) {
        NSLog(@"[ERROR] %@", error);
    }
    return _parts = [NSArray arrayWithArray:array];
}

- (BOOL) isSelectedForElement:(OCHTMLElement*)element {
    NSArray *parts = [self parts];
    BOOL hit = NO;
    for(int i=parts.count-1; i>=0; i--) {
        OCXSelectorPart *part = parts[i];
        switch (part.type) {
            case OCSSSelectorUniversal:           // '*'  *
                hit = YES;
                break;
            case OCSSSelectorType:                // 'E'  E
                hit = [element.tagName.lowercaseString isEqualToString:part.text];
                break;
            case OCSSSelectorDescendant:          // ' '  E F
                element = (OCHTMLElement*)element.parentNode;
                hit = !!element;
                break;
            case OCSSSelectorChild:               // '>'  E > F
                element = (OCHTMLElement*)element.parentNode;
                hit = !!element;
                break;
            case OCSSSelectorPseudoClass:         // ':'  :pseudo
                hit = NO; // TODO:
                break;
            case OCSSSelectorAdjacent:            // '+'  E + F
                hit = NO; // TODO:
                break;
            case OCSSSelectorAttributeExists:     // '['  [foo]
                hit = NO; // TODO:
                break;
            case OCSSSelectorAttributeIsEqual:    // '='  [foo="warning"]
                hit = NO; // TODO:
                break;
            case OCSSSelectorAttributeIncludes:   // '~'  [foo~="warning"]
                hit = NO; // TODO:
                break;
            case OCSSSelectorAttributeBeginWith:  // '|'  [lang|="en"]
                hit = NO; // TODO:
                break;
            case OCSSSelectorClass:               // '.'  .class
                hit = [element.classList contains:part.text];
                break;
            case OCSSSelectorID:                  // '#'  #id
                hit = [element.id isEqualToString:part.text];
                break;
        }
        if (!hit) break;
        // NSLog(@"hit: [%c] '%@' '%@' '%@'", part.type, part.text, part.arg, element.tagName);
    }
    return hit;
}

@end
