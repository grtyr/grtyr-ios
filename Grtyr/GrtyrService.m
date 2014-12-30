//
//  GrtyrService.m
//  Grtyr
//
//  Created by connyay on 12/30/14.
//  Copyright (c) 2014 connyay. All rights reserved.
//

#import "GrtyrService.h"

@implementation GrtyrService

@synthesize delegate;


- (void)login:(NSString *)username
     password:(NSString *)password {
    NSString *url = [NSString stringWithFormat:@"%@%@",
                     kGrtyrBaseUrl, kLoginMethodName];
    NSDictionary *params = @{ @"email": username,
                              @"password": password };
    [[GrtyrApi client] _doPost:url params:params completion:^(id JSON) {
        [self apiAuth:[JSON objectForKey:@"token"]];
    } failure:^(NSError * error) {
        // do something
    }];
}

- (void)getMe {
    NSString *url = [NSString stringWithFormat:@"%@%@",
                     kGrtyrBaseUrl, kMeMethodName];

    [[GrtyrApi client] _doGet:url auth:YES params:nil completion:^(id JSON) {
        NSLog(@"ME: %@", JSON);
        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        [standardUserDefaults setBool:YES forKey:@"loggedin"];
        [standardUserDefaults setObject:JSON forKey:@"user"];
        [standardUserDefaults setObject:[JSON objectForKey:@"name"] forKey:@"username"];
        [standardUserDefaults synchronize];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"LoggedIn"
         object:self
         userInfo: JSON];
        [delegate requestCompletedWithData:@[]];
    } failure:^(NSError * error) {
        // do something
    }];
}

- (void)getMyNotes {
    NSString *url = [NSString stringWithFormat:@"%@%@",
                     kGrtyrBaseUrl, kMyNotesMethodName];
    
    [[GrtyrApi client] _doGet:url auth:YES params:nil completion:^(id JSON) {
        NSLog(@"MINE: %@", JSON);
        [delegate requestCompletedWithData:JSON];
    } failure:^(NSError * error) {
        [delegate requestFailedWithError:error];
    }];
}

- (void)apiAuth:(NSString *)token {
    NSString *url = [NSString stringWithFormat:@"%@%@",
                     kGrtyrBaseUrl, kApiTokenMethodName];
    NSDictionary *params = @{ @"auth_token": token };
    [[GrtyrApi client] _doPost:url auth:YES params:params completion:^(id JSON) {
        [[GrtyrApi client] setApiToken:[JSON objectForKey:@"token"]];
        [self getMe];
    } failure:^(NSError * error) {
        // do something
    }];
}

- (void)logout {
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    [standardUserDefaults setBool:NO forKey:@"loggedin"];
    [standardUserDefaults setObject:nil forKey:@"user"];
    [standardUserDefaults setObject:nil forKey:@"username"];
    [standardUserDefaults synchronize];
    [[GrtyrApi client] clearApiToken];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"LoggedOut"
     object:self];
}

- (void)requestFailed:(NSError *)error {
    [delegate requestFailedWithError:error];
}

@end
