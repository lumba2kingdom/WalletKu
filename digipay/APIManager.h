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
#import "DataManager.h"
#import "MBProgressHUD.h"

@interface APIManager : NSObject

+ (APIManager *)sharedManager;

- (void)postAPIWithParam:(NSDictionary *)parameter
            andEndPoint:(NSString *)endPoint
      withAuthorization:(BOOL)authorization
           successBlock:(void (^)(NSDictionary *response))successBlock
        andFailureBlock:(void (^)(NSString *errorMessage))failureBlock;

- (void)putAPIWithParam:(NSDictionary *)parameter
           andEndPoint:(NSString *)endPoint
     withAuthorization:(BOOL)authorization
          successBlock:(void (^)(NSDictionary *response))successBlock
       andFailureBlock:(void (^)(NSString *errorMessage))failureBlock;

- (void)getAPIWithParam:(NSDictionary *)parameter
           andEndPoint:(NSString *)endPoint
     withAuthorization:(BOOL)authorization
          successBlock:(void (^)(NSDictionary *response))successBlock
       andFailureBlock:(void (^)(NSString *errorMessage))failureBlock;

- (void)requestImageWithUrl:(NSString *)url
        withOnSuccessBlock:(void (^)(UIImage * image, BOOL reloadView))successBlock
        withOnFailureBlock:(void (^)(void))failureBlock;
@end
