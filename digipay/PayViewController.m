//
//  PayViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 3/31/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "PayViewController.h"
#import "Constants.h"
#import "Utils.h"
#import "APIClient.h"

@interface PayViewController ()

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nameLabel.text = [NSString stringWithFormat:@"Hi %@,", [Utils getUserName]];
    self.balanceLabel.text = [NSString stringWithFormat:@"Saldo Anda saat ini adalah Rp. %@,-", [Utils getUserBalance]];
}

- (void)viewWillAppear:(BOOL)animated {
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self navigationController] setNavigationBarHidden:NO animated:NO];
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

@end
