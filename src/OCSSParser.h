//
//  CSSParser.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCSSStyleSheet.h"

@interface OCSSParser : NSObject

- (void) parseForStyleSheet:(OCSSStyleSheet *)stylesheet withString:(NSString*)source;

@end
