//
//  OCSSRule.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/29.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSRule.h"

@implementation OCSSRule

+ (unsigned short) UNKNOWN_RULE { return 0; }
+ (unsigned short) STYLE_RULE { return 1; }
+ (unsigned short) CHARSET_RULE { return 2; }
+ (unsigned short) IMPORT_RULE { return 3; }
+ (unsigned short) MEDIA_RULE { return 4; }
+ (unsigned short) FONT_FACE_RULE { return 5; }
+ (unsigned short) PAGE_RULE { return 6; }

- (NSString *)cssText {
    return nil; // not implemented
}

@end

@implementation OCSSUnknownRule

@end
