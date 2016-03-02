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

#define kBaseURL                        kIsProduction ? @"https://digipay.com/api/v1/" : @"http://103.206.247.116/api/v1/"
#define kPostAuthentication             @"sessions"
#define kPostAuthorization              @"resource"
#define kPostUsers                      @"users"
#define kPostForgotPassword             @"password_resets"
#define kPostTopUpPulsa                 @"top_ups"
#define kGetProvider                    @"providers"

#define kUserDefaultsUserKey            @"userDefaultsUser"

#endif /* Constants_h */
