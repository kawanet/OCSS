//
//  CSSDocument.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCSSStyleSheet.h"
#import "OCSSStyleSheetList.h"
#import "OLocation.h"

@interface OHTMLDocument : NSObject

@property OCSSStyleSheetList *styleSheets;
@property OLocation *location;

- (void) addStyleSheet:(OCSSStyleSheet *)styleSheet;

@end
