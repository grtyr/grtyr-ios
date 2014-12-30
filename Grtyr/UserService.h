//
//  UserService.h
//  Grtyr
//
//  Created by connyay on 12/30/14.
//  Copyright (c) 2014 connyay. All rights reserved.
//

@interface UserService : NSObject {}

+ (id)instance;
- (NSDictionary *)currentUser;
- (NSString *)currentUserName;
@end
