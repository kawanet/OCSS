//
//  OCNamedNodeMap.m
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/08.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCNamedNodeMap.h"
#import "OCNode.h"

@implementation OCNamedNodeMap {
    NSMutableDictionary *_map;
}

- (NSMutableDictionary *)map {
    if (_map) return _map;
    return _map = [NSMutableDictionary new];
}

- (OCNode *)getNamedItem:(NSString*)name {
    OCNode *node = self.map[name];
    return node;
}
- (OCNode *)setNamedItem:(OCNode*)node {
    NSString *name = node.nodeName;
    if (!name) return nil;
    self.map[name] = node;
    return node;
}
- (OCNode *)removeNamedItem:(NSString*)name {
    OCNode *node = self.map[name];
    [self.map removeObjectForKey:name];
    return node;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len {
    NSUInteger bufferIndex = 0;
    NSUInteger listIndex = state->state;
    NSArray *array = self.map.allKeys;
    NSUInteger listLength = array.count;
    
    while (bufferIndex < len) {
        if (listIndex >= listLength) break;
        buffer[bufferIndex++] = array[listIndex++];
    }
    
    state->state = listIndex;
    state->itemsPtr = buffer;
    state->mutationsPtr = (unsigned long*)(__bridge void*)self;
    
    return bufferIndex;
}

- (id)objectForKeyedSubscript:(id)key {
    if (!key) return nil;
    return self.map[key];
}
- (void)setObject:(id)object forKeyedSubscript:(id)key {
    if (!key) return;
    self.map[key] = object;
}

@end
