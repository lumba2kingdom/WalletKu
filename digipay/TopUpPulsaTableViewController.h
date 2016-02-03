//
//  TopUpPulsaTableViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 1/29/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopUpPulsaTableViewController : UITableViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *selectProviderTF;
@property (weak, nonatomic) IBOutlet UITextField *nominalTF;
@property (weak, nonatomic) IBOutlet UITextField *nomerHPTF;
@property (weak, nonatomic) IBOutlet UIView *pickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *selectProviderPicker;

- (IBAction)selectProviderBtn:(UIButton *)sender;
- (IBAction)beliBtn:(UIButton *)sender;
@end
