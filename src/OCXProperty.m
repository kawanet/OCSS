//
//  AIDeclaration.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCXProperty.h"
#import "OCSS.h"

@implementation OCXProperty {
    NSString *_propertyName;
    OCSSPrimitiveValue *_propertyValue;
}

- (NSString *) propertyName {
    return _propertyName;
}

- (void) property:(NSString*)property {
    _propertyName = property ? property.lowercaseString : property;
}

- (OCSSPrimitiveValue *)value {
    if (_propertyValue) return _propertyValue;
    return _propertyValue = [OCSSPrimitiveValue new];
}

- (NSString *) cssText {
    return [NSString stringWithFormat:@"%@: %@;", self.propertyName, self.value.cssText];
}

@end
