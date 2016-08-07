//
//  FlightConnection.h
//  digipay
//
//  Created by Lutfi Azhar on 8/7/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightConnection : NSObject

@property (nonatomic, strong) NSString* connectionAirline;
@property (nonatomic, strong) NSOrderedSet* connectionClass;
@property (nonatomic, strong) NSString* connectionDate;
@property (nonatomic, strong) NSString* connectionEta;
@property (nonatomic, strong) NSString* connectionEtd;
@property (nonatomic, strong) NSString* connectionFno;
@property (nonatomic, strong) NSString* connectionFrom;
@property (nonatomic, strong) NSString* connectionTo;
@property (nonatomic, strong) NSString* connectionVia;

+ (id)listWithData:(NSDictionary*)data;

@end
