//
//  LoginViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 1/25/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Actions

- (IBAction)tapGestureView:(UITapGestureRecognizer *)sender {
    [self.usernameTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
}

- (IBAction)loginBtn:(UIButton *)sender {
    
    if (![self.usernameTF.text isEqualToString:@"digipay"] || ![self.passwordTF.text isEqualToString:@"123456"]) {
        
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@""
                                      message:@"Username/Password salah"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okBtn = [UIAlertAction
                                actionWithTitle:@"Ok"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    
                                }];
        
        [alert addAction:okBtn];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"tabBarController"];
        [self presentViewController:vc animated:YES completion:nil];

    }
}

- (IBAction)forgotPasswordBtn:(UIButton *)sender {
    
    UIAlertController* alert =
    [UIAlertController alertControllerWithTitle:@"Lupa Password"
                                        message:@"Ketik alamat email Anda, dan kami akan kirimkan link lupa password ke alamat email Anda"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        
        textField.keyboardType = UIKeyboardTypeEmailAddress;
        self.emailAddressTextField = textField;
    }];
    
    [alert addAction: [UIAlertAction actionWithTitle:@"Selesai"
                                               style:UIAlertActionStyleDefault
                                             handler:^(UIAlertAction *action) {
                                                 
                                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                             
                                             }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Batal"
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction *action) {
                                                
                                                [alert dismissViewControllerAnimated:YES completion:nil];
                                                
                                            }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - iOS-Slide-Menu Methods
- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

@end
