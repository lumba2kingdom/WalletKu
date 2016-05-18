//
//  Utils.h
//  digipay
//
//  Created by Lutfi Azhar on 2/15/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "User.h"

@interface Utils : NSObject

+(void)addUserToUserDefault:(User *)user;
+(User *)getUserUserDefault;
+(NSString *)getUserToken;
+(NSString *)getUserEmail;
+(NSString *)getUserId;
+(NSString *)getUserName;
+(NSString *)getUserBalance;
+(NSString *)getUserPoin;
+(void)showDefaultAlertWithViewController:(UIViewController *)viewController withTitle:(NSString *)title andMessage:(NSString *)message;
+(void)addRememberMeEmailToUserDefault:(NSString *)email;
+(NSString *)getUserRememberMeEmail;
+(void)setPINStatus:(NSString *)status;
+(NSString *)getPINStatus;
+(void)setAutoLogoutStatus:(NSString *)status;
+(NSString *)getAutoLogoutStatus;

@end
