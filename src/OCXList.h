//
//  CSSBaseList.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCXList : NSObject <NSFastEnumeration>
@property (readonly) NSMutableArray *list;
@property (readonly) NSUInteger length;
- (id) objectAtIndexedSubscript:(NSUInteger)index;
- (instancetype) initWithArray:(NSArray *)array;
@end

@interface OCXListCSS : OCXList
@property (readonly) NSString *cssText;
@property (readonly) NSString *delimiter;
@end