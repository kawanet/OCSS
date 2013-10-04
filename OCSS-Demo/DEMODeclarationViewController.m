//
//  DEMODeclarationViewController.m
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/02.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "DEMODeclarationViewController.h"
#import "OCSS.h"
#import "OCXProperty.h"

@interface DEMODeclarationViewSection : NSObject
@property OCSS *css;
@property NSString *selector;
@property (readonly) OCSSStyleDeclaration *style;
@end

@implementation DEMODeclarationViewSection {
    OCSSStyleDeclaration *_style;
}

- (OCSSStyleDeclaration *) style {
    if (_style) return _style;
    return _style = [self.css getComputedStyleForSelector:self.selector];
}
@end

@implementation DEMODeclarationViewController {
    NSArray *_sections;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Computed Style";
}

- (NSArray *) sections {
    if (_sections) return _sections;
    
    NSArray *array0 = [self.selector componentsSeparatedByString:@","];
    NSMutableArray *array = NSMutableArray.new;
    
    for(NSString *selector0 in array0) {
        NSString *selector = [selector0 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        DEMODeclarationViewSection *sect = [DEMODeclarationViewSection new];
        sect.css = self.css;
        sect.selector = selector;
        [array addObject:sect];
    }
    
    return _sections = [NSArray arrayWithArray:array];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    DEMODeclarationViewSection *sect = self.sections[section];
    return sect.selector;
};

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DEMODeclarationViewSection *sect = self.sections[section];
    return sect.style.length;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    DEMODeclarationViewSection *sect = self.sections[indexPath.section];
    OCXProperty *decl = sect.style[indexPath.row];
    OCSSStyleRule *rule = (OCSSStyleRule*)decl.parentStyleDeclaration.parentRule;
    
    cell.textLabel.text = decl.cssText;
    cell.detailTextLabel.text = rule.selectorText;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
