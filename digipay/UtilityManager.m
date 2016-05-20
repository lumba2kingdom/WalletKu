//
//  UtilityManager.m
//  digipay
//
//  Created by Lutfi Azhar on 5/21/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "UtilityManager.h"

@implementation UtilityManager

#pragma mark - UIAlertController

+(void)showDefaultAlertWithViewController:(UIViewController *)viewController withTitle:(NSString *)title andMessage:(NSString *)message {
    
    UIAlertController * alert =   [UIAlertController
                                   alertControllerWithTitle:title
                                   message:message
                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okBtn = [UIAlertAction
                            actionWithTitle:@"Ok"
                            style:UIAlertActionStyleDefault
                            handler:nil];
    
    [alert addAction:okBtn];
    
    [viewController presentViewController:alert animated:YES completion:nil];
}

@end
