//
//  MyWalletViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 3/31/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "MyWalletViewController.h"
#import "Utils.h"

@interface MyWalletViewController ()

@end

@implementation MyWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.balanceText.text = [NSString stringWithFormat:@"Rp. %@,-", [Utils getUserBalance]];
    self.pointText.text = [NSString stringWithFormat:@"%@", [Utils getUserPoin]];
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
