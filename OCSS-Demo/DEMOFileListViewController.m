//
//  DEMOFileListViewController.m
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "DEMOFileListViewController.h"
#import "DEMOStyleListViewController.h"
#import "OCSS.h"

@interface DEMOFileListViewController ()

@end

@implementation DEMOFileListViewController {
    NSArray *_list;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _list = @[@"cssreset.css", @"bootstrap.css"];
    NSLog(@"count: %i", _list.count);
    
    OCSS *css = [OCSS new];
    OHTMLElement *a = [css.document createElement:@"A"];
    OHTMLElement *b = [css.document createElement:@"B"];
    a.innerText = @"foo";
    a.id = @"FOO";
    [a appendChild:b];
    b.innerText = @"bar";
    b.id = @"BAR";
    NSLog(@"%@", a.outerHTML);
    NSLog(@"%@", a.innerText);
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
    
    cell.textLabel.text = _list[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DEMOStyleListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"styleListView"];
    
    NSString *path = _list[indexPath.row];
    NSLog(@"%@", path);
    NSURL *url = NSBundle.mainBundle.bundleURL;
    url = [url URLByAppendingPathComponent:@"sample/"];
    url = [NSURL URLWithString:path relativeToURL:url];
    NSLog(@"%@", url.absoluteString);
    NSLog(@"%i", [vc isKindOfClass:[DEMOStyleListViewController class]]);
    
    vc.url = url;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
