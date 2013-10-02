//
//  DEMODeclarationViewController.m
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/02.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "DEMODeclarationViewController.h"
#import "OCSS.h"
#import "OCXDeclaration.h"

@interface DEMODeclarationViewController ()

@end

@implementation DEMODeclarationViewController {
    NSMutableArray *_table;
    NSMutableArray *_selectors;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Computed Style";
    
    NSArray *array0 = [self.selector componentsSeparatedByString:@","];
    _table = NSMutableArray.new;
    _selectors = NSMutableArray.new;
    
    for(NSString *selector in array0) {
        OCSSStyleDeclaration *style = [self.css getComputedStyleForSelector:selector];
        [_selectors addObject:selector];
        [_table addObject:style];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _selectors[section];
};

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _table.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    OCSSStyleDeclaration *style = _table[section];
    return style.length;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    OCSSStyleDeclaration *style = _table[indexPath.section];
    OCXDeclaration *decl = style[indexPath.row];
    OCSSStyleRule *rule = (OCSSStyleRule*)decl.parentStyleDeclaration.parentRule;
    
    cell.textLabel.text = decl.cssText;
    cell.detailTextLabel.text = rule.selectorText;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
