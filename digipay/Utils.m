//
//  Utils.m
//  digipay
//
//  Created by Lutfi Azhar on 2/15/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "Utils.h"
#import "Constants.h"

@implementation Utils

+(void)addUserToUserDefault:(User *)user{
    
    NSDictionary *userDict = @{
                               @"address": user.address,
                               @"email": user.email,
                               @"id": user.userId,
                               @"name": user.name,
                               @"token": user.userToken
                               };
    [[NSUserDefaults standardUserDefaults] setObject:userDict forKey:kUserDefaultsUserKey];
    
}

+(User *)getUserUserDefault{
    NSDictionary* users = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserKey];
    User *user = [[User alloc] init];
    
    user.address = [users valueForKey:@"address"];
    user.email = [users valueForKey:@"email"];
    user.userId = [users valueForKey:@"id"];
    user.name = [users valueForKey:@"name"];
    user.userToken = [users valueForKey:@"token"];
    
    return user;
}

@end
