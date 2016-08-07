//
//  FlightConnection.m
//  digipay
//
//  Created by Lutfi Azhar on 8/7/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "FlightConnection.h"
#import "FlightClass.h"

@implementation FlightConnection

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
        if ([self checkNullParam:[result valueForKey:@"airline"]]){
            self.connectionAirline = [result valueForKey:@"airline"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"class"]]){
            
            NSMutableArray* mutableArr = [NSMutableArray array];
            for (NSDictionary* connectionClassObj in [result valueForKey:@"class"]) {
                FlightClass* flightClass = [FlightClass listWithData:connectionClassObj];
                [mutableArr addObject:flightClass];
            }
            
            self.connectionClass = [NSOrderedSet orderedSetWithArray:mutableArr];
        }
        
        if ([self checkNullParam:[result valueForKey:@"date"]]){
            self.connectionDate = [result valueForKey:@"date"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"eta"]]){
            self.connectionEta = [result valueForKey:@"eta"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"etd"]]){
            self.connectionEtd = [result valueForKey:@"etd"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"fno"]]){
            self.connectionFno = [result valueForKey:@"fno"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"from"]]){
            self.connectionFrom = [result valueForKey:@"from"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"to"]]){
            self.connectionTo = [result valueForKey:@"to"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"via"]]){
            self.connectionVia = [result valueForKey:@"via"];
            
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
