//
//  Airline.m
//  digipay
//
//  Created by Lutfi Azhar on 8/6/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "Airline.h"

@implementation Airline

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
        if ([self checkNullParam:[result valueForKey:@"airlines_id"]]){
            self.airlinesId = [result valueForKey:@"airlines_id"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"airlines_code"]]){
            self.airlinesCode = [result valueForKey:@"airlines_code"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"airlines_name"]]){
            self.airlinesName = [result valueForKey:@"airlines_name"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"airlines_type"]]){
            self.airlinesType = [result valueForKey:@"airlines_type"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"connection_status"]]){
            self.connectionStatus = [result valueForKey:@"connection_status"];
            
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
