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

#pragma mark - NSUserDefaults
+(void)addUserToUserDefault:(User *)user{
    
    NSDictionary *userDict = @{
                               @"address": user.address,
                               @"email": user.email,
                               @"id": user.userId,
                               @"name": user.name,
                               @"phone": user.noHP,
                               @"avatarUrl": user.avatarUrl,
                               @"noKtp": user.noKTP,
                               @"premium": user.isPremium,
                               @"referralId": user.referral_id,
                               @"totalBalance": user.totalBalance,
                               @"totalBonus": user.totalBonus,
                               @"totalPoint": user.totalPoint,
                               @"uid": user.uid
                               };
    [[NSUserDefaults standardUserDefaults] setObject:userDict forKey:kUserDefaultsUserKey];
    
}

+(void)addUserTokenToUserDefault:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kUserDefaultsTokenKey];
}

+(User *)getUserUserDefault{
    NSDictionary* users = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserKey];
    User *user = [[User alloc] init];
    
    user.address = [users valueForKey:@"address"];
    user.email = [users valueForKey:@"email"];
    user.userId = [users valueForKey:@"id"];
    user.name = [users valueForKey:@"name"];
    user.noHP = [users valueForKey:@"phone"];
    user.avatarUrl = [users valueForKey:@"avatarUrl"];
    user.noKTP = [users valueForKey:@"noKtp"];
    user.isPremium = [users valueForKey:@"premium"];
    user.referral_id = [users valueForKey:@"referralId"];
    user.totalBalance = [users valueForKey:@"totalBalance"];
    user.totalBonus = [users valueForKey:@"totalBonus"];
    user.totalPoint = [users valueForKey:@"totalPoint"];
    user.uid = [users valueForKey:@"uid"];
    
    return user;
}

+(NSString *)getUserToken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsTokenKey];
}

+(NSString *)getUserEmail{
    NSDictionary* users = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserKey];
    return [users valueForKey:@"email"];
}

+(NSString *)getUserId{
    NSDictionary* users = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserKey];
    return [users valueForKey:@"id"];
}

+(NSString *)getUserName{
    NSDictionary* users = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserKey];
    return [users valueForKey:@"name"];
}

+(NSString *)getUserBalance{
    NSDictionary* users = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserKey];
    return [users valueForKey:@"totalBalance"];
}

+(NSString *)getUserPoin{
    NSDictionary* users = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserKey];
    return [users valueForKey:@"totalPoint"];
}


#pragma mark - UIAlertController
+(void)showDefaultAlertWithViewController:(UIViewController *)viewController withTitle:(NSString *)title andMessage:(NSString *)message {
    
    UIAlertController * alert =   [UIAlertController
                                   alertControllerWithTitle:title
                                   message:message
                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okBtn = [UIAlertAction
                            actionWithTitle:@"Ok"
                            style:UIAlertActionStyleDefault
                            handler:nil];
    
    [alert addAction:okBtn];
    
    [viewController presentViewController:alert animated:YES completion:nil];
}

@end
