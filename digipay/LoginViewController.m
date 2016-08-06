//
//  LoginViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 1/25/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"

@interface LoginViewController ()

@end

@implementation LoginViewController {
    NSTimer *autoLogoutTimer;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideNavigationBar];
    
    if ([DataManager getUserToken]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"tabBarController"];
        [self presentViewController:vc animated:YES completion:nil];
    }
    
    if ([DataManager getUserRememberMeEmail]) {
        self.usernameTF.text = [DataManager getUserRememberMeEmail];
    }else{
        self.usernameTF.text = @"";
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showNavigationBar];
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
    
    if (!self.isLoginAlreadyClicked) {
        if ([self.usernameTF.text isEqualToString:@""] || [self.passwordTF.text isEqualToString:@""]) {
            
            [self showBasicAlertMessageWithTitle:@"" message:@"Username/Password kosong"];
            
        }else{
            
            self.isLoginAlreadyClicked = YES;
            [self loginAPI];
            
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
                                                     
                                                     [self forgotPasswordAPI];
                                                     
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

- (void)logoutTask
{
    autoLogoutTimer = [NSTimer scheduledTimerWithTimeInterval:autoLogoutTimerInSeconds target:self selector:@selector(performBackgroundTask) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:autoLogoutTimer forMode:NSRunLoopCommonModes];
}

- (void)performBackgroundTask
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //remove session user defaults
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultsUserKey];
        //remove session token
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultsTokenKey];
        
        //set auto logout status
        [DataManager setAutoLogoutStatus:@"yes"];
        
        [autoLogoutTimer invalidate];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [autoLogoutTimer invalidate];
        });
    });
}

#pragma mark - API Call Methods
- (void)loginAPI{
    [[APIManager sharedManager] postAPIWithParam:@{
                                  @"user": @{
                                          @"email":self.usernameTF.text,
                                          @"password":self.passwordTF.text
                                          }
                                  }
                    andEndPoint:kPostAuthentication withAuthorization:NO successBlock:^(NSDictionary *response) {
                        
                        User *userData = [User userWithData:response];
                        [DataManager addUserToUserDefault:userData];
                        
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"tabBarController"];
                        [self presentViewController:vc animated:YES completion:nil];
                        
                        [self logoutTask];
                        
                        if (self.rememberMeSwitch.on) {
                            [DataManager addRememberMeEmailToUserDefault:self.usernameTF.text];
                        }else{
                            [DataManager addRememberMeEmailToUserDefault:@""];
                        }
                        
                        [DataManager setAutoLogoutStatus:@"no"];
                        self.isLoginAlreadyClicked = NO;
                    } andFailureBlock:^(NSString *errorMessage) {
                        self.isLoginAlreadyClicked = NO;
                        
                        [self showBasicAlertMessageWithTitle:@"" message:errorMessage];
                        
                    }];
}

- (void)forgotPasswordAPI {
    [[APIManager sharedManager] postAPIWithParam:@{
                                  @"password_reset": @{
                                          @"email": self.emailAddressTextField.text
                                          }
                                  }
                    andEndPoint:kPostForgotPassword
              withAuthorization:NO successBlock:^(NSDictionary *response) {
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
              } andFailureBlock:^(NSString *errorMessage) {
                  
                  [self showBasicAlertMessageWithTitle:@"" message:errorMessage];
                  
              }];
}

@end
