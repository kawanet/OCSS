//
//  AIDeclaration.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCSSPrimitiveValue.h"

@interface OCXDeclaration : NSObject

@property (nonatomic) NSString *property;
@property OCSSPrimitiveValue *value;
@property (readonly) NSString *cssText;

@end
