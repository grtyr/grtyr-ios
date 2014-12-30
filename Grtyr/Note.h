//
//  MyGif.h
//  Grtyr
//
//  Created by connyay on 12/30/14.
//  Copyright (c) 2014 connyay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject {
	NSInteger ID;
    NSInteger author_id;
	NSString *body;
	NSString *createdAt;
}

@property NSInteger ID;
@property NSInteger author_id;
@property (nonatomic, retain) NSString *body;
@property (nonatomic, retain) NSString *createdAt;

@end
