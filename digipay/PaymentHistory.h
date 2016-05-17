//
//  PaymentHistory.h
//  digipay
//
//  Created by Lutfi Azhar on 5/17/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaymentHistory : NSObject

@property (nonatomic, strong) NSString* amount;
@property (nonatomic, strong) NSString* date;
@property (nonatomic, strong) NSString* paymentId;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) NSString* msisdn;
@property (nonatomic, strong) NSString* nominal;
@property (nonatomic, strong) NSString* payment_type;
@property (nonatomic, strong) NSString* provider;
@property (nonatomic, strong) NSString* serial_number;
@property (nonatomic, strong) NSString* status;
@property (nonatomic, strong) NSString* total_balance;
@property (nonatomic, strong) NSString* total_bonus;
@property (nonatomic, strong) NSString* total_point;

+ (id)paymentWithData:(NSDictionary*)data;

@end
