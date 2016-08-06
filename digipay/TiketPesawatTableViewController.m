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

@interface TiketPesawatTableViewController ()

@end

@implementation TiketPesawatTableViewController {
    NSArray *airlinesList, *departureList;
    UIPickerView *airlinesPicker, *departurePicker;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    airlinesPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
    airlinesPicker.dataSource = self;
    airlinesPicker.delegate = self;
    airlinesPicker.showsSelectionIndicator = YES;
    airlinesPicker.tag = 1;
    self.chooseAirlineTextField.inputView = airlinesPicker;
    
    departurePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, 0, 0)];
    departurePicker.dataSource = self;
    departurePicker.delegate = self;
    departurePicker.showsSelectionIndicator = YES;
    departurePicker.tag = 2;
    self.departureTextField.inputView = departurePicker;
    
    
    [self getAirlinesAPI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
            return 0;
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
            return @"";
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
            [self.chooseAirlineTextField resignFirstResponder];
            
            [self.departureTextField setText:@""];
            [self getDepartureAPIWithAirlineId:airline.airlinesId];
        }
            
            break;
        case 2:
        {
            Airport *airport = [Airport listWithData:[departureList objectAtIndex:row]];
            self.departureTextField.text = airport.airportCity;
            [self.departureTextField resignFirstResponder];
        }
            
            break;
        case 3:
            
            break;
        default:
            break;
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
                                        
//                                        if ([response valueForKey:@"departure_airport"]) {
//                                            departureList = [response valueForKey:@"departure_airport"];
//                                            [departurePicker reloadAllComponents];
//                                        }
                                        
                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        
                                    } andFailureBlock:^(NSString *errorMessage) {
                                        
                                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                                        [self showBasicAlertMessageWithTitle:@"" message:errorMessage];
                                    }];
}

@end
