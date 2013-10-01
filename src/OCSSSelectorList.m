//
//  CSSSelectorList.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSSelectorList.h"

@implementation OCSSSelectorList

- (void) addSelector:(OCSSSelector *)selector {
    [self.list addObject:selector];
}

@end
