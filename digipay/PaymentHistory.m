//
//  PaymentHistory.m
//  digipay
//
//  Created by Lutfi Azhar on 5/17/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "PaymentHistory.h"

@implementation PaymentHistory

- (id)initWithData:(NSDictionary*)data
{
    if (self = [super init]) {
        if (![[data valueForKey:@"amount"] isEqual:[NSNull null]]) {
            self.amount = [data valueForKey:@"amount"];
        }else {
            self.amount = @"";
        }
        if (![[data valueForKey:@"date"] isEqual:[NSNull null]]) {
            self.date = [data valueForKey:@"date"];
        }else {
            self.date = @"";
        }
        if (![[data valueForKey:@"id"] isEqual:[NSNull null]]) {
            self.paymentId = [data valueForKey:@"id"];
        }else {
            self.paymentId = @"";
        }
        if (![[data valueForKey:@"message"] isEqual:[NSNull null]]) {
            self.message = [data valueForKey:@"message"];
        }else {
            self.message = @"";
        }
        if (![[data valueForKey:@"msisdn"] isEqual:[NSNull null]]) {
            self.msisdn = [data valueForKey:@"msisdn"];
        }else {
            self.msisdn = @"";
        }
        if (![[data valueForKey:@"nominal"] isEqual:[NSNull null]]) {
            self.nominal = [data valueForKey:@"nominal"];
        }else {
            self.nominal = @"";
        }
        if (![[data valueForKey:@"payment_type"] isEqual:[NSNull null]]) {
            self.payment_type = [data valueForKey:@"payment_type"];
        }else {
            self.payment_type = @"";
        }
        if (![[data valueForKey:@"provider"] isEqual:[NSNull null]]) {
            self.provider = [data valueForKey:@"provider"];
        }else {
            self.provider = @"";
        }
        if (![[data valueForKey:@"serial_number"] isEqual:[NSNull null]]) {
            self.serial_number = [data valueForKey:@"serial_number"];
        }else {
            self.serial_number = @"";
        }
        if (![[data valueForKey:@"status"] isEqual:[NSNull null]]) {
            self.status = [data valueForKey:@"status"];
        }else {
            self.status = @"";
        }
        if (![[data valueForKey:@"total_balance"] isEqual:[NSNull null]]) {
            self.total_balance = [data valueForKey:@"total_balance"];
        }else {
            self.total_balance = @"";
        }
        if (![[data valueForKey:@"total_bonus"] isEqual:[NSNull null]]) {
            self.total_bonus = [data valueForKey:@"total_bonus"];
        }else {
            self.total_bonus = @"";
        }
        if (![[data valueForKey:@"total_point"] isEqual:[NSNull null]]) {
            self.total_point = [data valueForKey:@"total_point"];
        }else {
            self.total_point = @"";
        }
        
    }
    return self;
}

+ (id)paymentWithData:(NSDictionary*)data
{
    if (data) {
        return [[self alloc] initWithData:data];
    }else{
        return nil;
    }
}

@end
