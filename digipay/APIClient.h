//
//  APIClient.h
//  digipay
//
//  Created by Lutfi Azhar on 2/3/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Constants.h"
#import "User.h"

@interface APIClient : NSObject

+(void)registerUser:(User *)user
   withSuccessBlock:(void (^)(BOOL))success
    andFailureBlock:(void (^)(NSString *))failureBlock;

+(void)loginUser:(User *)user
withSuccessBlock:(void (^)(BOOL))success
 andFailureBlock:(void (^)(NSString *))failureBlock;

@end
