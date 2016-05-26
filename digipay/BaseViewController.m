//
//  BaseViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 5/26/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

#pragma mark - Lifecycle
- (void)loadView {
    [super loadView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods
- (void)showNavigationBar {
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
}

- (void)hideNavigationBar {
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

#pragma mark - Show Alert View
- (void)showBasicAlertMessageWithTitle:(NSString *)title message:(NSString *)message {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8) {
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil, nil];
        
        [alert show];
        
    } else {
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

@end
