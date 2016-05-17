//
//  User.m
//  digipay
//
//  Created by Lutfi Azhar on 2/3/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "User.h"

@implementation User

- (id)initWithData:(NSDictionary*)data
{
    if (self = [super init]) {
        if (![[data valueForKey:@"id"] isEqual:[NSNull null]]) {
            self.userId = [data valueForKey:@"id"];
        }else {
            self.userId = @"";
        }
        if (![[data valueForKey:@"address"] isEqual:[NSNull null]]) {
            self.address = [data valueForKey:@"address"];
        }else {
            self.address = @"";
        }
        if (![[data valueForKey:@"avatar_url"] isEqual:[NSNull null]]) {
            self.avatarUrl = [data valueForKey:@"avatar_url"];
        }else {
            self.avatarUrl = @"";
        }
        if (![[data valueForKey:@"email"] isEqual:[NSNull null]]) {
            self.email = [data valueForKey:@"email"];
        }else {
            self.email = @"";
        }
        if (![[data valueForKey:@"name"] isEqual:[NSNull null]]) {
            self.name = [data valueForKey:@"name"];
        }else {
            self.name = @"";
        }
        if (![[data valueForKey:@"no_ktp"] isEqual:[NSNull null]]) {
            self.noKTP = [data valueForKey:@"no_ktp"];
        }else {
            self.noKTP = @"";
        }
        if (![[data valueForKey:@"phone"] isEqual:[NSNull null]]) {
            self.noHP = [data valueForKey:@"phone"];
        }else {
            self.noHP = @"";
        }
        if (![[data valueForKey:@"premium"] isEqual:[NSNull null]]) {
            self.isPremium = [data valueForKey:@"premium"];
        }else {
            self.isPremium = @"";
        }
        if (![[data valueForKey:@"referral_id"] isEqual:[NSNull null]]) {
            self.referral_id = [data valueForKey:@"referral_id"];
        }else {
            self.referral_id = @"";
        }
        if (![[data valueForKey:@"token"] isEqual:[NSNull null]]) {
            self.token = [data valueForKey:@"token"];
        }else {
            self.token = @"";
        }
        if (![[data valueForKey:@"total_balance"] isEqual:[NSNull null]]) {
            self.totalBalance = [data valueForKey:@"total_balance"];
        }else {
            self.totalBalance = @"";
        }
        if (![[data valueForKey:@"total_bonus"] isEqual:[NSNull null]]) {
            self.totalBonus = [data valueForKey:@"total_bonus"];
        }else {
            self.totalBonus = @"";
        }
        if (![[data valueForKey:@"total_point"] isEqual:[NSNull null]]) {
            self.totalPoint = [data valueForKey:@"total_point"];
        }else {
            self.totalPoint = @"";
        }
        if (![[data valueForKey:@"uid"] isEqual:[NSNull null]]) {
            self.uid = [data valueForKey:@"uid"];
        }else {
            self.uid = @"";
        }
        
    }
    return self;
}

+ (id)userWithData:(NSDictionary*)data
{
    if (data) {
        return [[self alloc] initWithData:data];
    }else{
        return nil;
    }
}

@end
