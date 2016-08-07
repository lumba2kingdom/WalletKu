//
//  FlightSearchResult.h
//  digipay
//
//  Created by Lutfi Azhar on 8/7/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Airline.h"
#import "FlightSchedule.h"
#import "FlightSearchInfo.h"
#import "FlightClass.h"
#import "FlightConnection.h"

@interface FlightSearchResult : NSObject

@property (nonatomic, strong) Airline* airlineDetail;
@property (nonatomic, strong) NSOrderedSet* scheduleDepart;
@property (nonatomic, strong) NSOrderedSet* scheduleReturn;
@property (nonatomic, strong) FlightSearchInfo* searchInfo;
@property (nonatomic, strong) NSString* sessionId;

+ (id)listWithData:(NSDictionary*)data;

@end
