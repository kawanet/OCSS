//
//  AIDeclaration.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCMap.h"
#import "OCSSValue.h"

@interface OCSSDeclaration : OCMap

@property (nonatomic) NSString *property;
@property OCSSValue *value;
@property (readonly) NSString *cssText;

@end
