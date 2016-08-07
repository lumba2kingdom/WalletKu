//
//  BaseTableViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 5/26/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UITableViewController

- (void)showNavigationBar;
- (void)hideNavigationBar;
- (NSLocale *)getLocale;
- (void)showBasicAlertMessageWithTitle:(NSString *)title message:(NSString *)message;

@end
