//
//  APIClient.m
//  digipay
//
//  Created by Lutfi Azhar on 2/3/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "APIClient.h"
#import "Utils.h"

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

        NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        NSError *jsonError;
        
        NSData *objectData = [ErrorResponse dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonFailObject = [NSJSONSerialization JSONObjectWithData:objectData
                                                             options:NSJSONReadingMutableContainers
                                                               error:&jsonError];
        NSString *messageError;
        if ([jsonFailObject objectForKey:@"email"]) {
            messageError = [NSString stringWithFormat:@"%@ %@",
                            [[[jsonFailObject objectForKey:@"email"] firstObject] valueForKey:@"attribute"],
                            [[[jsonFailObject objectForKey:@"email"] firstObject] valueForKey:@"message"]] ;
        }
        
        NSLog(@"Fail with error: %@", jsonFailObject);
        
        if (![messageError isEqualToString:@""]) {
            failureBlock(messageError);
        }else{
            failureBlock(error.localizedDescription);
        }
        
    }];
}

+(void)updateUser:(User *)user
   withSuccessBlock:(void (^)(BOOL))success
    andFailureBlock:(void (^)(NSString *))failureBlock {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary* userDict = @{
                               @"name":user.name,
                               @"no_ktp":user.noKTP,
                               @"phone":user.noHP,
                               @"address":user.address
                               };
    
    NSDictionary* parameters = @{@"user": userDict};
    
    NSString* url = [NSString stringWithFormat:@"%@%@/%@", kBaseURL, kPostUsers, user.userId];
    NSLog(@"UPDATE URL: %@", url);
    
    [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success with response: %@", responseObject);
        success(YES);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString* ErrorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        NSError *jsonError;
        
        NSData *objectData = [ErrorResponse dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonFailObject = [NSJSONSerialization JSONObjectWithData:objectData
                                                                       options:NSJSONReadingMutableContainers
                                                                         error:&jsonError];
        NSString *messageError;
        if ([jsonFailObject objectForKey:@"email"]) {
            messageError = [NSString stringWithFormat:@"%@ %@",
                            [[[jsonFailObject objectForKey:@"email"] firstObject] valueForKey:@"attribute"],
                            [[[jsonFailObject objectForKey:@"email"] firstObject] valueForKey:@"message"]] ;
        }
        
        NSLog(@"Fail with error: %@", jsonFailObject);
        
        if (![messageError isEqualToString:@""]) {
            failureBlock(messageError);
        }else{
            failureBlock(error.localizedDescription);
        }
        
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
    
    NSString* url = [kBaseURL stringByAppendingPathComponent:kPostAuthentication];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success with response: %@", responseObject);
        
        NSDictionary *userDict = (NSDictionary*)responseObject;
        
        User *newUser = [[User alloc] init];
        newUser.address = [userDict valueForKey:@"address"];
        newUser.email = [userDict valueForKey:@"email"];
        newUser.userId = [userDict valueForKey:@"id"];
        newUser.name = [userDict valueForKey:@"name"];
        newUser.userToken = [userDict valueForKey:@"token"];
        newUser.noHP = [userDict valueForKey:@"phone"];
        
        [Utils addUserToUserDefault:newUser];
        
        success(YES);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Fail with error: %@", error.localizedDescription);
        failureBlock(error.localizedDescription);
        
    }];
    
}

+(void)forgotPassword:(NSString *)email
     withSuccessBlock:(void (^)(BOOL))success
      andFailureBlock:(void (^)(NSString *))failureBlock {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSDictionary* emailDict = @{
                               @"email":email
                               };
    
    NSDictionary* parameters = @{@"password_reset": emailDict };
    
    NSString* url = [kBaseURL stringByAppendingPathComponent:kPostForgotPassword];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success with response: %@", responseObject);
        success(YES);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Fail with error: %@", error.localizedDescription);
        failureBlock(error.localizedDescription);
        
    }];
    
}

@end
