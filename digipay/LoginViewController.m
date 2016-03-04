//
//  LoginViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 1/25/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "LoginViewController.h"
#import "APIClient.h"
#import "User.h"
#import "Utils.h"

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([Utils getUserUserDefault].userToken) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"tabBarController"];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
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
    
    if (!self.isLoginAlreadyClicked) {
        if ([self.usernameTF.text isEqualToString:@""] || [self.passwordTF.text isEqualToString:@""]) {
            
            UIAlertController * alert=   [UIAlertController
                                          alertControllerWithTitle:@""
                                          message:@"Username/Password kosong"
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
            
            User *user = [[User alloc] init];
            user.email = self.usernameTF.text;
            user.password = self.passwordTF.text;
            
            [APIClient loginUser:user withSuccessBlock:^(BOOL success) {
                
                if (success) {
                    
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"tabBarController"];
                    [self presentViewController:vc animated:YES completion:nil];
                    
                }
                
                self.isLoginAlreadyClicked = NO;
                
            } andFailureBlock:^(NSString *message) {
                UIAlertController * alert =   [UIAlertController
                                               alertControllerWithTitle:@"Error"
                                               message:message
                                               preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* okBtn = [UIAlertAction
                                        actionWithTitle:@"Ok"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                        }];
                
                [alert addAction:okBtn];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                self.isLoginAlreadyClicked = NO;
            }];
        }
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
                                                 
                                                 if ([self.emailAddressTextField.text isEqualToString:@""]) {
                                                     UIAlertController * alert=   [UIAlertController
                                                                                   alertControllerWithTitle:@""
                                                                                   message:@"Email kosong"
                                                                                   preferredStyle:UIAlertControllerStyleAlert];
                                                     
                                                     UIAlertAction* okBtn = [UIAlertAction
                                                                             actionWithTitle:@"Ok"
                                                                             style:UIAlertActionStyleDefault
                                                                             handler:^(UIAlertAction * action)
                                                                             {
                                                                                 
                                                                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                                                                 
                                                                             }];
                                                     
                                                     [alert addAction:okBtn];
                                                     
                                                     [self presentViewController:alert animated:YES completion:nil];
                                                 }else{
                                                     
                                                     [APIClient forgotPassword:self.emailAddressTextField.text withSuccessBlock:^(BOOL success) {
                                                         if (success) {
                                                             
                                                             UIAlertController * alert=   [UIAlertController
                                                                                           alertControllerWithTitle:@""
                                                                                           message:@"Link berhasil dikirim ke email"
                                                                                           preferredStyle:UIAlertControllerStyleAlert];
                                                             
                                                             UIAlertAction* okBtn = [UIAlertAction
                                                                                     actionWithTitle:@"Ok"
                                                                                     style:UIAlertActionStyleDefault
                                                                                     handler:^(UIAlertAction * action)
                                                                                     {
                                                                                         
                                                                                         [alert dismissViewControllerAnimated:YES completion:nil];
                                                                                         
                                                                                     }];
                                                             
                                                             [alert addAction:okBtn];
                                                             
                                                             [self presentViewController:alert animated:YES completion:nil];
                                                             
                                                         }
                                                         
                                                     } andFailureBlock:^(NSString *message) {
                                                         
                                                         UIAlertController * alert =   [UIAlertController
                                                                                        alertControllerWithTitle:@"Error"
                                                                                        message:message
                                                                                        preferredStyle:UIAlertControllerStyleAlert];
                                                         
                                                         UIAlertAction* okBtn = [UIAlertAction
                                                                                 actionWithTitle:@"Ok"
                                                                                 style:UIAlertActionStyleDefault
                                                                                 handler:^(UIAlertAction * action)
                                                                                 {
                                                                                 }];
                                                         
                                                         [alert addAction:okBtn];
                                                         
                                                         [self presentViewController:alert animated:YES completion:nil];
                                                     }];
                                                     
                                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                                     
                                                 }
                                                 
                                             
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
