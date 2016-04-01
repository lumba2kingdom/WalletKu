//
//  ChangePasswordAndPinTableViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 4/1/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePasswordAndPinTableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *passwordLamaLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordLamaTF;

@property (weak, nonatomic) IBOutlet UILabel *passwordBaruLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordBaruTF;

@property (weak, nonatomic) IBOutlet UILabel *ulangiPasswordLabel;
@property (weak, nonatomic) IBOutlet UITextField *ulangiPasswordTF;

- (IBAction)simpanBtn:(UIButton *)sender;
@end
