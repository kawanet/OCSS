//
//  OCSSelectorPart.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    // http://www.w3.org/TR/CSS2/selector.html
    // http://www.w3.org/TR/css3-selectors/#selectors

    OCSSSelectorUniversal           = '*', // *
    OCSSSelectorType                = 'E', // E

    OCSSSelectorAttrExists          = '[', // [foo]
    OCSSSelectorAttrEq              = '=', // [foo="warning"]
    OCSSSelectorAttrTildEq          = 't', // [foo~="warning"]
    OCSSSelectorAttrHatEq           = 'h', // E[foo^="bar"]
    OCSSSelectorAttrDollarEq        = 'd', // E[foo$="bar"]
    OCSSSelectorAttrStarEq          = 's', // E[foo*="bar"]
    OCSSSelectorAttrPipeEq          = 'p', // [lang|="en"]
    
    OCSSSelectorPseudoClass         = ':', // :pseudo

    OCSSSelectorClass               = '.', // .class
    OCSSSelectorID                  = '#', // #id

    OCSSSelectorDescendant          = ' ', // E F
    OCSSSelectorChild               = '>', // E > F
    OCSSSelectorAdjacentSibling     = '+', // E + F
    OCSSSelectorGeneralSibling      = '~', // E ~ F
};

@interface OCXSelectorPart : NSObject
@property NSUInteger type;
@property NSString *text;
@property NSString *arg;
@end

