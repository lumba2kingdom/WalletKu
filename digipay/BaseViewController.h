//
//  BaseViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 5/26/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

- (void)showNavigationBar;
- (void)hideNavigationBar;

- (void)showBasicAlertMessageWithTitle:(NSString *)title message:(NSString *)message;

@end
