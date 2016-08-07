//
//  TiketPesawatTableViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 8/6/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "TiketPesawatTableViewController.h"
#import "Airline.h"
#import "Airport.h"
#import "TiketSearchResultViewController.h"

@interface TiketPesawatTableViewController ()

@end

@implementation TiketPesawatTableViewController {
    NSArray *airlinesList, *departureList, *arrivalList, *oneToTenList;
    UIPickerView *airlinesPicker, *departurePicker, *arrivalPicker, *adultPicker, *childPicker, *infantPicker;
    UIDatePicker *departDatePicker, *returnDatePicker;
    NSString *airlineIdString, *departureAirportCodeString, *arrivalAirportCodeString, *departDateString, *returnDateString, *roundTrip, *adultString, *childString, *infantString;
    BOOL apiCalled;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    airlinesPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    airlinesPicker.dataSource = self;
    airlinesPicker.delegate = self;
    airlinesPicker.showsSelectionIndicator = YES;
    airlinesPicker.tag = 1;
    self.chooseAirlineTextField.inputView = airlinesPicker;
    
    departurePicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    departurePicker.dataSource = self;
    departurePicker.delegate = self;
    departurePicker.showsSelectionIndicator = YES;
    departurePicker.tag = 2;
    self.departureTextField.inputView = departurePicker;
    
    arrivalPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    arrivalPicker.dataSource = self;
    arrivalPicker.delegate = self;
    arrivalPicker.showsSelectionIndicator = YES;
    arrivalPicker.tag = 3;
    self.destinationTextField.inputView = arrivalPicker;
    
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    [toolBar setBarStyle:UIBarStyleBlackOpaque];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(categoryDoneButtonPressed:)];
    toolBar.items = @[doneBtn];
    doneBtn.tintColor=[UIColor whiteColor];
    
    self.chooseAirlineTextField.inputAccessoryView = toolBar;
    self.departureTextField.inputAccessoryView = toolBar;
    self.destinationTextField.inputAccessoryView = toolBar;
    
    
    departDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [departDatePicker setDatePickerMode:UIDatePickerModeDate];
    [departDatePicker setLocale:[self getLocale]];
    [departDatePicker addTarget:self action:@selector(departDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.dateDepartTextField.inputView = departDatePicker;
    self.dateDepartTextField.inputAccessoryView = toolBar;
    
    returnDatePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    [returnDatePicker setDatePickerMode:UIDatePickerModeDate];
    [returnDatePicker setLocale:[self getLocale]];
    [returnDatePicker addTarget:self action:@selector(returnDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    self.dateReturnTextField.inputView = returnDatePicker;
    self.dateReturnTextField.inputAccessoryView = toolBar;
    
    
    oneToTenList = [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil];
    adultPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    adultPicker.dataSource = self;
    adultPicker.delegate = self;
    adultPicker.showsSelectionIndicator = YES;
    adultPicker.tag = 4;
    self.adultTextField.inputView = adultPicker;
    self.adultTextField.inputAccessoryView = toolBar;
    
    childPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    childPicker.dataSource = self;
    childPicker.delegate = self;
    childPicker.showsSelectionIndicator = YES;
    childPicker.tag = 5;
    self.childTextField.inputView = childPicker;
    self.childTextField.inputAccessoryView = toolBar;
    
    infantPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    infantPicker.dataSource = self;
    infantPicker.delegate = self;
    infantPicker.showsSelectionIndicator = YES;
    infantPicker.tag = 6;
    self.infantTextField.inputView = infantPicker;
    self.infantTextField.inputAccessoryView = toolBar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    adultString = @"1";
    childString = @"0";
    infantString = @"0";
    airlineIdString = @"";
    departureAirportCodeString = @"";
    arrivalAirportCodeString = @"";
    departDateString = @"";
    returnDateString = @"";
    
    [self onewayButtonAction:nil];
    [self getAirlinesAPI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerView Data Source
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (pickerView.tag) {
        case 1:
            return airlinesList.count;
            break;
        case 2:
            return departureList.count;
            break;
        case 3:
            return arrivalList.count;
            break;
        case 4:
            return oneToTenList.count;
            break;
        case 5:
            return oneToTenList.count;
            break;
        case 6:
            return oneToTenList.count;
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
            Airline *airline = [Airline listWithData:[airlinesList objectAtIndex:row]];
            return airline.airlinesName;
        }
            break;
        case 2:
        {
            Airport *airport = [Airport listWithData:[departureList objectAtIndex:row]];
            return airport.airportCity;
        }
            break;
        case 3:
        {
            Airport *airport = [Airport listWithData:[arrivalList objectAtIndex:row]];
            return airport.airportCity;
        }
            break;
        case 4:
            return [oneToTenList objectAtIndex:row];
            break;
        case 5:
            return [oneToTenList objectAtIndex:row];
            break;
        case 6:
            return [oneToTenList objectAtIndex:row];
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
            Airline *airline = [Airline listWithData:[airlinesList objectAtIndex:row]];
            self.chooseAirlineTextField.text = airline.airlinesName;
            
            [self.departureTextField setText:@""];
            [self.destinationTextField setText:@""];
            
            airlineIdString = airline.airlinesId;
            departureAirportCodeString = @"";
            arrivalAirportCodeString = @"";
            
            [self getDepartureAPIWithAirlineId:airline.airlinesId];
        }
            
            break;
        case 2:
        {
            Airport *airport = [Airport listWithData:[departureList objectAtIndex:row]];
            self.departureTextField.text = airport.airportCity;
            
            [self.destinationTextField setText:@""];
            departureAirportCodeString = airport.airportCode;
            arrivalAirportCodeString = @"";
            
            if (![airlineIdString isEqualToString:@""]) {
                [self getArrivalAPIWithAirlineId:airlineIdString andDeparture:airport.airportCode];
            }else{
                [self showBasicAlertMessageWithTitle:@"" message:@"Airlines not found, please select your airlines first."];
            }
            
        }
            
            break;
        case 3:
        {
            Airport *airport = [Airport listWithData:[arrivalList objectAtIndex:row]];
            self.destinationTextField.text = airport.airportCity;
            arrivalAirportCodeString = airport.airportCode;
        }
            
            break;
        case 4:
        {
            adultString = [oneToTenList objectAtIndex:row];
            self.adultTextField.text = adultString;
        }

            break;
        case 5:
        {
            childString = [oneToTenList objectAtIndex:row];
            self.childTextField.text = childString;
        }

            break;
        case 6:
        {
            infantString = [oneToTenList objectAtIndex:row];
            self.infantTextField.text = infantString;
        }

            break;
        default:
            break;
    }
}

#pragma mark - Action Methods
- (void)categoryDoneButtonPressed:(id)sender {
    [self.chooseAirlineTextField resignFirstResponder];
    [self.departureTextField resignFirstResponder];
    [self.destinationTextField resignFirstResponder];
    [self.dateDepartTextField resignFirstResponder];
    [self.dateReturnTextField resignFirstResponder];
    [self.adultTextField resignFirstResponder];
    [self.childTextField resignFirstResponder];
    [self.infantTextField resignFirstResponder];
}

- (void)departDatePickerValueChanged:(UIDatePicker *)datePicker {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d MMMM yyyy"];
    [dateFormatter setLocale:[self getLocale]];
    self.dateDepartTextField.text = [dateFormatter stringFromDate:datePicker.date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    formatter.locale=[NSLocale localeWithLocaleIdentifier:@"no_NO"];
    departDateString = [formatter stringFromDate:datePicker.date];
    
}

- (void)returnDatePickerValueChanged:(UIDatePicker *)datePicker {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"d MMMM yyyy"];
    [dateFormatter setLocale:[self getLocale]];
    self.dateReturnTextField.text = [dateFormatter stringFromDate:datePicker.date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    formatter.locale=[NSLocale localeWithLocaleIdentifier:@"no_NO"];
    returnDateString = [formatter stringFromDate:datePicker.date];
}

- (IBAction)onewayButtonAction:(UIButton *)sender {
    [self.oneWayRadioButtonImage setImage:[UIImage imageNamed:@"radio-btn-check-orange"]];
    [self.returnRadioButtonImage setImage:[UIImage imageNamed:@"radio-btn-uncheck-orange"]];
    
    [self showDateReturn:NO];
    roundTrip = @"oneway";
}

- (IBAction)returnButtonAction:(UIButton *)sender {
    [self.oneWayRadioButtonImage setImage:[UIImage imageNamed:@"radio-btn-uncheck-orange"]];
    [self.returnRadioButtonImage setImage:[UIImage imageNamed:@"radio-btn-check-orange"]];
    
    [self showDateReturn:YES];
    roundTrip = @"return";
}

- (IBAction)searchButtonAction:(UIButton *)sender {
    if (![airlineIdString isEqualToString:@""] && ![departureAirportCodeString isEqualToString:@""] && ![arrivalAirportCodeString isEqualToString:@""]) {
        
        if ([roundTrip isEqualToString:@"oneway"]) {
            if (![departDateString isEqualToString:@""]) {
                if (!apiCalled) {
                    [self getSearchFlightResult];
                }
            }else{
                [self showBasicAlertMessageWithTitle:@"" message:@"Mohon lengkapi data yang kurang."];
            }
        }else{
            if (![departDateString isEqualToString:@""] && ![returnDateString isEqualToString:@""]) {
                if (!apiCalled) {
                    [self getSearchFlightResult];
                }
            }else{
                [self showBasicAlertMessageWithTitle:@"" message:@"Mohon lengkapi data yang kurang."];
            }
        }
        
    }else {
        [self showBasicAlertMessageWithTitle:@"" message:@"Mohon lengkapi data yang kurang."];
    }
}

#pragma mark - Custom methods
- (void)showDateReturn:(BOOL)status {
    if (status) {
        [self.dateReturnLabel setHidden:NO];
        [self.dateReturnAsterisk setHidden:NO];
        [self.dateReturnTextField setHidden:NO];
    }else{
        [self.dateReturnLabel setHidden:YES];
        [self.dateReturnAsterisk setHidden:YES];
        [self.dateReturnTextField setHidden:YES];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"tiketToSearch"]) {
        TiketSearchResultViewController *searchController = (TiketSearchResultViewController *)[segue destinationViewController];
        searchController.searchResultObject = (NSDictionary *)sender;
    }
}

#pragma mark - API methods
- (void)getAirlinesAPI {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[APIManager sharedManager] getAPIWithParam:nil andEndPoint:kGetAirlines withAuthorization:NO successBlock:^(NSDictionary *response) {
        
        if ([response valueForKey:@"airlines_data"]) {
            airlinesList = [response valueForKey:@"airlines_data"];
            [airlinesPicker reloadAllComponents];
        }
        
        airlineIdString = @"";
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } andFailureBlock:^(NSString *errorMessage) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self showBasicAlertMessageWithTitle:@"" message:errorMessage];
    }];
}

