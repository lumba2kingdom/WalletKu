//
//  TopUpViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 1/26/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "TopUpViewController.h"
#import "TopupWalletFieldTableViewCell.h"
#import "APIClient.h"
#import "Utils.h"

@interface TopUpViewController ()

@end

@implementation TopUpViewController {
    NSString *sourceType, *fromAccountName, *fromAccountNumber, *toSourceName, *toAccountName, *toAccountNumber, *ammount;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TopupWalletFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"fieldCell"];
    UITableViewCell *confirmCell = [tableView dequeueReusableCellWithIdentifier:@"confirmCell"];
    
    [cell.fieldTF setTag:indexPath.row];
    
    switch (indexPath.row) {
        case 0:
            cell.fieldTF.placeholder = @"Nama Pemilik Rekening";
            fromAccountName = cell.fieldTF.text;
            break;
        case 1:
            cell.fieldTF.placeholder = @"Nomor Rekening";
            fromAccountNumber = cell.fieldTF.text;
            break;
        case 2:
            cell.fieldTF.placeholder = @"Nama Bank";
            toSourceName = cell.fieldTF.text;
            break;
        case 3:
            cell.fieldTF.placeholder = @"Jumlah Transfer";
            ammount = cell.fieldTF.text;
            break;
        case 4:
            cell.fieldTF.placeholder = @"Rekening Tujuan";
            toAccountNumber = cell.fieldTF.text;
            break;
        case 5:
            cell.fieldTF.placeholder = @"Nama Penerima";
            toAccountName = cell.fieldTF.text;
            break;
    }
    
    if (indexPath.row == 6) {
        return confirmCell;
    }else{
        return cell;
    }
    
}

#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
    if (indexPath.row == 6) {
        
        [self callTransferConfirmationAPI];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Actions
- (IBAction)dataPembayaranBtn:(UIButton *)sender {
    [self.dataPembayaranView setHidden:YES];
    [self.konfirmasiView setHidden:NO];
}

- (IBAction)bcaBtn:(UIButton *)sender {
    [self.pilihView setHidden:YES];
    [self.dataPembayaranView setHidden:NO];
    [self.dataPembayaranLabel setText:@"BCA 1122334456789 \nAtas nama PT Dian Kencana \nKCP Semanggi"];
    sourceType = @"BCA";
}

- (IBAction)mandiriBtn:(UIButton *)sender {
    [self.pilihView setHidden:YES];
    [self.dataPembayaranView setHidden:NO];
    [self.dataPembayaranLabel setText:@"MANDIRI 1122334456789 \nAtas nama PT Dian Kencana \nKCP Matraman"];
    sourceType = @"MANDIRI";
}

- (IBAction)transferBankBtn:(UIButton *)sender {
    [self.bcaBtn setHidden:NO];
    [self.mandiriBtn setHidden:NO];
    [self.creditCardLabel setHidden:YES];
}

- (IBAction)creditCardBtn:(UIButton *)sender {
    [self.bcaBtn setHidden:YES];
    [self.mandiriBtn setHidden:YES];
    [self.creditCardLabel setHidden:NO];
}


#pragma mark - API Calls
- (void)callTransferConfirmationAPI {
    [APIClient postAPIWithParam:@{
                                  @"transfer_confirmation":@{
                                          @"source_type": @"bank",
                                          @"from_source_name": sourceType,
                                          @"from_account_name": fromAccountName,
                                          @"from_account_number": fromAccountNumber,
                                          @"to_source_name": toSourceName,
                                          @"to_account_name": toAccountName,
                                          @"to_account_number": toAccountNumber,
                                          @"ammount": ammount,
                                          @"image": @"",
                                          @"note": @""
                                          }
                                  }andEndPoint:kPostTransferConfirmation withAuthorization:YES successBlock:^(NSDictionary *response) {
                                      [Utils showDefaultAlertWithViewController:self withTitle:@"Success" andMessage:@"Transfer Confirmation Success"];
                                  } andFailureBlock:^(NSString *errorMessage) {
                                      [Utils showDefaultAlertWithViewController:self withTitle:@"Error" andMessage:errorMessage];
                                  }];
}
@end
