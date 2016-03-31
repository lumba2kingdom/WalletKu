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

#pragma mark - APIs Method
+(void)postAPIWithParam:(NSDictionary *)parameter
            andEndPoint:(NSString *)endPoint
      withAuthorization:(BOOL)authorization
           successBlock:(void (^)(NSDictionary *response))successBlock
        andFailureBlock:(void (^)(NSString *errorMessage))failureBlock {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    if (authorization) {
        NSString *token = [Utils getUserToken];
        NSString *userEmail = [Utils getUserEmail];
        if (![token isEqualToString:@""] && ![userEmail isEqualToString:@""]) {
            NSString *authHeader = [NSString stringWithFormat:@"Token token=%@,email=%@", [Utils getUserToken], [Utils getUserEmail]];
            [manager.requestSerializer setValue:authHeader forHTTPHeaderField:@"Authorization"];
        }else{
            NSLog(@"ERROR: FAILED TO SET AUTHORIZATION HEADER");
        }
    }else{
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    NSString* url = [kBaseURL stringByAppendingPathComponent:endPoint];
    
    [manager POST:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success with response: %@", responseObject);
        
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Fail with response: %@", error.localizedDescription);
        NSLog(@"Fail with request: %@", [[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding]);
        
        NSString *errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSString *errorMessage = [self getErrorMessageObjectWithString:errorResponse];

        if ([errorMessage isEqualToString:@""] || [errorMessage isEqualToString:@"(null)"] || [errorMessage isEqual:[NSNull null]]) {
            failureBlock(error.localizedDescription);
        }else{
            failureBlock(errorMessage);
        }
        
    }];
    
}

+(void)putAPIWithParam:(NSDictionary *)parameter
           andEndPoint:(NSString *)endPoint
     withAuthorization:(BOOL)authorization
          successBlock:(void (^)(NSDictionary *response))successBlock
       andFailureBlock:(void (^)(NSString *errorMessage))failureBlock {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    if (authorization) {
        NSString *token = [Utils getUserToken];
        NSString *userEmail = [Utils getUserEmail];
        if (![token isEqualToString:@""] && ![userEmail isEqualToString:@""]) {
            NSString *authHeader = [NSString stringWithFormat:@"Token token=%@,email=%@", [Utils getUserToken], [Utils getUserEmail]];
            [manager.requestSerializer setValue:authHeader forHTTPHeaderField:@"Authorization"];
        }else{
            NSLog(@"ERROR: FAILED TO SET AUTHORIZATION HEADER");
        }
    }else{
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    NSString* url = [kBaseURL stringByAppendingPathComponent:endPoint];
    
    [manager PUT:url parameters:parameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success with response: %@", responseObject);
        
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Fail with response: %@", error.localizedDescription);
        NSLog(@"Fail with request: %@", [[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding]);
        
        NSString *errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSString *errorMessage = [self getErrorMessageObjectWithString:errorResponse];
        
        if ([errorMessage isEqualToString:@""] || [errorMessage isEqualToString:@"(null)"] || [errorMessage isEqual:[NSNull null]]) {
            failureBlock(error.localizedDescription);
        }else{
            failureBlock(errorMessage);
        }
        
    }];
    
}

+(void)getAPIWithParam:(NSDictionary *)parameter
           andEndPoint:(NSString *)endPoint
     withAuthorization:(BOOL)authorization
          successBlock:(void (^)(NSDictionary *response))successBlock
       andFailureBlock:(void (^)(NSString *errorMessage))failureBlock {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    if (authorization) {
        NSString *token = [Utils getUserToken];
        NSString *userEmail = [Utils getUserEmail];
        if (![token isEqualToString:@""] && ![userEmail isEqualToString:@""]) {
            NSString *authHeader = [NSString stringWithFormat:@"Token token=%@,email=%@", [Utils getUserToken], [Utils getUserEmail]];
            [manager.requestSerializer setValue:authHeader forHTTPHeaderField:@"Authorization"];
        }else{
            NSLog(@"ERROR: FAILED TO SET AUTHORIZATION HEADER");
        }
    }else{
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    NSString* url = [kBaseURL stringByAppendingPathComponent:endPoint];
    
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success with response: %@", responseObject);
        
        successBlock(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Fail with response: %@", error.localizedDescription);
        NSLog(@"Fail with request: %@", [[NSString alloc] initWithData:task.originalRequest.HTTPBody encoding:NSUTF8StringEncoding]);
        
        NSString *errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        NSString *errorMessage = [self getErrorMessageObjectWithString:errorResponse];
        
        if ([errorMessage isEqualToString:@""] || [errorMessage isEqualToString:@"(null)"] || [errorMessage isEqual:[NSNull null]]) {
            failureBlock(error.localizedDescription);
        }else{
            failureBlock(errorMessage);
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
        newUser.noHP = [userDict valueForKey:@"phone"];
        
        [Utils addUserToUserDefault:newUser];
        
        success(YES);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        NSString *errorMessage = [NSString stringWithFormat:@"%@", [self getErrorMessageObjectWithString:errorResponse]];
        
        if ([errorMessage isEqualToString:@""] || [errorMessage isEqualToString:@"(null)"] || [errorMessage isEqual:[NSNull null]]) {
            failureBlock(error.localizedDescription);
        }else{
            failureBlock(errorMessage);
        }
        
    }];
    
}

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
        
        NSDictionary *userDict = (NSDictionary*)[responseObject objectForKey:@"user"];
        
        User *newUser = [[User alloc] init];
        newUser.address = [userDict valueForKey:@"address"];
        newUser.email = [userDict valueForKey:@"email"];
        newUser.userId = [userDict valueForKey:@"id"];
        newUser.name = [userDict valueForKey:@"name"];
        newUser.noHP = [userDict valueForKey:@"phone"];
        
        [Utils addUserToUserDefault:newUser];
        success(YES);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSString *errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        NSString *errorMessage = [NSString stringWithFormat:@"%@", [self getErrorMessageObjectWithString:errorResponse]];
        
        if ([errorMessage isEqualToString:@""] || [errorMessage isEqualToString:@"(null)"] || [errorMessage isEqual:[NSNull null]]) {
            failureBlock(error.localizedDescription);
        }else{
            failureBlock(errorMessage);
        }
        
    }];
}

