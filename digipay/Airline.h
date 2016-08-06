//
//  Airline.h
//  digipay
//
//  Created by Lutfi Azhar on 8/6/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Airline : NSObject

@property (nonatomic, strong) NSString* airlinesId;
@property (nonatomic, strong) NSString* airlinesCode;
@property (nonatomic, strong) NSString* airlinesName;
@property (nonatomic, strong) NSString* airlinesType;
@property (nonatomic, strong) NSString* connectionStatus;

+ (id)listWithData:(NSDictionary*)data;

@end
