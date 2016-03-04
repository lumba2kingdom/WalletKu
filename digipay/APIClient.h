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

+(void)updateUser:(User *)user
 withSuccessBlock:(void (^)(BOOL))success
  andFailureBlock:(void (^)(NSString *))failureBlock;

+(void)loginUser:(User *)user
withSuccessBlock:(void (^)(BOOL))success
 andFailureBlock:(void (^)(NSString *))failureBlock;

+(void)forgotPassword:(NSString *)email
     withSuccessBlock:(void (^)(BOOL))success
      andFailureBlock:(void (^)(NSString *))failureBlock;

+(void)topUpPulsaWithProvider:(int)providerId
                      nominal:(int)nominalId
               andPhoneNumber:(NSString *)phoneNumber
             withSuccessBlock:(void (^)(BOOL))success
              andFailureBlock:(void (^)(NSString *))failureBlock;

+(void)getProvidersAndNominalsWithSuccessBlock:(void (^)(id responseObject))success
                               andFailureBlock:(void (^)(NSString *))failureBlock;

@end
