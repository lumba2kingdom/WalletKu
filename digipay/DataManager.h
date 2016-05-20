//
//  Utils.h
//  digipay
//
//  Created by Lutfi Azhar on 2/15/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface DataManager : NSObject

+(void)addUserToUserDefault:(User *)user;
+(User *)getUserUserDefault;
+(NSString *)getUserToken;
+(NSString *)getUserEmail;
+(NSString *)getUserId;
+(NSString *)getUserName;
+(NSString *)getUserBalance;
+(NSString *)getUserPoin;
+(NSString *)getPINStatus;
+(void)addRememberMeEmailToUserDefault:(NSString *)email;
+(NSString *)getUserRememberMeEmail;
+(void)setAutoLogoutStatus:(NSString *)status;
+(NSString *)getAutoLogoutStatus;

@end
