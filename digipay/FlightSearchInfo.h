//
//  FlightSearchInfo.h
//  digipay
//
//  Created by Lutfi Azhar on 8/7/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightSearchInfo : NSObject

@property (nonatomic, strong) NSString* infoAdult;
@property (nonatomic, strong) NSString* infoChild;
@property (nonatomic, strong) NSString* infoDepart;
@property (nonatomic, strong) NSString* infoFrom;
@property (nonatomic, strong) NSString* infoInfant;
@property (nonatomic, strong) NSString* infoReturn;
@property (nonatomic, strong) NSString* infoRoundTrip;
@property (nonatomic, strong) NSString* infoTo;

+ (id)listWithData:(NSDictionary*)data;

@end
