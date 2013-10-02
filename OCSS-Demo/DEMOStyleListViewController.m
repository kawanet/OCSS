//
//  DEMOStyleListViewController.m
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "DEMOStyleListViewController.h"

@interface DEMOStyleListViewController ()

@end

@implementation DEMOStyleListViewController {
    NSArray *_list;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSString *path = self.url.absoluteURL.lastPathComponent;
    self.navigationItem.title = path;

    OCSS* css = [[OCSS alloc] initWithContentsOfURL:self.url];

    NSMutableArray *array = NSMutableArray.new;
    
    for(OCSSStyleSheet *styleSheet in css.document.styleSheets) {
        for(OCSSStyleRule *rule in styleSheet.cssRules) {
            if (![rule isKindOfClass:[OCSSStyleRule class]]) continue;
            [array addObject:rule];
        }
    }
    _list = array;  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"count: %i", _list.count);
    return _list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    OCSSStyleRule *rule = _list[indexPath.row];
    cell.textLabel.text = rule.selectorText;
    cell.detailTextLabel.text = rule.style.cssText;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
