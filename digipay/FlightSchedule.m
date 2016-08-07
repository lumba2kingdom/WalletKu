//
//  FlightSchedule.m
//  digipay
//
//  Created by Lutfi Azhar on 8/7/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "FlightSchedule.h"
#import "FlightClass.h"
#import "FlightConnection.h"

@implementation FlightSchedule

+ (id)listWithData:(NSDictionary*)data
{
    if (data) {
        return [[self alloc] initWithData:data];
    }else{
        return nil;
    }
}

- (id)initWithData:(NSDictionary*)result
{
    if (self = [super init]) {
        if ([self checkNullParam:[result valueForKey:@"airline_id"]]){
            self.scheduleAirlineId = [result valueForKey:@"airline_id"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"airline_name"]]){
            self.scheduleAirlineName = [result valueForKey:@"airline_name"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"class"]]){
            
            NSMutableArray* mutableArr = [NSMutableArray array];
            for (NSDictionary* connectionClassObj in [result valueForKey:@"class"]) {
                FlightClass* flightClass = [FlightClass listWithData:connectionClassObj];
                [mutableArr addObject:flightClass];
            }
            
            self.scheduleClass = [NSOrderedSet orderedSetWithArray:mutableArr];
        }
        
        if ([self checkNullParam:[result valueForKey:@"connecting_flight"]]){
            
            NSMutableArray* mutableArr = [NSMutableArray array];
            for (NSDictionary* connectionFlightObj in [result valueForKey:@"connecting_flight"]) {
                FlightConnection* flightConection= [FlightConnection listWithData:connectionFlightObj];
                [mutableArr addObject:flightConection];
            }
            
            self.scheduleConnectionFlight = [NSOrderedSet orderedSetWithArray:mutableArr];
        }
        
        if ([self checkNullParam:[result valueForKey:@"date"]]){
            self.scheduleDate = [result valueForKey:@"date"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"eta"]]){
            self.scheduleEta = [result valueForKey:@"eta"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"etd"]]){
            self.scheduleEtd = [result valueForKey:@"etd"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"fno"]]){
            self.scheduleFno = [result valueForKey:@"fno"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"from"]]){
            self.scheduleFrom = [result valueForKey:@"from"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"to"]]){
            self.scheduleTo = [result valueForKey:@"to"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"via"]]){
            self.scheduleVia = [result valueForKey:@"via"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"type"]]){
            self.scheduleType = [result valueForKey:@"type"];
            
        }
    }
    return self;
}

- (BOOL)checkNullParam:(id)param {
    if (param != nil && ![param isEqual:[NSNull null]]){
        return YES;
    }else{
        return NO;
    }
}

@end
