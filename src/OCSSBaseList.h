//
//  CSSBaseList.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCSSBaseList : NSObject <NSFastEnumeration>

@property NSArray *list;
@property (readonly) NSString *cssText;

- (id)objectAtIndexedSubscript: (NSUInteger)index;

@end
