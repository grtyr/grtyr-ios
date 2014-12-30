//
//  HomeViewController.h
//  Grtyr
//
//  Created by connyay on 12/30/14.
//  Copyright (c) 2014 connyay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrtyrService.h"
#import "AccountViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UIScrollView+SVInfiniteScrolling.h"
#import "SWRevealViewController.h"
#import "LVDebounce.h"


@interface HomeViewController : UIViewController <GrtyrServiceDelegate, UITableViewDelegate, UITableViewDataSource> {
    GrtyrService *grtyrService;
    UITableView* notesTable;
    NSMutableArray *notesDataForTable;
}

@property (nonatomic, strong) IBOutlet UITableView* notesTable;
@property (nonatomic, retain) IBOutlet NSMutableArray *notesDataForTable;
@property (nonatomic, strong) IBOutlet UILabel *restId;
@property (nonatomic, strong) IBOutlet UILabel *restContent;

- (IBAction)refresh:(id)sender;

- (void)fetchNotes;
- (void)showProgress;
- (void)clearProgress;
@end
