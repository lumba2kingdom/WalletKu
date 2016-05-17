//
//  ChangePasswordAndPinTableViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 4/1/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "ChangePasswordAndPinTableViewController.h"
#import "APIClient.h"
#import "Utils.h"

@interface ChangePasswordAndPinTableViewController ()

@end

@implementation ChangePasswordAndPinTableViewController {
    BOOL isForPIN;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.segmentedControl addTarget:self action:@selector(segmentedAction:) forControlEvents:UIControlEventValueChanged];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Methods
- (void)segmentedAction:(id)sender{
    
    switch ((int)[sender selectedSegmentIndex]) {
        case 0:
        {
            isForPIN = NO;
            self.passwordLamaLabel.text = @"Password Lama";
            self.passwordBaruLabel.text = @"Password Baru";
            self.ulangiPasswordLabel.text = @"Ulangi Password Baru";
        }
            break;
        case 1:
        {
            isForPIN = YES;
            self.passwordLamaLabel.text = @"PIN Lama";
            self.passwordBaruLabel.text = @"PIN Baru";
            self.ulangiPasswordLabel.text = @"Ulangi PIN Baru";
        }
            break;
            
        default:
            break;
    }
    [self clearAllTextField];
}

- (void)clearAllTextField {
    [self.passwordLamaTF becomeFirstResponder];
    self.passwordLamaTF.text = @"";
    self.passwordBaruTF.text = @"";
    self.ulangiPasswordTF.text = @"";
}

- (IBAction)simpanBtn:(UIButton *)sender {
    
    if ([self.passwordLamaTF.text isEqualToString:@""] || [self.passwordBaruTF.text isEqualToString:@""] || [self.ulangiPasswordTF.text isEqualToString:@""]) {
        [Utils showDefaultAlertWithViewController:self withTitle:@"Error" andMessage:@"Mohon isi kolom yang kosong"];
    }else{
        
        if (!isForPIN) {
            [self changePassword];
        }else{
            [self changePIN];
        }
        
    }
}

#pragma mark - API Calls
- (void)changePassword {
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@", kPostUsers, [Utils getUserId]];
    [APIClient putAPIWithParam:@{
                                 @"user":@{
                                         @"old_password": self.passwordLamaTF.text,
                                         @"password": self.passwordBaruTF.text,
                                         @"password_confirmation": self.ulangiPasswordTF.text
                                         }
                                 }andEndPoint:endpoint withAuthorization:YES successBlock:^(NSDictionary *response) {
                                     [Utils showDefaultAlertWithViewController:self withTitle:@"Success" andMessage:@"Password changed successfuly"];
                                 } andFailureBlock:^(NSString *errorMessage) {
                                     [Utils showDefaultAlertWithViewController:self withTitle:@"Error" andMessage:@"Error changing password from server"];
                                 }];
}

- (void)changePIN {
    
    NSString *endpoint = [NSString stringWithFormat:@"%@/%@", kPostUsers, [Utils getUserId]];
    [APIClient putAPIWithParam:@{
                                 @"user":@{
                                         @"old_pin": self.passwordLamaTF.text,
                                         @"pin": self.passwordBaruTF.text,
                                         @"pin_confirmation": self.ulangiPasswordTF.text
                                         }
                                 }andEndPoint:endpoint withAuthorization:YES successBlock:^(NSDictionary *response) {
                                     [Utils showDefaultAlertWithViewController:self withTitle:@"Success" andMessage:@"PIN changed successfuly"];
                                     [Utils setPINStatus:@"yes"];
                                 } andFailureBlock:^(NSString *errorMessage) {
                                     [Utils showDefaultAlertWithViewController:self withTitle:@"Error" andMessage:@"Error changing PIN from server"];
                                 }];
}
@end
