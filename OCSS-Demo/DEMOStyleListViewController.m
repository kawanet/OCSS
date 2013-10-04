//
//  DEMOStyleListViewController.m
//  OCSS-Demo
//
//  Created by Yusuke Kawasaki on 2013/10/01.
//  Copyright (c) 2013 Kawanet. All rights reserved.
//

#import "DEMOStyleListViewController.h"
#import "DEMODeclarationViewController.h"
#import "OCSS.h"

@interface DEMOStyleListViewSection : NSObject
@property NSString *title;
@property (readonly) NSMutableArray *rows;
@property BOOL isMedia;
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
    
    self.navigationItem.title = @"Rules";
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchButtonClicked:)];
    self.navigationItem.rightBarButtonItem = button;
}

- (OCSS *) css {
    if (_css) return _css;
    
    if (!_cache) _cache = NSMutableDictionary.new;
    _css = _cache[self.url.absoluteString];
    if (_css) return _css;

    _css = [[OCSS alloc] initWithContentsOfURL:self.url];
    _cache[self.url.absoluteString] = _css;
    return _css;
}

- (NSArray *) sections {
    if (_sections) return _sections;
    
    DEMOStyleListViewSection *sect;
    NSMutableArray *array = NSMutableArray.new;
    
    for(OCSSStyleSheet *styleSheet in self.css.document.styleSheets) {
        for(OCSSRule *rule in styleSheet.cssRules) {
            if ([rule isKindOfClass:[OCSSStyleRule class]]) {
                if (!sect) {
                    sect = [DEMOStyleListViewSection new];
                    NSURL *url = [NSURL URLWithString:styleSheet.href];
                    sect.title = url.lastPathComponent;
                    [array addObject:sect];
                }
                [sect.rows addObject:rule];
            } else if ([rule isKindOfClass:[OCSSMediaRule class]]) {
                OCSSMediaRule *mediaRule = (OCSSMediaRule*) rule;
                sect = [DEMOStyleListViewSection new];
                sect.title = [NSString stringWithFormat:@"@media %@", mediaRule.media.mediaText];
                sect.isMedia = YES;
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
    
    return _sections = [NSArray arrayWithArray:array];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    DEMOStyleListViewSection *sect = self.sections[section];
    return sect.title;
};

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DEMOStyleListViewSection *sect = self.sections[section];
    return sect.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    DEMOStyleListViewSection *sect = self.sections[indexPath.section];
    OCSSStyleRule *rule = sect.rows[indexPath.row];
    cell.textLabel.text = rule.selectorText;
    cell.detailTextLabel.text = rule.style.cssText;

    if (sect.isMedia) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DEMOStyleListViewSection *sect = self.sections[indexPath.section];
    OCSSStyleRule *rule = sect.rows[indexPath.row];
    if (sect.isMedia) return;
    [self pushToDeclarationViewControllerWithSelector:rule.selectorText];
}

- (void)pushToDeclarationViewControllerWithSelector:(NSString *)selector {
    DEMODeclarationViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DEMODeclarationViewController"];
    vc.css = self.css;
    vc.selector = selector;    
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)searchButtonClicked:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Enter CSS Selector"
                                                        message:nil
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
    [alertView setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alertView show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UITextField *textField = [alertView textFieldAtIndex:0];
        if (textField.text.length) {
            [self pushToDeclarationViewControllerWithSelector:textField.text];
        }
    }
}

@end
