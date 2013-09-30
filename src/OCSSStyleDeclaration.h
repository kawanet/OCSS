//
//  CSSDeclarationList.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCSSBaseList.h"
#import "OCSSDeclaration.h"

@interface OCSSStyleDeclaration : OCSSBaseList

- (void) addDeclaration:(OCSSDeclaration *)declaration;

@end
