//
//  FlightClass.h
//  digipay
//
//  Created by Lutfi Azhar on 8/7/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightClass : NSObject

@property (nonatomic, strong) NSString* classId;
@property (nonatomic, strong) NSString* classClass;
@property (nonatomic, strong) NSString* className;
@property (nonatomic, strong) NSString* classPrice;
@property (nonatomic, strong) NSString* classSeat;
@property (nonatomic, strong) NSString* classValue;

+ (id)listWithData:(NSDictionary*)data;

@end
