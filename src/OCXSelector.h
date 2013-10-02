//
//  OCXSelector.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCHTMLElement;

@interface OCXSelector : NSObject
@property NSString *selector;
@property (readonly) NSArray *parts;
@property (readonly) NSUInteger specificity;
- (BOOL) isSelectedForElement:(OCHTMLElement*)element;
@end
