//
//  FlightClass.m
//  digipay
//
//  Created by Lutfi Azhar on 8/7/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "FlightClass.h"

@implementation FlightClass

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
        if ([self checkNullParam:[result valueForKey:@"class"]]){
            self.classClass = [result valueForKey:@"class"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"class_id"]]){
            self.classId = [result valueForKey:@"class_id"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"class_name"]]){
            self.className = [result valueForKey:@"class_name"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"price"]]){
            self.classPrice = [result valueForKey:@"price"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"seat"]]){
            self.classSeat = [result valueForKey:@"seat"];
            
        }
        
        if ([self checkNullParam:[result valueForKey:@"value"]]){
            self.classValue = [result valueForKey:@"value"];
            
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
