//
//  FlightSchedule.h
//  digipay
//
//  Created by Lutfi Azhar on 8/7/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightSchedule : NSObject

@property (nonatomic, strong) NSString* scheduleAirlineId;
@property (nonatomic, strong) NSString* scheduleAirlineName;
@property (nonatomic, strong) NSOrderedSet* scheduleClass;
@property (nonatomic, strong) NSOrderedSet* scheduleConnectionFlight;
@property (nonatomic, strong) NSString* scheduleDate;
@property (nonatomic, strong) NSString* scheduleEta;
@property (nonatomic, strong) NSString* scheduleEtd;
@property (nonatomic, strong) NSString* scheduleFno;
@property (nonatomic, strong) NSString* scheduleFrom;
@property (nonatomic, strong) NSString* scheduleTo;
@property (nonatomic, strong) NSString* scheduleVia;
@property (nonatomic, strong) NSString* scheduleType;

+ (id)listWithData:(NSDictionary*)data;

@end
