//
//  GrtyrService.h
//  Grtyr
//
//  Created by connyay on 12/30/14.
//  Copyright (c) 2014 connyay. All rights reserved.
//

#import "GrtyrApi.h"

@protocol GrtyrServiceDelegate
@optional
- (void)requestCompletedWithData:(NSArray *)data;
@required
- (void)requestFailedWithError:(NSError *)error;
@end


@interface GrtyrService : NSObject {}

@property (strong) id <GrtyrServiceDelegate> delegate;

- (void)login:(NSString *)email password:(NSString *)password;
- (void)logout;
- (void)getMyNotes;

@end
