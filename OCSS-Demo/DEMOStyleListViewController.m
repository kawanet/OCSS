//
//  DEMOStyleListViewController.m
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "DEMOStyleListViewController.h"
#import "DEMODeclarationViewController.h"

@interface DEMOStyleListViewSection : NSObject
@property OCSS *css;
@property (readonly) NSArray *rows;
@end

@implementation DEMOStyleListViewSection {
    NSArray *_rows;
}

- (NSArray *) rows {
    if (_rows) return _rows;
    
    NSMutableArray *rows = [NSMutableArray new];
    for(OCSSStyleSheet *styleSheet in _css.document.styleSheets) {
        for(OCSSStyleRule *rule in styleSheet.cssRules) {
            if (![rule isKindOfClass:[OCSSStyleRule class]]) continue;
            [rows addObject:rule];
        }
    }
    return _rows = [NSArray arrayWithArray:rows];
}
@end

@implementation DEMOStyleListViewController {
    NSArray *_list;
    OCSS *_css;
}

static NSMutableDictionary *_cache;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = self.url.absoluteURL.lastPathComponent;
    self.navigationItem.title = path;
    
    if (!_cache) _cache = NSMutableDictionary.new;
    _css = _cache[self.url.absoluteString];
    if (!_css) {
        _css = [[OCSS alloc] initWithContentsOfURL:self.url];
        _cache[self.url.absoluteString] = _css;
    }
    
    NSMutableArray *array = NSMutableArray.new;
    
    DEMOStyleListViewSection *sect = [DEMOStyleListViewSection new];
    sect.css = _css;
    
    [array addObject:sect];
    
    _list = array;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DEMOStyleListViewSection *sect = _list[section];
    return sect.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    DEMOStyleListViewSection *sect = _list[indexPath.section];
    OCSSStyleRule *rule = sect.rows[indexPath.row];
    cell.textLabel.text = rule.selectorText;
    cell.detailTextLabel.text = rule.style.cssText;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DEMOStyleListViewSection *sect = _list[indexPath.section];
    OCSSStyleRule *rule = sect.rows[indexPath.row];

    DEMODeclarationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DEMODeclarationViewController"];
    vc.css = _css;
    vc.selector = rule.selectorText;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
