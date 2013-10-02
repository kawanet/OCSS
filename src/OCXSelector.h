//
//  OCSSSelector.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OCHTMLElement;

@interface OCXSpecificity : NSObject
@property NSUInteger specificityStyle;
@property NSUInteger specificityID;
@property NSUInteger specificityClassName;
@property NSUInteger specificityTagName;
@end

@interface OCXSelector : NSObject
@property NSString *selector;
@property (readonly) NSArray *parts;
- (BOOL) isSelectedForElement:(OCHTMLElement*)element;
@end
