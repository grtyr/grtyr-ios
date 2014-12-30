//
//  GrtyrService.m
//  Grtyr
//
//  Created by connyay on 12/30/14.
//  Copyright (c) 2014 connyay. All rights reserved.
//

#import "GrtyrApi.h"

@implementation GrtyrApi

#pragma mark Singleton Methods

+ (id)client {
    static GrtyrApi *_client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _client = [[self alloc] init];
    });
    return _client;
}

- (void)_doGet:(NSString *)url params:(NSDictionary *)params completion:(void (^)(id JSON))completion failure:(void (^)(NSError * error))failure {
    [self _doGet:(NSString *)url auth:NO params:params completion:completion failure:failure];
}

- (void)_doGet:(NSString *)url auth:(BOOL)auth params:(NSDictionary *)params completion:(void (^)(id JSON))completion failure:(void (^)(NSError * error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *auth_token = nil;
    if (auth && params && [params objectForKey:@"auth_token"]) {
        auth_token = [params objectForKey:@"auth_token"];
    } else if(auth) {
        auth_token = [[GrtyrApi client] getApiToken];
    }
    if (auth_token) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@%@", @"Bearer ", auth_token] forHTTPHeaderField:@"Authorization"];
    }
    [manager GET:url parameters:params success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if (completion) {
            completion(responseObject);
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) {
            failure(error);
        }
    }];
}

- (void)_doPost:(NSString *)url params:(NSDictionary *)params completion:(void (^)(id JSON))completion failure:(void (^)(NSError * error))failure {
    [self _doPost:(NSString *)url auth:NO params:params completion:completion failure:failure];
}

- (void)_doPost:(NSString *)url auth:(BOOL)auth params:(NSDictionary *)params completion:(void (^)(id JSON))completion failure:(void (^)(NSError * error))failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *auth_token = nil;
    if (auth && params && [params objectForKey:@"auth_token"]) {
        auth_token = [params objectForKey:@"auth_token"];
    } else if(auth) {
        auth_token = [self getApiToken];
    }
    if (auth_token) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:[NSString stringWithFormat:@"%@%@", @"Bearer ", auth_token] forHTTPHeaderField:@"Authorization"];
    }
    [manager POST:url parameters:params success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        if (completion) {
            completion(responseObject);
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        if (failure) {
            failure(error);
        }
    }];
}

- (void) clearApiToken {
    [SSKeychain deletePasswordForService:kServiceName account:kAccountName];
}
- (void)setApiToken:(NSString *)token {
    NSLog(@"token: %@", token);
    [SSKeychain setPassword:token forService:kServiceName account:kAccountName];
}

- (NSString *)getApiToken {
    return [SSKeychain passwordForService:kServiceName account:kAccountName];
}

@end
