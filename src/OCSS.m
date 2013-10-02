//
//  OCSS.m
//  OCSS
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSS.h"

@implementation OCSS {
    OCHTMLDocument *_document;
}

- (instancetype) initWithContentsOfURL:(NSURL *)url {
    self = self.init;
    [self addStyleSheetWithContentsOfURL:url];
    return self;
}

- (OCHTMLDocument *) document {
    if (_document) return _document;
    return _document = [OCHTMLDocument new];
}

- (void) addStyleSheetWithContentsOfURL:(NSURL *)url {
    NSError *error;
    NSString *source = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    if (!source.length) return;
    
    OCSSStyleSheet *styleSheet = [[OCSSStyleSheet alloc] initWithString:source];
    styleSheet.href = url.absoluteString;
    
    [self.document addStyleSheet:styleSheet];
}

- (OCSSStyleDeclaration *) getComputedStyleForSelector:(NSString *)selector {
    OCHTMLElement *element = [self.document createElementWithSelector:selector];
    return [self.document getComputedStyle:element];
}

@end
