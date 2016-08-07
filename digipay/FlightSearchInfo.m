//
//  FlightSearchInfo.m
//  digipay
//
//  Created by Lutfi Azhar on 8/7/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "FlightSearchInfo.h"

@implementation FlightSearchInfo

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
        if ([self checkNullParam:[result valueForKey:@"adult"]]){
            self.infoAdult = [result valueForKey:@"adult"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"child"]]){
            self.infoChild = [result valueForKey:@"child"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"depart"]]){
            self.infoDepart = [result valueForKey:@"depart"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"from"]]){
            self.infoFrom = [result valueForKey:@"from"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"infant"]]){
            self.infoInfant = [result valueForKey:@"infant"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"return"]]){
            self.infoReturn = [result valueForKey:@"return"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"roundtrip"]]){
            self.infoRoundTrip = [result valueForKey:@"roundtrip"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"to"]]){
            self.infoTo = [result valueForKey:@"to"];
            
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
