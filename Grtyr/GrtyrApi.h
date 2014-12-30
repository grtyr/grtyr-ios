//
//  GrtyrService.h
//  Grtyr
//
//  Created by connyay on 12/30/14.
//  Copyright (c) 2014 connyay. All rights reserved.
//

#import "AFNetworking.h"
#import "SSKeychain.h"

//#define kGrtyrBaseUrl      @"https://grtyr.com/"
#define kGrtyrBaseUrl      @"http://localhost:9000/"
#define kLoginMethodName    @"auth/local"
#define kApiTokenMethodName    @"auth/api"
#define kMeMethodName    @"api/users/me"
#define kMyNotesMethodName    @"api/notes/mine"
#define kServiceName     [[NSBundle mainBundle] bundleIdentifier]
#define kAccountName        @""


@interface GrtyrApi : NSObject {}

+ (id)client;
- (void) _doGet:(NSString *)url params:params completion:(void (^)(id))completion failure:(void (^)(NSError *))failure;
- (void) _doGet:(NSString *)url auth:(BOOL)auth params:params completion:(void (^)(id))completion failure:(void (^)(NSError *))failure;
- (void) _doPost:(NSString *)url params:params completion:(void (^)(id))completion failure:(void (^)(NSError *))failure;
- (void) _doPost:(NSString *)url auth:(BOOL)auth params:params completion:(void (^)(id))completion failure:(void (^)(NSError *))failure;
- (void)clearApiToken;
- (void)setApiToken:(NSString *)token;
- (NSString*)getApiToken;
@end
