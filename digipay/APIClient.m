//
//  APIClient.m
//  digipay
//
//  Created by Lutfi Azhar on 2/3/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient

+(void)registerUser:(User *)user
   withSuccessBlock:(void (^)(BOOL))success
    andFailureBlock:(void (^)(NSString *))failureBlock {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary* userDict = @{
                                @"email":user.email,
                                @"name":user.name,
                                @"address":user.address,
                                @"email":user.email,
                                @"password":user.password,
                                @"password_confirmation":user.password_confirmation,
                                @"referral_id":user.referral_id,
                                @"terms": user.terms
                               };
    
    NSDictionary* parameters = @{@"user": userDict };
    
    NSString* url = [kBaseURL stringByAppendingPathComponent:kPostUsers];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success with response: %@", responseObject);
        success(YES);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Fail with error: %@", error.localizedDescription);
        failureBlock(error.localizedDescription);
        
    }];

}

+(void)loginUser:(User *)user
withSuccessBlock:(void (^)(BOOL))success
 andFailureBlock:(void (^)(NSString *))failureBlock {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary* userDict = @{
                               @"email":user.email,
                               @"password":user.password,
                               };
    
    NSDictionary* parameters = @{@"user": userDict };
    
    NSString* url = [kBaseURL stringByAppendingPathComponent:kPostUsers];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success with response: %@", responseObject);
        success(YES);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Fail with error: %@", error.localizedDescription);
        failureBlock(error.localizedDescription);
        
    }];
    
}

@end
