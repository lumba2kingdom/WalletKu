//
//  DataPemesanTableViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 8/8/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "DataPemesanTableViewController.h"
#import "DataPemesanHeaderTableViewCell.h"
#import "DataPemesanContentTableViewCell.h"
#import "NextTableViewCell.h"

@interface DataPemesanTableViewController ()

@end

@implementation DataPemesanTableViewController {
    DataPemesanHeaderTableViewCell *pemesanHeaderCell;
    DataPemesanContentTableViewCell *pemesanContentCell;
    BOOL apiCalled;
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
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return self.totalPassenger;
            break;
        case 3:
            return 1;
            break;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            UITableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
            return headerCell;
        }
            break;
        case 1: {
            pemesanHeaderCell = [tableView dequeueReusableCellWithIdentifier:@"dataPemesanHeaderCell"];
            return pemesanHeaderCell;
        }
            break;
        case 2: {
            pemesanContentCell = [tableView dequeueReusableCellWithIdentifier:@"dataPemesanContentCell"];
            pemesanContentCell.penumpangCounterLabel.text = [NSString stringWithFormat:@"Penumpang %d", (int)indexPath.row+1];
            pemesanContentCell.tag = indexPath.row+1;
            return pemesanContentCell;
        }
            break;
        case 3: {
            NextTableViewCell *nextCell = [tableView dequeueReusableCellWithIdentifier:@"nextCell"];
            [nextCell.nextButton addTarget:self action:@selector(nextButtonAction) forControlEvents:UIControlEventTouchUpInside];
            return nextCell;
        }
            break;
            
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 150;
            break;
        case 1:
            return 265;
            break;
        case 2:
            return 460;
            break;
        case 3:
            return 150;
            break;
            
        default:
            return 0;
            break;
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Action methods
- (void)nextButtonAction {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:self.sessionId forKey:@"session_id"];
    
    [params setObject:pemesanHeaderCell.nameTextField.text forKey:@"cust_name"];
    [params setObject:pemesanHeaderCell.noHandphoneTextField.text forKey:@"cust_phone"];
    [params setObject:pemesanHeaderCell.emailTextField.text forKey:@"cust_email"];
    
    for (int i = 0; i < self.totalPassenger; i++) {
        
        DataPemesanContentTableViewCell *cell = (DataPemesanContentTableViewCell *)[self.tableView viewWithTag:i+1];
        [params addEntriesFromDictionary:[cell getDataParam]];

    }
    
    if (!apiCalled) {
        [self postSearchBookWithParam:params];
    }
    
}

#pragma mark - API method
- (void)postSearchBookWithParam:(NSDictionary *)param {
    
    apiCalled = YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[APIManager sharedManager] postAPIWithParam:param andEndPoint:kPostSearchBook withAuthorization:YES successBlock:^(NSDictionary *response) {
        
        apiCalled = NO;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } andFailureBlock:^(NSString *errorMessage) {
        
        apiCalled = NO;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showBasicAlertMessageWithTitle:@"" message:errorMessage];
    }];
}

@end
