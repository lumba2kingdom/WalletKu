//
//  PayHistoryTableViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 1/25/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "PayHistoryTableViewController.h"
#import "PayHistoryTableViewCell.h"
#import "PaymentHistory.h"
#import "APIManager.h"
#import "DataManager.h"
#import "UtilityManager.h"

@interface PayHistoryTableViewController ()

@end

@implementation PayHistoryTableViewController{
    NSArray *payments;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self paymentHistoryAPI];
    
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
    return payments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PayHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payHistoryCell" forIndexPath:indexPath];
    
    PaymentHistory *payment = [PaymentHistory paymentWithData:[payments objectAtIndex:indexPath.row]];
    
    cell.providerPlusNominalLabel.text = [NSString stringWithFormat:@"%@ %@", payment.provider, payment.nominal];
    cell.paymentStatusLabel.text = payment.status;
    cell.nomorTujuanLabel.text = [NSString stringWithFormat:@"Nomor Tujuan: %@", payment.msisdn];
    cell.serialNumberLabel.text = payment.serial_number;
    cell.paymentDateLabel.text = payment.date;
    cell.hargaLabel.text = [NSString stringWithFormat:@"Harga Rp.%@,-", payment.amount];
    
    if ([payment.payment_type isEqualToString:@"topup"]) {
        cell.iconImg.image = [UIImage imageNamed:@"icon-top-up-pulsa.png"];
    }else if ([payment.payment_type isEqualToString:@"pln"]){
        cell.iconImg.image = [UIImage imageNamed:@"icon-bayar-listrik.png"];
    }else{
        cell.iconImg.image = nil;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

#pragma mark - API Call Methods
- (void)paymentHistoryAPI {
    [APIManager getAPIWithParam:nil andEndPoint:kGetPayment withAuthorization:YES successBlock:^(NSDictionary *response) {
        NSLog(@"PAYMENT : %@", response);
        
        payments = [NSArray arrayWithArray:[response objectForKey:@"payments"]];
        
//        paymentID = [NSArray arrayWithArray:[payments valueForKey:@"id"]];
//        paymentStatus = [NSArray arrayWithArray:[payments valueForKey:@"status"]];
//        paymentIcon = [NSArray arrayWithArray:[payments valueForKey:@"payment_type"]];
//        paymentMessage = [NSArray arrayWithArray:[payments valueForKey:@"message"]];
        
        [self.tableView reloadData];
        
    } andFailureBlock:^(NSString *errorMessage) {
        [UtilityManager showDefaultAlertWithViewController:self withTitle:@"Error" andMessage:errorMessage];
    }];
}

@end
