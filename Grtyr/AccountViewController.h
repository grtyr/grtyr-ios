//
//  LoginViewController.h
//  Grtyr
//
//  Created by Conn on 12/25/13.
//  Copyright (c) 2014 connyay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GrtyrService.h"
#import "MBProgressHUD.h"
#import "SWRevealViewController.h"

@interface AccountViewController : UIViewController <GrtyrServiceDelegate>
{
	GrtyrService *giffyService;
}

@end
