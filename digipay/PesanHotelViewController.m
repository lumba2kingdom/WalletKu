//
//  PesanHotelViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 8/9/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "PesanHotelViewController.h"
#import "HotelListViewController.h"

@interface PesanHotelViewController ()

@end

@implementation PesanHotelViewController {
    NSArray *oneToTenList;
    UIPickerView *jumlahKamarPicker, *adultPicker, *childPicker;
    UIDatePicker *checkInDatePicker, *checkOutDatePicker;
    NSString *checkInString, *checkOutString, *jumlahKamarString, *adultString, *childString, *sessionId;
    BOOL apiCalled;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(categoryDoneButtonPressed:)];
    toolBar.items = @[doneBtn];
    doneBtn.tintColor=[UIColor whiteColor];
    
    checkInDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [checkInDatePicker setDatePickerMode:UIDatePickerModeDate];
    [checkInDatePicker setLocale:[self getLocale]];
    [checkInDatePicker addTarget:self action:@selector(checkInDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.checkInTextField.inputView = checkInDatePicker;
    self.checkInTextField.inputAccessoryView = toolBar;
    
    checkOutDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [checkOutDatePicker setDatePickerMode:UIDatePickerModeDate];
    [checkOutDatePicker setLocale:[self getLocale]];
    [checkOutDatePicker addTarget:self action:@selector(checkOutDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.checkOutTextField.inputView = checkOutDatePicker;
    self.checkOutTextField.inputAccessoryView = toolBar;
    
    oneToTenList = [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil];
    jumlahKamarPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    jumlahKamarPicker.dataSource = self;
    jumlahKamarPicker.delegate = self;
    jumlahKamarPicker.showsSelectionIndicator = YES;
    jumlahKamarPicker.tag = 1;
    self.jumlahKamarTextField.inputView = jumlahKamarPicker;
    self.jumlahKamarTextField.inputAccessoryView = toolBar;
    
    adultPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    adultPicker.dataSource = self;
    adultPicker.delegate = self;
    adultPicker.showsSelectionIndicator = YES;
    adultPicker.tag = 2;
    self.adultTextField.inputView = adultPicker;
    self.adultTextField.inputAccessoryView = toolBar;
    
    childPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    childPicker.dataSource = self;
    childPicker.delegate = self;
    childPicker.showsSelectionIndicator = YES;
    childPicker.tag = 3;
    self.childTextField.inputView = childPicker;
    self.childTextField.inputAccessoryView = toolBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    jumlahKamarString = @"0";
    adultString = @"0";
    childString = @"0";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIPickerView Data Source
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return oneToTenList.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [oneToTenList objectAtIndex:row];
}

#pragma mark - UIPickerView Delegate Methods
- (void)pickerView:(UIPickerView *)pickerView didSelectRow: (NSInteger)row inComponent:(NSInteger)component
{
    switch (pickerView.tag) {
        case 1:
        {
            jumlahKamarString = [oneToTenList objectAtIndex:row];
            self.jumlahKamarTextField.text = jumlahKamarString;
        }
            
            break;
        case 2:
        {
            adultString = [oneToTenList objectAtIndex:row];
            self.adultTextField.text = adultString;
        }
            
            break;
        case 3:
        {
            childString = [oneToTenList objectAtIndex:row];
            self.childTextField.text = childString;
        }
            
            break;
        default:
            break;
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"hotelToSearch"]) {
        HotelListViewController *hotelList = (HotelListViewController *)[segue destinationViewController];
        hotelList.hotelListData = [[NSMutableArray alloc]initWithArray:(NSMutableArray *)sender];
        hotelList.sessionId = sessionId;
    }
}

#pragma mark - Action methods
- (void)categoryDoneButtonPressed:(id)sender {
    [self.checkInTextField resignFirstResponder];
    [self.checkOutTextField resignFirstResponder];
    [self.jumlahKamarTextField resignFirstResponder];
    [self.adultTextField resignFirstResponder];
    [self.childTextField resignFirstResponder];
}

- (void)checkInDatePickerValueChanged:(UIDatePicker *)datePicker {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d MMMM yyyy"];
    [dateFormatter setLocale:[self getLocale]];
    self.checkInTextField.text = [dateFormatter stringFromDate:datePicker.date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    formatter.locale=[NSLocale localeWithLocaleIdentifier:@"no_NO"];
    checkInString = [formatter stringFromDate:datePicker.date];
    
}

- (void)checkOutDatePickerValueChanged:(UIDatePicker *)datePicker {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d MMMM yyyy"];
    [dateFormatter setLocale:[self getLocale]];
    self.checkOutTextField.text = [dateFormatter stringFromDate:datePicker.date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    formatter.locale=[NSLocale localeWithLocaleIdentifier:@"no_NO"];
    checkOutString = [formatter stringFromDate:datePicker.date];
    
}

- (IBAction)nextButtonAction:(UIButton *)sender {
    if (![self.cityTextField.text isEqualToString:@""] && checkInString && checkOutString) {
        [self getAPISearchHotel];
    }else{
        [self showBasicAlertMessageWithTitle:@"" message:@"Data tidak lengkap."];
    }
}

#pragma mark - API method
- (void)getAPISearchHotel {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    apiCalled = YES;
    [[APIManager sharedManager] getAPIWithParam:@{
                                                  @"city":self.cityTextField.text,
                                                  @"ci":checkInString,
                                                  @"co":checkOutString,
                                                  @"room":jumlahKamarString,
                                                  @"adult":adultString,
                                                  @"child":childString,
                                                  @"hotel_name":self.namaHotelTextField.text
                                                  }andEndPoint:kGetHotelSearch withAuthorization:NO successBlock:^(NSDictionary *response) {
                                                      
                                                      sessionId = [response valueForKey:@"session_id"];
                                                      [self performSegueWithIdentifier:@"hotelToSearch" sender:[response valueForKey:@"result_data"]];
                                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                      apiCalled = NO;
                                                  } andFailureBlock:^(NSString *errorMessage) {
                                                      
                                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                      [self showBasicAlertMessageWithTitle:@"" message:errorMessage];
                                                      apiCalled = NO;
                                                      
                                                  }];
}

@end
