//
//  PayHistoryTableViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 1/25/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "PayHistoryTableViewController.h"
#import "PayHistoryTableViewCell.h"
#import "APIClient.h"
#import "Utils.h"

@interface PayHistoryTableViewController ()

@end

@implementation PayHistoryTableViewController{
    NSArray *paymentID, *paymentStatus, *paymentDate, *paymentIcon, *paymentMessage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self paymentHistoryAPI];
    
    paymentDate = [[NSArray alloc] initWithObjects:@"2 Sep 2015", @"3 Sep 2015", @"4 Sep 2015", @"5 Sep 2015", @"6 Sep 2015", @"7 Sep 2015", @"8 Sep 2015", @"9 Sep 2015", @"10 Sep 2015", @"11 Sep 2015", nil];
    
    [self.tableView reloadData];
    
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
    return paymentID.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PayHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"payHistoryCell" forIndexPath:indexPath];
    
    cell.paymentIDLabel.text = [NSString stringWithFormat:@"%@", paymentID[indexPath.row]];
//    cell.paymentStatusLabel.text = paymentStatus[indexPath.row];
//    cell.paymentDateLabel.text = paymentDate[indexPath.row];
//    cell.iconImg.image = [UIImage imageNamed:paymentIcon[indexPath.row]];
//    
//    if ([paymentIcon[indexPath.row] isEqualToString:@"topup"]) {
//        cell.iconImg.image = [UIImage imageNamed:@"icon-hp.png"];
//    }else if ([paymentIcon[indexPath.row] isEqualToString:@"pln"]){
//        cell.iconImg.image = [UIImage imageNamed:@"icon-listrik.png"];
//    }else{
//        cell.iconImg.image = nil;
//    }
//    
//    cell.paymentDescLabel.text = paymentMessage[indexPath.row];
    
    return cell;
}

#pragma mark - API Call Methods
- (void)paymentHistoryAPI {
    [APIClient getAPIWithParam:nil andEndPoint:kGetPayment withAuthorization:YES successBlock:^(NSDictionary *response) {
        NSLog(@"PAYMENT : %@", response);
        
        NSArray *payments = [NSArray arrayWithArray:[response objectForKey:@"payments"]];
        paymentID = [NSArray arrayWithArray:[payments valueForKey:@"id"]];
//        paymentStatus = [NSArray arrayWithArray:[payments valueForKey:@"status"]];
//        paymentIcon = [NSArray arrayWithArray:[payments valueForKey:@"payment_type"]];
//        paymentMessage = [NSArray arrayWithArray:[payments valueForKey:@"message"]];
        
        [self.tableView reloadData];
        
    } andFailureBlock:^(NSString *errorMessage) {
        [Utils showDefaultAlertWithViewController:self withTitle:@"Error" andMessage:errorMessage];
    }];
}

@end
