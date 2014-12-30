//
//  MenuViewController.m
//  Grtyr
//
//  Created by Conn on 12/25/13.
//  Copyright (c) 2014 connyay. All rights reserved.
//

#import "MenuViewController.h"
#import "HomeViewController.h"

@interface MenuViewController ()
@property (nonatomic, strong) NSArray *menuItems;
@end

@implementation MenuViewController


- (id)initWithStyle:(UITableViewStyle)style {
	self = [super initWithStyle:style];
	if (self) {
		// Custom initialization
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    
	_menuItems = @[@"title", @"account", @"home"];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	// Return the number of sections.
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
	return [self.menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *cellIdentifier = [self.menuItems objectAtIndex:indexPath.row];
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
	return cell;
}

- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	// This will create a "invisible" footer
	return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	// To "clear" the footer view
	return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://grtyr.com"]];
	}
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
}

@end
