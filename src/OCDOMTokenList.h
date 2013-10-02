//
//  OCDOMTokenList.h
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCList.h"

@interface OCDOMTokenList : OCList

- (instancetype) initWithString:(NSString*)source;
- (BOOL) contains:(NSString*)token;
- (NSString *) stringifier;

@end

// http://www.w3.org/TR/domcore/

/*
 interface DOMTokenList {
 readonly attribute unsigned long   length;
 getter DOMString                   item(unsigned long index);
 boolean                            contains(DOMString token);
 void                               add(DOMString... tokens);
 void                               remove(DOMString... tokens);
 boolean                            toggle(DOMString token, optional boolean force);
 stringifier;
 };
 */