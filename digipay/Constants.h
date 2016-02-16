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

//#define kBaseTopUpPulsaURL              @"https://203.77.251.46:6789/"

#define kBaseURL                        kIsProduction ? @"https://digipay.com" : @"https://digipay.herokuapp.com"
#define kPostAuthentication             @"/api/v1/sessions"
#define kPostAuthorization              @"/api/v1/resource"
#define kPostUsers                      @"/api/v1/users"
#define kPostForgotPassword             @"/api/v1/password_resets"

#define kUserDefaultsUserKey            @"userDefaultsUser"

#endif /* Constants_h */
