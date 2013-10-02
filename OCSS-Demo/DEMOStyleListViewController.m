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
@property NSString *title;
@property (readonly) NSMutableArray *rows;
@end

@implementation DEMOStyleListViewSection {
    NSMutableArray *_rows;
}

- (NSMutableArray *) rows {
    if (_rows) return _rows;
    return _rows = [NSMutableArray new];
}
@end

@implementation DEMOStyleListViewController {
    NSArray *_sections;
    OCSS *_css;
}

static NSMutableDictionary *_cache;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *path = self.url.absoluteURL.lastPathComponent;
    self.navigationItem.title = @"Rules";
    
    if (!_cache) _cache = NSMutableDictionary.new;
    _css = _cache[self.url.absoluteString];
    if (!_css) {
        _css = [[OCSS alloc] initWithContentsOfURL:self.url];
        _cache[self.url.absoluteString] = _css;
    }
    
    DEMOStyleListViewSection *sect;
    NSMutableArray *array = NSMutableArray.new;
    
    for(OCSSStyleSheet *styleSheet in _css.document.styleSheets) {
        for(OCSSRule *rule in styleSheet.cssRules) {
            if ([rule isKindOfClass:[OCSSStyleRule class]]) {
                if (!sect) {
                    sect = [DEMOStyleListViewSection new];
                    sect.title = path;
                    [array addObject:sect];
                }
                [sect.rows addObject:rule];
            } else if ([rule isKindOfClass:[OCSSMediaRule class]]) {
                OCSSMediaRule *mediaRule = (OCSSMediaRule*) rule;
                sect = [DEMOStyleListViewSection new];
                sect.title = [NSString stringWithFormat:@"@media %@", mediaRule.media.mediaText];
                [array addObject:sect];
                for(OCSSRule *childRule in mediaRule.cssRules) {
                    if ([childRule isKindOfClass:[OCSSStyleRule class]]) {
                        [sect.rows addObject:childRule];
                    }
                }
                sect = nil;
            }
        }
    }
    
    _sections = array;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    DEMOStyleListViewSection *sect = _sections[section];
    return sect.title;
};

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DEMOStyleListViewSection *sect = _sections[section];
    return sect.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    DEMOStyleListViewSection *sect = _sections[indexPath.section];
    OCSSStyleRule *rule = sect.rows[indexPath.row];
    cell.textLabel.text = rule.selectorText;
    cell.detailTextLabel.text = rule.style.cssText;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DEMOStyleListViewSection *sect = _sections[indexPath.section];
    OCSSStyleRule *rule = sect.rows[indexPath.row];
    
    DEMODeclarationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DEMODeclarationViewController"];
    vc.css = _css;
    vc.selector = rule.selectorText;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