+(void)updateUser:(User *)user
   withSuccessBlock:(void (^)(BOOL))success
    andFailureBlock:(void (^)(NSString *))failureBlock {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *authHeader = [NSString stringWithFormat:@"Token token=%@,email=%@", [Utils getUserToken], [Utils getUserEmail]];
    [manager.requestSerializer setValue:authHeader forHTTPHeaderField:@"Authorization"];
    
    
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
        
        NSString *errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        NSString *errorMessage = [NSString stringWithFormat:@"%@", [self getErrorMessageObjectWithString:errorResponse]];
        
        if ([errorMessage isEqualToString:@""] || [errorMessage isEqualToString:@"(null)"] || [errorMessage isEqual:[NSNull null]]) {
            failureBlock(error.localizedDescription);
        }else{
            failureBlock(errorMessage);
        }
        
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
        
        NSString *errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        NSString *errorMessage = [NSString stringWithFormat:@"%@", [self getErrorMessageObjectWithString:errorResponse]];
        
        if ([errorMessage isEqualToString:@""] || [errorMessage isEqualToString:@"(null)"] || [errorMessage isEqual:[NSNull null]]) {
            failureBlock(error.localizedDescription);
        }else{
            failureBlock(errorMessage);
        }
        
    }];
    
}

+(void)topUpPulsaWithProvider:(int)providerId
                      nominal:(int)nominalId
                          pin:(NSString *)pin
               andPhoneNumber:(NSString *)phoneNumber
             withSuccessBlock:(void (^)(NSString *status, NSString *message))success
              andFailureBlock:(void (^)(NSString *))failureBlock {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *authHeader = [NSString stringWithFormat:@"Token token=%@,email=%@", [Utils getUserToken], [Utils getUserEmail]];
    [manager.requestSerializer setValue:authHeader forHTTPHeaderField:@"Authorization"];
    
    
    NSDictionary* parameters = @{
                                @"top_up":@{
                                            @"provider_id":@(providerId),
                                            @"nominal_id":@(nominalId),
                                            @"phone_number":phoneNumber,
                                            @"pin":pin
                                        }
                                };
    
    NSString* url = [kBaseURL stringByAppendingPathComponent:kPostTopUpPulsa];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"Success with response: %@", responseObject);
        
        NSString *status = [responseObject valueForKeyPath:@"payment.status"];
        NSString *message = [responseObject valueForKeyPath:@"payment.message"];
        if (status) {
            success(status, message);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
//        NSString* log = [NSString stringWithFormat:@"REQUEST:\n%@\n\nRESPONSE:\n%@\n",
//                         [[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding],
//                         [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]];
        
        NSString *errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        NSString *errorMessage = [NSString stringWithFormat:@"%@", [self getErrorMessageObjectWithString:errorResponse]];

        if ([errorMessage isEqualToString:@""] || [errorMessage isEqualToString:@"(null)"] || [errorMessage isEqual:[NSNull null]]) {
            failureBlock(error.localizedDescription);
        }else{
            failureBlock(errorMessage);
        }
        
    }];
    
}

+(void)getProvidersAndNominalsWithSuccessBlock:(void (^)(id responseObject))success
                               andFailureBlock:(void (^)(NSString *))failureBlock {
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *authHeader = [NSString stringWithFormat:@"Token token=%@,email=%@", [Utils getUserToken], [Utils getUserEmail]];
    [manager.requestSerializer setValue:authHeader forHTTPHeaderField:@"Authorization"];
    
    
    NSString* url = [kBaseURL stringByAppendingPathComponent:kGetProvider];
    
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Success with response: %@", responseObject);
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"fail: %@", error.localizedDescription);
        
        NSString *errorResponse = [[NSString alloc] initWithData:(NSData *)error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
        
        NSString *errorMessage = [NSString stringWithFormat:@"%@", [self getErrorMessageObjectWithString:errorResponse]];
        
        if ([errorMessage isEqualToString:@""] || [errorMessage isEqualToString:@"(null)"] || [errorMessage isEqual:[NSNull null]]) {
            failureBlock(error.localizedDescription);
        }else{
            failureBlock(errorMessage);
        }
        
    }];
    
}

#pragma mark - Custom Methods
+(NSString *)getErrorMessageObjectWithString:(NSString *)errorString {
    NSError *jsonError;
    
    NSData *objectData = [errorString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonFailObject = [NSJSONSerialization JSONObjectWithData:objectData
                                                                   options:NSJSONReadingMutableContainers
                                                                     error:&jsonError];
    
    NSString *messageError;
    
    if ([jsonFailObject objectForKey:@"error"]) {
        messageError = [NSString stringWithFormat:@"%@", [jsonFailObject objectForKey:@"error"]];
    }
    
    NSLog(@"Fail with error: %@", jsonFailObject);
    
    return messageError;
}

@end
