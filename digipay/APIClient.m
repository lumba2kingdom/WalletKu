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

+(void)requestImageWithUrl:(NSString *)url
        withOnSuccessBlock:(void (^)(UIImage * image, BOOL reloadView))successBlock
        withOnFailureBlock:(void (^)(void))failureBlock {
    
    if (url == nil || url.lastPathComponent == nil) {
        
        NSLog(@"Failed to request image. Incomplete url.");
        
        failureBlock();
        return;
    }
    
    NSString* urlOnlyPath = [url stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    NSURL* domain = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSString* fullPath = [[domain URLByAppendingPathComponent:urlOnlyPath] path];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
        
        successBlock([UIImage imageWithContentsOfFile:fullPath], NO);
        return;
    }
    
    AFHTTPSessionManager* sessionManager = [AFHTTPSessionManager manager];
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    sessionManager.responseSerializer = [AFImageResponseSerializer serializer];
    
    [sessionManager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath]) {
            //  if theres existing file, assume it is invalid and replace it
            
            NSError* error = nil;
            [[NSFileManager defaultManager] removeItemAtPath:fullPath error:&error];
            
            
            NSLog(@"%@", error.localizedFailureReason);
        }
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:fullPath.stringByDeletingLastPathComponent] == NO) {
            
            NSError* error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:fullPath.stringByDeletingLastPathComponent
                                      withIntermediateDirectories:YES
                                                       attributes:nil
                                                            error:&error];
            
            
            NSLog(@"%@", error.localizedFailureReason);
        }
        
        NSData* data = UIImagePNGRepresentation(responseObject);
        [[NSFileManager defaultManager] createFileAtPath:fullPath contents:data attributes:nil];
        successBlock([UIImage imageWithData:data], YES);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        
        NSLog(@"\nRequest image Error: %@\n", error);
        
        failureBlock();
    }];
}
@end
