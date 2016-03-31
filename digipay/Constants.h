//
//  Constants.h
//  digipay
//
//  Created by Lutfi Azhar on 2/3/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define kIsProduction       NO
//#define kIsProduction       YES

#define kBaseURL                        kIsProduction ? @"https://digipay.com/api/v1/" : @"http://188.166.236.85/api/v1/"
#define kPostAuthentication             @"sessions"
#define kPostAuthorization              @"resource"
#define kPostUsers                      @"users"
#define kPostForgotPassword             @"password_resets"
#define kPostTopUpPulsa                 @"payments"

#define kGetProvider                    @"providers"
#define kGetPayment                     @"payments"

#define kUserDefaultsUserKey            @"userDefaultsUser"
#define kUserDefaultsTokenKey           @"userDefaultsToken"

#endif /* Constants_h */
