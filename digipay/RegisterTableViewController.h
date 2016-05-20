//
//  RegisterTableViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 1/26/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"

@interface RegisterTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *namaTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *alamatTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *ulangPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *noReferralTF;
@property (weak, nonatomic) IBOutlet UISwitch *pernyataanSwitch;
@property (weak, nonatomic) IBOutlet UISegmentedControl *premiumSegmented;

@property BOOL isSignUpAlreadyClicked;
- (IBAction)premieumSegmented:(UISegmentedControl *)sender;

- (IBAction)daftarBtn:(UIButton *)sender;

@end
