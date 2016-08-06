//
//  TopUpViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 1/26/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "TopUpViewController.h"
#import "TopupWalletFieldTableViewCell.h"

@interface TopUpViewController ()

@end

@implementation TopUpViewController {
    NSString *sourceType;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.bcaBtn setHidden:YES];
    [self.mandiriBtn setHidden:YES];
    [self.bcaRadioBtnImg setHidden:YES];
    [self.mandiriRadioBtnImg setHidden:YES];
    [self.infoLabel setHidden:YES];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)confirmBtn:(UIButton *)sender {
    if ([_fromAccountName.text isEqualToString:@""] || [_fromAccountNumber.text isEqualToString:@""] || [_toSourceName.text isEqualToString:@""] || [_toAccountName.text isEqualToString:@""] || [_toAccountNumber.text isEqualToString:@""] || [_amount.text isEqualToString:@""]) {
        
        [self showBasicAlertMessageWithTitle:@"" message:@"Mohon isi kolom yang kosong"];
        
    }else{
        [self callTransferConfirmationAPI];
    }
}

- (IBAction)dataPembayaranBtn:(UIButton *)sender {
    [self.dataPembayaranView setHidden:YES];
    [self.konfirmasiView setHidden:NO];
    
    self.toSourceName.text = sourceType;
}

- (IBAction)dataPembayaranBackBtn:(UIButton *)sender {
    [self.pilihView setHidden:NO];
    [self.dataPembayaranView setHidden:YES];
}

- (IBAction)bcaBtn:(UIButton *)sender {
    [self.pilihView setHidden:YES];
    [self.dataPembayaranView setHidden:NO];
    [self.dataPembayaranLabel setText:@"BCA 4910050180 \nAtas nama Dian Hariani \nKCP Semanggi"];
    sourceType = @"BCA";
    self.toAccountName.text = @"Dian Hariani";
    self.toAccountNumber.text = @"4910050180";
    
    self.mandiriRadioBtnImg.image = [UIImage imageNamed:@"radio-btn-check"];
    self.bcaRadioBtnImg.image = [UIImage imageNamed:@"radio-btn-uncheck"];
}

- (IBAction)mandiriBtn:(UIButton *)sender {
    [self.pilihView setHidden:YES];
    [self.dataPembayaranView setHidden:NO];
    [self.dataPembayaranLabel setText:@"MANDIRI 1250003238888 \nAtas nama Dian Hariani \nKCP Matraman"];
    sourceType = @"MANDIRI";
    self.toAccountName.text = @"Dian Hariani";
    self.toAccountNumber.text = @"1250003238888";
    
    self.mandiriRadioBtnImg.image = [UIImage imageNamed:@"radio-btn-uncheck"];
    self.bcaRadioBtnImg.image = [UIImage imageNamed:@"radio-btn-check"];
}

- (IBAction)transferBankBtn:(UIButton *)sender {
    [self.bcaBtn setHidden:NO];
    [self.mandiriBtn setHidden:NO];
    [self.bcaRadioBtnImg setHidden:NO];
    [self.mandiriRadioBtnImg setHidden:NO];
    [self.infoLabel setHidden:NO];
    [self.creditCardLabel setHidden:YES];
}

- (IBAction)creditCardBtn:(UIButton *)sender {
    [self.bcaBtn setHidden:YES];
    [self.mandiriBtn setHidden:YES];
    [self.bcaRadioBtnImg setHidden:YES];
    [self.mandiriRadioBtnImg setHidden:YES];
    [self.infoLabel setHidden:NO];
    [self.creditCardLabel setHidden:NO];
}

#pragma mark - API Calls
- (void)callTransferConfirmationAPI {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[APIManager sharedManager] postAPIWithParam:@{
                                  @"deposit":@{
                                          @"source_type": @"bank",
                                          @"from_source_name": _fromSourceName.text,
                                          @"from_account_name": _fromAccountName.text,
                                          @"from_account_number": _fromAccountNumber.text,
                                          @"to_source_name": _toSourceName.text,
                                          @"to_account_name": _toAccountName.text,
                                          @"to_account_number": _toAccountNumber.text,
                                          @"amount": _amount.text,
                                          @"image": @"",
                                          @"note": @"Baru isi saldo"
                                          }
                                  }andEndPoint:kPostTransferConfirmation withAuthorization:YES successBlock:^(NSDictionary *response) {
                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                                      [self showBasicAlertMessageWithTitle:@"" message:@"Transfer Confirmation Success"];
                                  } andFailureBlock:^(NSString *errorMessage) {
                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                                      [self showBasicAlertMessageWithTitle:@"" message:errorMessage];
                                  }];
}

@end
