//
//  OCSSPrimitiveValue.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/10/02.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSPrimitiveValue.h"

@implementation OCSSPrimitiveValue

+ (unsigned short) CSS_UNKNOWN { return 0; }
+ (unsigned short) CSS_NUMBER { return 1; }
+ (unsigned short) CSS_PERCENTAGE { return 2; }
+ (unsigned short) CSS_EMS { return 3; }
+ (unsigned short) CSS_EXS { return 4; }
+ (unsigned short) CSS_PX { return 5; }
+ (unsigned short) CSS_CM { return 6; }
+ (unsigned short) CSS_MM { return 7; }
+ (unsigned short) CSS_IN { return 8; }
+ (unsigned short) CSS_PT { return 9; }
+ (unsigned short) CSS_PC { return 10; }
+ (unsigned short) CSS_DEG { return 11; }
+ (unsigned short) CSS_RAD { return 12; }
+ (unsigned short) CSS_GRAD { return 13; }
+ (unsigned short) CSS_MS { return 14; }
+ (unsigned short) CSS_S { return 15; }
+ (unsigned short) CSS_HZ { return 16; }
+ (unsigned short) CSS_KHZ { return 17; }
+ (unsigned short) CSS_DIMENSION { return 18; }
+ (unsigned short) CSS_STRING { return 19; }
+ (unsigned short) CSS_URI { return 20; }
+ (unsigned short) CSS_IDENT { return 21; }
+ (unsigned short) CSS_ATTR { return 22; }
+ (unsigned short) CSS_COUNTER { return 23; }
+ (unsigned short) CSS_RECT { return 24; }
+ (unsigned short) CSS_RGBCOLOR { return 25; }

@end
