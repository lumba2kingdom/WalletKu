//
//  User.h
//  digipay
//
//  Created by Lutfi Azhar on 2/3/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString* userId;
@property (nonatomic, strong) NSString* userToken;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* address;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString* password_confirmation;
@property (nonatomic, strong) NSString* referral_id;
@property (nonatomic, strong) NSString* terms;
@property (nonatomic, strong) NSString* noKTP;
@property (nonatomic, strong) NSString* noHP;

@end
