//
//  DataPemesanContentTableViewCell.m
//  digipay
//
//  Created by Lutfi Azhar on 8/8/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "DataPemesanContentTableViewCell.h"

@implementation DataPemesanContentTableViewCell {
    NSArray *titleArray, *jenisIdentitasArray;
    UIPickerView *titlePicker, *jenisIdentitasPicker;
    UIDatePicker *dateBirthPicker;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    titleArray = [NSArray arrayWithObjects:@"Mr", @"Mrs", @"Ms", nil];
    jenisIdentitasArray = [NSArray arrayWithObjects:@"KTP", @"SIM", @"Passport", nil];
    
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 44)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(categoryDoneButtonPressed:)];
    toolBar.items = @[doneBtn];
    doneBtn.tintColor=[UIColor whiteColor];
    
    titlePicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    titlePicker.dataSource = self;
    titlePicker.delegate = self;
    titlePicker.showsSelectionIndicator = YES;
    titlePicker.tag = 1;
    self.titleTextField.inputView = titlePicker;
    self.titleTextField.inputAccessoryView = toolBar;
    
    jenisIdentitasPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    jenisIdentitasPicker.dataSource = self;
    jenisIdentitasPicker.delegate = self;
    jenisIdentitasPicker.showsSelectionIndicator = YES;
    jenisIdentitasPicker.tag = 2;
    self.jenisIdentitasTextField.inputView = jenisIdentitasPicker;
    self.jenisIdentitasTextField.inputAccessoryView = toolBar;
    
    dateBirthPicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [dateBirthPicker setDatePickerMode:UIDatePickerModeDate];
    [dateBirthPicker setLocale:[NSLocale localeWithLocaleIdentifier:@"id_ID"]];
    [dateBirthPicker addTarget:self action:@selector(dateBirthPickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.birthDateTextField.inputView = dateBirthPicker;
    self.birthDateTextField.inputAccessoryView = toolBar;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (NSMutableDictionary *)getDataParam {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    NSString *paxType = [NSString stringWithFormat:@"pax_type_%d",(int)self.tag];
    [params setObject:@"Adult" forKey:paxType];
    
    NSString *title = [NSString stringWithFormat:@"title_%d",(int)self.tag];
    [params setObject:self.titleTextField.text forKey:title];
    
    NSString *firstName = [NSString stringWithFormat:@"first_name_%d",(int)self.tag];
    [params setObject:self.firstNameTextField.text forKey:firstName];
    
    NSString *lastName = [NSString stringWithFormat:@"last_name_%d",(int)self.tag];
    [params setObject:self.lastNameTextField.text forKey:lastName];
    
    NSString *idNo = [NSString stringWithFormat:@"id_no_%d",(int)self.tag];
    [params setObject:self.noIdentitasTextField.text forKey:idNo];
    
    NSString *birthdate = [NSString stringWithFormat:@"birthdate_%d",(int)self.tag];
    [params setObject:self.birthDateTextField.text forKey:birthdate];
    
    NSString *paspor = [NSString stringWithFormat:@"paspor_%d",(int)self.tag];
    [params setObject:@"" forKey:paspor];
    
    NSString *expirePaspor = [NSString stringWithFormat:@"expire_paspor_%d",(int)self.tag];
    [params setObject:@"" forKey:expirePaspor];
    
    NSString *countryPaspor = [NSString stringWithFormat:@"country_paspor_%d",(int)self.tag];
    [params setObject:@"" forKey:countryPaspor];
    
    return params;
}

#pragma mark - UIPickerView Data Source
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (pickerView.tag) {
        case 1:
            return titleArray.count;
            break;
        case 2:
            return jenisIdentitasArray.count;
            break;
        default:
            return 0;
            break;
    }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (pickerView.tag) {
        case 1:
        {
            return [titleArray objectAtIndex:row];
        }
            break;
        case 2:
        {
            return [jenisIdentitasArray objectAtIndex:row];
        }
            break;
        default:
            return @"";
            break;
    }
    
    
}

#pragma mark - UIPickerView Delegate Methods
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 1:
        {
            self.titleTextField.text = [titleArray objectAtIndex:row];
        }
            
            break;
        case 2:
        {
            self.jenisIdentitasTextField.text = [jenisIdentitasArray objectAtIndex:row];
        }
            
            break;
        default:
            break;
    }
}

#pragma mark - Action Methods
- (void)categoryDoneButtonPressed:(id)sender {
    [self.titleTextField resignFirstResponder];
    [self.jenisIdentitasTextField resignFirstResponder];
    [self.birthDateTextField resignFirstResponder];
}

- (void)dateBirthPickerValueChanged:(UIDatePicker *)datePicker {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    formatter.locale=[NSLocale localeWithLocaleIdentifier:@"no_NO"];
    self.birthDateTextField.text = [formatter stringFromDate:datePicker.date];
    
}

@end
