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

@interface DEMODeclarationViewSection : NSObject
@property OCSS *css;
@property NSString *selector;
@property (readonly) OCSSStyleDeclaration *rows;
@end

@implementation DEMODeclarationViewSection {
    OCSSStyleDeclaration *_rows;
}

- (OCSSStyleDeclaration *) rows {
    if (_rows) return _rows;
    return _rows = [self.css getComputedStyleForSelector:self.selector];
}
@end

@implementation DEMODeclarationViewController {
    NSMutableArray *_sections;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Computed Style";
    
    NSArray *array0 = [self.selector componentsSeparatedByString:@","];
    _sections = NSMutableArray.new;
    
    for(NSString *selector in array0) {
        DEMODeclarationViewSection *sect = [DEMODeclarationViewSection new];
        sect.css = self.css;
        sect.selector = selector;
        [_sections addObject:sect];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    DEMODeclarationViewSection *sect = _sections[section];
    return sect.selector;
};

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DEMODeclarationViewSection *sect = _sections[section];
    return sect.rows.length;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    DEMODeclarationViewSection *sect = _sections[indexPath.section];
    OCXDeclaration *decl = sect.rows[indexPath.row];
    OCSSStyleRule *rule = (OCSSStyleRule*)decl.parentStyleDeclaration.parentRule;
    
    cell.textLabel.text = decl.cssText;
    cell.detailTextLabel.text = rule.selectorText;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end