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
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* address;
@property (nonatomic, strong) NSString* password;
@property (nonatomic, strong) NSString* password_confirmation;
@property (nonatomic, strong) NSString* referral_id;
@property (nonatomic, strong) NSString* terms;
@property (nonatomic, strong) NSString* noKTP;
@property (nonatomic, strong) NSString* noHP;
@property (nonatomic, strong) NSString* avatarUrl;
@property (nonatomic, strong) NSString* isPremium;
@property (nonatomic, strong) NSString* totalBalance;
@property (nonatomic, strong) NSString* totalBonus;
@property (nonatomic, strong) NSString* totalPoint;
@property (nonatomic, strong) NSString* uid;
@property (nonatomic, strong) NSString* token;

+ (id)userWithData:(NSDictionary*)data;

@end
