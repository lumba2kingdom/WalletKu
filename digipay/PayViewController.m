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

    NSString* getUserDataEndPoint = [NSString stringWithFormat:@"%@/%@", kPostUsers, [Utils getUserId]];
    [APIClient getAPIWithParam:nil andEndPoint:getUserDataEndPoint withAuthorization:YES successBlock:^(NSDictionary *response) {
        if (response) {
            
            NSDictionary *userDict = (NSDictionary*)[response objectForKey:@"user"];
            
            User *newUser = [[User alloc] init];
            
//            newUser.address = [userDict valueForKey:@"address"];
            newUser.email = [userDict valueForKey:@"email"];
            newUser.userId = [userDict valueForKey:@"id"];
            newUser.name = [userDict valueForKey:@"name"];
//            newUser.noHP = [userDict valueForKey:@"phone"];
//            newUser.avatarUrl = [userDict valueForKey:@"avatar_url"];
//            newUser.noKTP = [userDict valueForKey:@"no_ktp"];
            newUser.isPremium = [userDict valueForKey:@"premium"];
            newUser.referral_id = [userDict valueForKey:@"referral_id"];
            newUser.totalBalance = [userDict valueForKey:@"total_balance"];
            newUser.totalBonus = [userDict valueForKey:@"total_bonus"];
            newUser.totalPoint = [userDict valueForKey:@"total_point"];
            newUser.uid = [userDict valueForKey:@"uid"];
            
            [Utils addUserToUserDefault:newUser];
        }
    } andFailureBlock:^(NSString *errorMessage) {
        
    }];
    
    self.nameLabel.text = [NSString stringWithFormat:@"Hi %@,", [Utils getUserName]];
    self.balanceLabel.text = [NSString stringWithFormat:@"Saldo Anda saat ini adalah Rp. %@,-", [Utils getUserBalance]];
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
