//
//  DEMODeclarationViewController.h
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/02.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OCSS.h"

@interface DEMODeclarationViewController : UITableViewController

@property OCSS* css;
@property NSString* selector;

@end
