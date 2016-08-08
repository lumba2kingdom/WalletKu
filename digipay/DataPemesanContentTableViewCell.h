//
//  DataPemesanContentTableViewCell.h
//  digipay
//
//  Created by Lutfi Azhar on 8/8/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataPemesanContentTableViewCell : UITableViewCell <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *jenisIdentitasTextField;
@property (weak, nonatomic) IBOutlet UITextField *noIdentitasTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthDateTextField;

@property (weak, nonatomic) IBOutlet UILabel *penumpangCounterLabel;

- (NSMutableDictionary *)getDataParam;

@end