- (void)getDepartureAPIWithAirlineId:(NSString *)airlineId {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[APIManager sharedManager] getAPIWithParam:@{
                                                  @"airline":airlineId
                                                  }
                                    andEndPoint:kGetDepartureAirport withAuthorization:NO successBlock:^(NSDictionary *response) {
                                        
                                        if ([response valueForKey:@"departure_airport"]) {
                                            departureList = [response valueForKey:@"departure_airport"];
                                            [departurePicker reloadAllComponents];
                                        }
                                        
                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                    
                                    } andFailureBlock:^(NSString *errorMessage) {
                                        
                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        [self showBasicAlertMessageWithTitle:@"" message:errorMessage];
                                    }];
}

- (void)getArrivalAPIWithAirlineId:(NSString *)airlineId andDeparture:(NSString *)airportId {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[APIManager sharedManager] getAPIWithParam:@{
                                                  @"airline":airlineId,
                                                  @"departure":airportId
                                                  }
                                    andEndPoint:kGetArrivalAirport withAuthorization:NO successBlock:^(NSDictionary *response) {
                                        
                                        if ([response valueForKey:@"arrival_airport"]) {
                                            arrivalList = [response valueForKey:@"arrival_airport"];
                                            [arrivalPicker reloadAllComponents];
                                        }
                                        
                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        
                                    } andFailureBlock:^(NSString *errorMessage) {
                                        
                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        [self showBasicAlertMessageWithTitle:@"" message:errorMessage];
                                    }];
}

- (void)getSearchFlightResult {
    
    NSDictionary *params =  @{
      @"airline":airlineIdString,
      @"roundtrip":roundTrip,
      @"from":departureAirportCodeString,
      @"to":arrivalAirportCodeString,
      @"depart":departDateString,
      @"return":returnDateString,
      @"adult":adultString,
      @"child":childString,
      @"infant":infantString
      };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    apiCalled = YES;
    [[APIManager sharedManager] getAPIWithParam:params
                                    andEndPoint:kGetSearchFlight withAuthorization:NO successBlock:^(NSDictionary *response) {
                                        
                                        [self performSegueWithIdentifier:@"tiketToSearch" sender:response];
                                        
                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        apiCalled = NO;
                                    } andFailureBlock:^(NSString *errorMessage) {
                                        
                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        [self showBasicAlertMessageWithTitle:@"" message:errorMessage];
                                        apiCalled = NO;
                                    }];
}
@end
