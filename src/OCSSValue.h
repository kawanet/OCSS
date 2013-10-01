//
//  OCSSValue.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCSSValue : NSObject

@property NSString *value;

- (instancetype) initWithString:(NSString *)value;

@end
