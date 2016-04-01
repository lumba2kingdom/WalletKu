//
//  MenuTableViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 1/26/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "MenuTableViewController.h"
#import "Constants.h"
#import "APIClient.h"
#import "Utils.h"

@interface MenuTableViewController ()

@end

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self profileAPI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //LOGOUT ACTION
    if (indexPath.row == 6) {
        UIAlertController * alert=   [UIAlertController
                                      alertControllerWithTitle:@""
                                      message:@"Apakah Anda yakin?"
                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* okBtn = [UIAlertAction
                                actionWithTitle:@"Ya"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action)
                                {
                                    //remove session user defaults
                                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserDefaultsUserKey];
                                    
                                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
                                    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"loginController"];
                                    [self presentViewController:vc animated:YES completion:nil];
                                    
                                }];
        
        [alert addAction:okBtn];
        
        UIAlertAction* cancelBtn = [UIAlertAction
                                actionWithTitle:@"Batal"
                                style:UIAlertActionStyleCancel
                                handler:^(UIAlertAction * action)
                                {
                                    
                                    
                                }];
        
        [alert addAction:cancelBtn];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
}

#pragma mark - API Call Methods
- (void)profileAPI {
    NSString* getUserDataEndPoint = [NSString stringWithFormat:@"%@/%@", kPostUsers, [Utils getUserId]];
    [APIClient getAPIWithParam:nil andEndPoint:getUserDataEndPoint withAuthorization:YES successBlock:^(NSDictionary *response) {
        if (response) {
            
            NSDictionary *userDict = (NSDictionary*)[response objectForKey:@"user"];
            
            User *newUser = [[User alloc] init];
            
            newUser.address = [userDict valueForKey:@"address"];
            newUser.email = [userDict valueForKey:@"email"];
            newUser.userId = [userDict valueForKey:@"id"];
            newUser.name = [userDict valueForKey:@"name"];
            newUser.noHP = [userDict valueForKey:@"phone"];
            newUser.avatarUrl = [userDict valueForKey:@"avatar_url"];
            newUser.noKTP = [userDict valueForKey:@"no_ktp"];
            newUser.isPremium = [userDict valueForKey:@"premium"];
            newUser.referral_id = [userDict valueForKey:@"referral_id"];
            newUser.totalBalance = [userDict valueForKey:@"total_balance"];
            newUser.totalBonus = [userDict valueForKey:@"total_bonus"];
            newUser.totalPoint = [userDict valueForKey:@"total_point"];
            newUser.uid = [userDict valueForKey:@"uid"];
            
            [Utils addUserToUserDefault:newUser];
        }
    } andFailureBlock:^(NSString *errorMessage) {
        [Utils showDefaultAlertWithViewController:self withTitle:@"Profile" andMessage:@"Error getting data from server"];
    }];
}

@end
