//
//  OCDOMTokenList.m
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCDOMTokenList.h"

@implementation OCDOMTokenList

- (instancetype) initWithString:(NSString*)source {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSArray *split = [source componentsSeparatedByCharactersInSet:set];
    
    // skip empty field
    NSMutableArray *array = [NSMutableArray new];
    for(NSString *str in split) {
        if (str.length) [array addObject:str];
    }
    
    self = [self initWithArray:array];
    return self;
}

- (BOOL) contains:(NSString*)token {
    for(NSString *str in self.list) {
        if ([token isEqualToString:str]) return YES;
    }
    return NO;
}

@end
