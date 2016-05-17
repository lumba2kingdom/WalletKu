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
                               @"avatar_url": user.avatarUrl,
                               @"email": user.email,
                               @"id": user.userId,
                               @"name": user.name,
                               @"no_ktp": user.noKTP,
                               @"phone": user.noHP,
                               @"premium": user.isPremium,
                               @"referral_id": user.referral_id,
                               @"token": user.token,
                               @"total_balance": user.totalBalance,
                               @"total_bonus": user.totalBonus,
                               @"total_point": user.totalPoint,
                               @"uid": user.uid
                               };
    [[NSUserDefaults standardUserDefaults] setObject:userDict forKey:kUserDefaultsUserKey];
    
}

+(void)addRememberMeEmailToUserDefault:(NSString *)email {
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:kUserDefaultsEmailKey];
}

+(NSString *)getUserRememberMeEmail{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsEmailKey];
}

+(User *)getUserUserDefault{
    NSDictionary* users = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserKey];
    User *user = [User userWithData:users];
    
    return user;
}

+(NSString *)getUserToken{
    NSDictionary* users = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserKey];
    return [users valueForKey:@"token"];
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
    return [users valueForKey:@"total_balance"];
}

+(NSString *)getUserPoin{
    NSDictionary* users = [[NSUserDefaults standardUserDefaults] objectForKey:kUserDefaultsUserKey];
    return [users valueForKey:@"total_point"];
}

+(void)setPINStatus:(NSString *)status{
    [[NSUserDefaults standardUserDefaults] setObject:status forKey:@"pinstatus"];
}

+(NSString *)getPINStatus{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"pinstatus"];
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
