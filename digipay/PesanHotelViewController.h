//
//  PesanHotelViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 8/9/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "BaseTableViewController.h"

@interface PesanHotelViewController : BaseTableViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet UITextField *checkInTextField;
@property (weak, nonatomic) IBOutlet UITextField *checkOutTextField;
@property (weak, nonatomic) IBOutlet UITextField *jumlahKamarTextField;
@property (weak, nonatomic) IBOutlet UITextField *adultTextField;
@property (weak, nonatomic) IBOutlet UITextField *childTextField;
@property (weak, nonatomic) IBOutlet UITextField *namaHotelTextField;

- (IBAction)nextButtonAction:(UIButton *)sender;

@end
