//
//  CSSDeclarationList.h
//  AttributedImages
//
//  Created by Yusuke Kawasaki on 2013/09/30.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "OCList.h"
#import "OCSSDeclaration.h"

@interface OCSSStyleDeclaration : OCListCSS

- (void) addDeclaration:(OCSSDeclaration *)declaration;
- (id)objectForKeyedSubscript:(id)key;

@end
