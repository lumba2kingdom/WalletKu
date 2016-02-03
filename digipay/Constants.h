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

#define kBaseURL                        kIsProduction ? @"http://digipay.com" : @"http://digipay.herokuapp.com"
#define kPostAuthentication             @"/api/v1/sessions"
#define kPostAuthorization              @"/api/v1/resource"
#define kPostUsers                      @"/api/v1/users"

#endif /* Constants_h */
