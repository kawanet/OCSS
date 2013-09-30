//
//  AIDeclaration.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSBaseMap.h"
#import "OCSSValue.h"

@interface OCSSDeclaration : OCSSBaseMap

@property NSString *property;
@property OCSSValue *value;
@property (readonly) NSString *cssText;

@end
