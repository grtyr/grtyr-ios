//
//  UserService.m
//  Grtyr
//
//  Created by connyay on 12/30/14.
//  Copyright (c) 2014 connyay. All rights reserved.
//

#import "UserService.h"

@implementation UserService

#pragma mark Singleton Methods

+ (id)instance {
    static UserService *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (NSDictionary *)currentUser {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    return [standardUserDefaults objectForKey:@"user"];
}

- (NSString *)currentUserName {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *user = [standardUserDefaults objectForKey:@"user"];
    return [user objectForKey:@"name"];
}

@end
