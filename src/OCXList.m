//
//  CSSBaseList.m
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCXList.h"

@implementation OCXList {
    NSMutableArray *_list;
}

- (NSArray *) list {
    if (_list) return _list;
    return _list = [NSMutableArray new];
}

- (instancetype) initWithArray:(NSArray *)array {
    self = self.init;
    _list = [NSMutableArray arrayWithArray:array];
    return self;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len {
    NSUInteger bufferIndex = 0;
    NSUInteger listIndex = state->state;
    NSUInteger listLength = self.list.count;
    
    while (bufferIndex < len) {
        if (listIndex >= listLength) break;
        buffer[bufferIndex++] = self.list[listIndex++];
    }
    
    state->state = listIndex;
    state->itemsPtr = buffer;
    state->mutationsPtr = (unsigned long*)(__bridge void*)self;
    
    return bufferIndex;
}

- (id) objectAtIndexedSubscript:(NSUInteger)index {
    return self.list[index];
}

- (NSUInteger) length {
    return self.list.count;
}

@end

@implementation OCXListCSS

- (NSString *)cssText {
    NSMutableArray *array = NSMutableArray.new;
    for(id rule in self.list) {
        NSString *text;
        if ([rule respondsToSelector:@selector(cssText)]) {
            text = [rule cssText];
        }
        if (text) {
            [array addObject:text];
        }
    }
    return [array componentsJoinedByString:self.delimiter];
}

- (NSString *) delimiter {
    return @"";
}

@end
