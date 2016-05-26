//
//  CallUsViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 4/1/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "CallUsViewController.h"
#import "APIManager.h"
#import "DataManager.h"


@interface CallUsViewController ()

@end

@implementation CallUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - API Calls
- (void)callUsAPI {
    [APIManager postAPIWithParam:@{
                                  @"contact": @{
                                          @"division": self.divisionTF.text,
                                          @"message": self.messageTV.text
                                          }
                                  }
                    andEndPoint:kPostCallUs withAuthorization:YES successBlock:^(NSDictionary *response) {
                        
                        [self showBasicAlertMessageWithTitle:@"Success" message:@"Pesan berhasil terkirim"];

                    } andFailureBlock:^(NSString *errorMessage) {
                        [self showBasicAlertMessageWithTitle:@"" message:errorMessage];
                    }];
}

#pragma mark - Actions
- (IBAction)sendBtn:(UIButton *)sender {
    if ([self.divisionTF.text isEqualToString:@""] || [self.messageTV.text isEqualToString:@""]) {
        [self showBasicAlertMessageWithTitle:@"" message:@"Mohon isi kolom yang kosong"];
    }else{
        [self callUsAPI];
    }
}

- (IBAction)backgroundTap:(UITapGestureRecognizer *)sender {
    [self.divisionTF resignFirstResponder];
    [self.messageTV resignFirstResponder];
}

- (IBAction)contactUsBtn:(UIButton *)sender {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Call"
                                  message:@"021 85903636?"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okBtn = [UIAlertAction
                            actionWithTitle:@"Ya"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action)
                            {
                                NSURL* url =
                                [NSURL URLWithString:@"tel://02185903636"];
                                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                                    
                                    [[UIApplication sharedApplication] openURL:
                                     url];
                                }
                            }];
    
    [alert addAction:okBtn];
    
    UIAlertAction* cancelBtn = [UIAlertAction
                                actionWithTitle:@"Batal"
                                style:UIAlertActionStyleCancel
                                handler:nil];
    
    [alert addAction:cancelBtn];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
@end
