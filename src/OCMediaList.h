//
//  OCMediaList.h
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/10/02.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OCMediaList : NSObject

@property NSString *mediaText;

@end

// http://www.w3.org/TR/DOM-Level-2-Style/idl-definitions.html

/*
 interface MediaList {
 attribute DOMString                mediaText; // raises(dom::DOMException) on setting
 readonly attribute unsigned long   length;
 DOMString                          item(in unsigned long index);
 void                               deleteMedium(in DOMString oldMedium) raises(dom::DOMException);
 void                               appendMedium(in DOMString newMedium) raises(dom::DOMException);
 };
 */
