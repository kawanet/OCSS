//
//  OCDOMTokenList.h
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCList.h"

@interface OCDOMTokenList : OCList

- (instancetype) initWithString:(NSString*)source;
- (BOOL) contains:(NSString*)token;

@end
