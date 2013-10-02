//
//  AIDeclaration.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCSSPrimitiveValue;
@class OCSSStyleDeclaration;

@interface OCXDeclaration : NSObject

@property (nonatomic) NSString *property;
@property OCSSPrimitiveValue *value;
@property (readonly) NSString *cssText;
@property (weak) OCSSStyleDeclaration *parentStyleDeclaration;

@end
