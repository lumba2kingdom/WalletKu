//
//  TopUpViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 1/26/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "BaseViewController.h"

@interface TopUpViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UIView *pilihView;
@property (weak, nonatomic) IBOutlet UIView *dataPembayaranView;
@property (weak, nonatomic) IBOutlet UIView *konfirmasiView;

@property (weak, nonatomic) IBOutlet UIButton *bcaBtn;
@property (weak, nonatomic) IBOutlet UIButton *mandiriBtn;
@property (weak, nonatomic) IBOutlet UILabel *creditCardLabel;

@property (weak, nonatomic) IBOutlet UILabel *dataPembayaranLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


@property (weak, nonatomic) IBOutlet UIScrollView *confirmScrollView;
@property (weak, nonatomic) IBOutlet UITextField *fromAccountName;
@property (weak, nonatomic) IBOutlet UITextField *fromAccountNumber;
@property (weak, nonatomic) IBOutlet UITextField *fromSourceName;
@property (weak, nonatomic) IBOutlet UITextField *amount;
@property (weak, nonatomic) IBOutlet UITextField *toSourceName;
@property (weak, nonatomic) IBOutlet UITextField *toAccountName;
@property (weak, nonatomic) IBOutlet UITextField *toAccountNumber;

@property (weak, nonatomic) IBOutlet UIImageView *bcaRadioBtnImg;
@property (weak, nonatomic) IBOutlet UIImageView *mandiriRadioBtnImg;


- (IBAction)confirmBtn:(UIButton *)sender;


- (IBAction)dataPembayaranBtn:(UIButton *)sender;
- (IBAction)dataPembayaranBackBtn:(UIButton *)sender;

- (IBAction)bcaBtn:(UIButton *)sender;
- (IBAction)mandiriBtn:(UIButton *)sender;


- (IBAction)transferBankBtn:(UIButton *)sender;
- (IBAction)creditCardBtn:(UIButton *)sender;


@end
