//
//  UtilityManager.h
//  digipay
//
//  Created by Lutfi Azhar on 5/21/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UtilityManager : NSObject

+(void)showDefaultAlertWithViewController:(UIViewController *)viewController withTitle:(NSString *)title andMessage:(NSString *)message;

@end
