//
//  AIDeclaration.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCXDeclaration.h"
#import "OCSS.h"

@implementation OCXDeclaration

- (NSString *) property {
    return _property;
}

- (void) property:(NSString*)property {
    _property = property ? property.lowercaseString : property;
}

- (NSString *) cssText {
    return [NSString stringWithFormat:@"%@: %@;", self.property, self.value.cssText];
}

@end
