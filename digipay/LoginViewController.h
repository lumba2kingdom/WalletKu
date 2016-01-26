//
//  LoginViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 1/25/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *usernameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
- (IBAction)loginBtn:(UIButton *)sender;
- (IBAction)tapGestureView:(UITapGestureRecognizer *)sender;
- (IBAction)forgotPasswordBtn:(UIButton *)sender;
@property (nonatomic, weak) UITextField* emailAddressTextField;

@end
