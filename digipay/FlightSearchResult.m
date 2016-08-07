//
//  FlightSearchResult.m
//  digipay
//
//  Created by Lutfi Azhar on 8/7/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "FlightSearchResult.h"

@implementation FlightSearchResult

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
        if ([self checkNullParam:[result valueForKey:@"airlines_detail"]]){
            self.airlineDetail = [Airline listWithData:[result valueForKey:@"airlines_detail"]];
            
        }
        if ([self checkNullParam:[result valueForKeyPath:@"schedule.depart"]]){
            NSMutableArray* mutableArr = [NSMutableArray array];
            for (NSDictionary* departObj in [result valueForKeyPath:@"schedule.depart"]) {
                FlightSchedule* depart = [FlightSchedule listWithData:departObj];
                [mutableArr addObject:depart];
            }
            
            self.scheduleDepart = [NSOrderedSet orderedSetWithArray:mutableArr];
            
        }
        if ([self checkNullParam:[result valueForKeyPath:@"schedule.return"]]){
            NSMutableArray* mutableArr = [NSMutableArray array];
            for (NSDictionary* returnObj in [result valueForKeyPath:@"schedule.return"]) {
                FlightSchedule* returnS = [FlightSchedule listWithData:returnObj];
                [mutableArr addObject:returnS];
            }
            
            self.scheduleReturn = [NSOrderedSet orderedSetWithArray:mutableArr];
            
        }
        if ([self checkNullParam:[result valueForKey:@"search_info"]]){
            self.searchInfo = [FlightSearchInfo listWithData:[result valueForKey:@"search_info"]];
            
        }
        if ([self checkNullParam:[result valueForKey:@"session_id"]]){
            self.sessionId = [result valueForKey:@"session_id"];
            
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
