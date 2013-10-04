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
    NSArray *_rows;
    NSIndexPath *_currentPath;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Style Sheets";
    
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonClicked:)];
    self.navigationItem.rightBarButtonItem = button;
}

- (NSArray *)rows {
    if (_rows) return _rows;
    return _rows = [NSBundle.mainBundle URLsForResourcesWithExtension:@"css" subdirectory:@"sample"];
}

- (NSInteger)numberOfrowsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSURL *url = self.rows[indexPath.row];
    cell.textLabel.text = url.isFileURL ? url.lastPathComponent : url.absoluteString;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *url = self.rows[indexPath.row];
    [self pushToStyleListViewControllerWithURL:url];
}

- (void)pushToStyleListViewControllerWithURL:(NSURL *)url {
    DEMOStyleListViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DEMOStyleListViewController"];
    vc.url = url;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)addButtonClicked:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Enter StyleSheet URL"
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
        if (textField.text.length > 7) {
            _currentPath = [NSIndexPath indexPathForRow:self.rows.count inSection:0];
            NSURL *url = [NSURL URLWithString:textField.text];
            _rows = [self.rows arrayByAddingObject:url]; // adhoc
            [self.tableView reloadData];
            // [self.tableView selectRowAtIndexPath:_currentPath animated:YES scrollPosition:UITableViewScrollPositionNone];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (_currentPath) {
        [self tableView:self.tableView didSelectRowAtIndexPath:_currentPath];
        _currentPath = nil;
    }
}

@end
