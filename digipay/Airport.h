//
//  Airport.h
//  digipay
//
//  Created by Lutfi Azhar on 8/6/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Airport : NSObject

@property (nonatomic, strong) NSString* airportCity;
@property (nonatomic, strong) NSString* airportCode;

+ (id)listWithData:(NSDictionary*)data;

@end
