//
//  AllGifsViewController.m
//  Grtyr
//
//  Created by connyay on 12/30/14.
//  Copyright (c) 2014 connyay. All rights reserved.
//

#import "HomeViewController.h"
#define debug 1

@interface HomeViewController ()
@property (nonatomic) IBOutlet UIBarButtonItem *revealButtonItem;
@property (nonatomic) IBOutlet UIBarButtonItem *refreshBtn;
@end

@implementation HomeViewController
@synthesize notesTable = _notesTable;
@synthesize notesDataForTable = _notesDataForTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [self.revealButtonItem setTarget:self.revealViewController];
    [self.revealButtonItem setAction:@selector(revealToggle:)];
    [self.revealViewController panGestureRecognizer];
    [self.revealViewController tapGestureRecognizer];
    
    grtyrService = [[GrtyrService alloc] init];
    grtyrService.delegate = self;
    
    [self fetchNotes];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"debut_light"]];
    [super viewDidLoad];
    
    
}

- (void)fetchNotes {
    NSLog(@"Fetching");
    [self showProgress];
    [grtyrService getMyNotes];
}

- (void)clearGifs {
    [self clearGifs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)showProgress {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)clearProgress {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark - DATASOURCE: UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (debug == 1) {NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));}
    return [_notesDataForTable count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (debug == 1) {NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));}
    return 1;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (debug == 1) {NSLog(@"Running %@ '%@'", self.class, NSStringFromSelector(_cmd));}
    return false;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(200.0 / 255.0) green:(200.0 / 255.0) blue:(200. / 255.0) alpha:1];
    
    cell.selectedBackgroundView = selectionColor;
    [[cell textLabel] setTextColor:[UIColor colorWithRed:55.0 / 255.0 green:55.0 / 255.0 blue:55.0 / 255.0 alpha:1.0]];
    cell.textLabel.font = [UIFont fontWithName:@"Georgia" size:14];
    cell.backgroundColor = [UIColor clearColor];
    
    
    NSString* item = self.notesDataForTable[indexPath.row];
    cell.textLabel.text = item;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0;
}


- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 10);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 10);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, 10, 10);
}

#pragma mark -
#pragma mark Grtyr service delegate
- (void)requestCompletedWithData:(NSDictionary *)data {
    _notesDataForTable = [NSMutableArray array];
    
    int iterator = 0;
    for (id note in data[@"notes"]) {
        [_notesDataForTable insertObject:note[@"body"] atIndex:iterator];
        iterator++;
    }
    
    [_notesTable reloadData];
    [_notesTable numberOfRowsInSection:[_notesDataForTable count]];
    [_notesTable reloadRowsAtIndexPaths:0 withRowAnimation:UITableViewRowAnimationLeft];
    [self clearProgress];
    [self.refreshBtn setEnabled:YES];
}

- (void)requestFailedWithError:(NSError *)error {
    NSInteger code = [error code];
    if (code == -1011) {
        [grtyrService logout];
        [self.revealViewController.rearViewController performSegueWithIdentifier:@"accountSegue" sender:nil];

    }
}


@end
