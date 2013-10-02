//
//  OCSSelectorPart.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

enum {
    // http://www.w3.org/TR/CSS21/selector.html
    OCSSSelectorInvalid             = 'X',
    OCSSSelectorUniversal           = '*', // *
    OCSSSelectorType                = 'E', // E
    OCSSSelectorDescendant          = ' ', // E F
    OCSSSelectorChild               = '>', // E > F
    OCSSSelectorPseudoClass         = ':', // :pseudo
    OCSSSelectorAdjacent            = '+', // E + F
    OCSSSelectorAttributeExists     = '[', // [foo]
    OCSSSelectorAttributeIsEqual    = '=', // [foo="warning"]
    OCSSSelectorAttributeIncludes   = '~', // [foo~="warning"]
    OCSSSelectorAttributeBeginWith  = '|', // [lang|="en"]
    OCSSSelectorClass               = '.', // .class
    OCSSSelectorID                  = '#', // #id
};

@interface OCXSelectorPart : NSObject
@property NSUInteger type;
@property NSString *text;
@property NSString *arg;
@end

