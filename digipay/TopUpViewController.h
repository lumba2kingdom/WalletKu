//
//  TopUpViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 1/26/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopUpViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIView *pilihView;
@property (weak, nonatomic) IBOutlet UIView *dataPembayaranView;
@property (weak, nonatomic) IBOutlet UIView *konfirmasiView;

@property (weak, nonatomic) IBOutlet UIButton *bcaBtn;
@property (weak, nonatomic) IBOutlet UIButton *mandiriBtn;
@property (weak, nonatomic) IBOutlet UILabel *creditCardLabel;

@property (weak, nonatomic) IBOutlet UILabel *dataPembayaranLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)dataPembayaranBtn:(UIButton *)sender;

- (IBAction)bcaBtn:(UIButton *)sender;
- (IBAction)mandiriBtn:(UIButton *)sender;


- (IBAction)transferBankBtn:(UIButton *)sender;
- (IBAction)creditCardBtn:(UIButton *)sender;


@end
