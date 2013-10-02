//
//  CSSSelectorList.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCXSelectorList.h"

@implementation OCXSelectorList

- (void) addSelector:(OCXSelector *)selector {
    [self.list addObject:selector];
}

@end
