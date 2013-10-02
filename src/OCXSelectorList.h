//
//  CSSSelectorList.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCXList.h"

@class OCXSelector;

@interface OCXSelectorList : OCXListCSS

- (void) addSelector:(OCXSelector *)selector;

@end
