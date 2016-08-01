//
//  TicketPesawatTableViewController.m
//  digipay
//
//  Created by cybergarage on 6/25/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "TicketPesawatTableViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "Constants.h"
#import "APIManager.h"
#import "HasilPencarianViewController.h"

#define RADIO_SELECTED_IMAGE_NAME @"radio-btn-check-orange"
#define RADIO_UNSELECTED_IMAGE_NAME @"radio-btn-uncheck-orange"

@interface TicketPesawatTableViewController () <UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIDatePicker *datepickerReturn;
    BOOL isOnewaySelected;
    NSString *airlinesID, *roundTrip, *departure, *destination, *adultQuantity, *childQuantity, *infantQuantity;
    NSDate *departDate, *returnDate;
}
@property (nonatomic) NSArray *airlinesArray;
@property (nonatomic) NSArray *departureArray;
@property (nonatomic) NSArray *destinationArray;
@property (strong, nonatomic) IBOutlet UIPickerView *dataAirlinePicker;
@property (strong, nonatomic) IBOutlet UIPickerView *dataDeparturePicker;
@property (strong, nonatomic) IBOutlet UIPickerView *dataDestinationPicker;
@end

@implementation TicketPesawatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setViewTransparent];
    [self onewaySelected];
    [self createNextToolbar];
    [self createAirlinePicker];
    [self createDeparturePicker];
    [self createDestinationPicker];
    [self createDepartDatePicker];
    [self getAirlinesList];
    [self createDashLineWithView:_dashLine1];
    [self createDashLineWithView:_dashLine2];
    [self createDashLineWithView:_dashLine3];
    [self createDashLineWithView:_dashLine4];
    isOnewaySelected = YES;
    roundTrip = @"oneway";
    
    UITapGestureRecognizer *backgroundTaped = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:backgroundTaped];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)disableField{
    _departureTextField.alpha = 0.5;
    _departureTextField.userInteractionEnabled = NO;
    _destinationTextField.alpha = 0.5;
    _destinationTextField.userInteractionEnabled = NO;
}

- (void)setViewTransparent{
    _radioOnewayView.backgroundColor = [UIColor clearColor];
    _radioReturnView.backgroundColor = [UIColor clearColor];
}

- (IBAction)radioOnewayButtonAction:(id)sender {
    [self onewaySelected];
}

- (IBAction)radioReturnButtonAction:(id)sender {
    [self returnSelected];
}

- (void)onewaySelected{
    _radioOnewayImageView.image = [UIImage imageNamed:RADIO_SELECTED_IMAGE_NAME];
    _radioReturnImageView.image = [UIImage imageNamed:RADIO_UNSELECTED_IMAGE_NAME];
    roundTrip = @"oneway";
}

- (void)returnSelected{
    _radioOnewayImageView.image = [UIImage imageNamed:RADIO_UNSELECTED_IMAGE_NAME];
    _radioReturnImageView.image = [UIImage imageNamed:RADIO_SELECTED_IMAGE_NAME];
    roundTrip = @"return";
}

- (void)createNextToolbar{
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil] ;
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                      style:UIBarButtonItemStyleDone target:self action:@selector(nextAction)];
    toolBar.items = @[flex,barButtonDone];
    barButtonDone.tintColor=[UIColor blackColor];
    
    _airlineTextField.inputAccessoryView = toolBar;
    _departureTextField.inputAccessoryView = toolBar;
    _destinationTextField.inputAccessoryView = toolBar;
    _dateDepartTextField.inputAccessoryView = toolBar;
    _dateReturnTextField.inputAccessoryView = toolBar;
    _adultQuantityTextField.inputAccessoryView = toolBar;
    _childQuantityTextField.inputAccessoryView = toolBar;
    _infantQuantityTextField.inputAccessoryView = toolBar;
}

- (void)createAirlinePicker{
    _dataAirlinePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 216)];
    _dataAirlinePicker.delegate = self;
    _dataAirlinePicker.dataSource = self;
    _dataAirlinePicker.showsSelectionIndicator = YES;
    
    _airlineTextField.inputView = _dataAirlinePicker;
}

- (void)createDeparturePicker{
    _dataDeparturePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 216)];
    _dataDeparturePicker.delegate = self;
    _dataDeparturePicker.dataSource = self;
    _dataDeparturePicker.showsSelectionIndicator = YES;
    
    _departureTextField.inputView = _dataDeparturePicker;
}

- (void)createDestinationPicker{
    _dataDestinationPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 216)];
    _dataDestinationPicker.delegate = self;
    _dataDestinationPicker.dataSource = self;
    _dataDestinationPicker.showsSelectionIndicator = YES;
    
    _destinationTextField.inputView = _dataDestinationPicker;
}

- (void)createDepartDatePicker{
    UIDatePicker *datepickerDepart=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 216)];
    datepickerDepart.datePickerMode = UIDatePickerModeDate;
    datepickerDepart.hidden = NO;
    datepickerDepart.date = [NSDate date];
    datepickerDepart.minimumDate = [NSDate date];
    
    [datepickerDepart addTarget:self
                   action:@selector(dateSelectedDepart:)
         forControlEvents:UIControlEventValueChanged];
    _dateDepartTextField.inputView = datepickerDepart;
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd MMMM yyyy"];
    departDate = datepickerDepart.date;
    _dateDepartTextField.text=[df stringFromDate:datepickerDepart.date];
    [self createReturnDatePickerWithDate:datepickerDepart.date];
}

- (void)dateSelectedDepart:(id)sender{
    NSDateFormatter * dformatted = [[NSDateFormatter alloc] init];
    [dformatted setDateFormat:@"dd MMMM yyyy"];
     departDate = [(UIDatePicker *)sender date];
    _dateDepartTextField.text=[dformatted stringFromDate:[(UIDatePicker *)sender date]];
    
    [self createReturnDatePickerWithDate:[(UIDatePicker *)sender date]];
}

- (void)createReturnDatePickerWithDate:(NSDate *)date{
    datepickerReturn =[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 216)];
    datepickerReturn.datePickerMode = UIDatePickerModeDate;
    datepickerReturn.hidden = NO;
    datepickerReturn.date = date;
    datepickerReturn.minimumDate = date;
    
    [datepickerReturn addTarget:self
                         action:@selector(dateSelectedReturn:)
               forControlEvents:UIControlEventValueChanged];
    _dateReturnTextField.inputView = datepickerReturn;
    
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd MMMM yyyy"];
     returnDate = datepickerReturn.date;
    _dateReturnTextField.text=[df stringFromDate:datepickerReturn.date];
}

- (void)dateSelectedReturn:(id)sender{
    NSDateFormatter * dformatted = [[NSDateFormatter alloc] init];
    [dformatted setDateFormat:@"dd MMMM yyyy"];
    returnDate = [(UIDatePicker *)sender date];
    _dateReturnTextField.text=[dformatted stringFromDate:[(UIDatePicker *)sender date]];
}

- (void)nextAction{
    if (_airlineTextField.isFirstResponder) {
        [_departureTextField becomeFirstResponder];
    }
    else if (_departureTextField.isFirstResponder) {
        [_destinationTextField becomeFirstResponder];
    }
    else if (_destinationTextField.isFirstResponder) {
        [_dateDepartTextField becomeFirstResponder];
    }
    else if (_dateDepartTextField.isFirstResponder) {
        [_dateReturnTextField becomeFirstResponder];
    }
    else if (_dateReturnTextField.isFirstResponder) {
        [_adultQuantityTextField becomeFirstResponder];
    }
    else if(_adultQuantityTextField.isFirstResponder){
        [_childQuantityTextField becomeFirstResponder];
    }
    else if(_childQuantityTextField.isFirstResponder){
        [_infantQuantityTextField becomeFirstResponder];
    }
    else if(_infantQuantityTextField.isFirstResponder){
        [_infantQuantityTextField resignFirstResponder];
    }
}

- (void)dismissKeyboard{
    [_airlineTextField resignFirstResponder];
    [_departureTextField resignFirstResponder];
    [_destinationTextField resignFirstResponder];
    [_dateDepartTextField resignFirstResponder];
    [_dateDepartTextField resignFirstResponder];
    [_adultQuantityTextField resignFirstResponder];
    [_childQuantityTextField resignFirstResponder];
    [_infantQuantityTextField resignFirstResponder];
    
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
//    [_dataPicker reloadAllComponents];
//    return YES;
//}

#pragma mark PickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger) pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component{
    if ([pickerView isEqual:_dataAirlinePicker])
    {
        return [_airlinesArray count];
    }
    else if ([pickerView isEqual:_dataDeparturePicker]){
        return [_departureArray count];
    }
    else if ([pickerView isEqual:_dataDestinationPicker]){
        return [_destinationArray count];
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([pickerView isEqual:_dataAirlinePicker]) {
        return [[_airlinesArray objectAtIndex:row] valueForKey:@"airlines_name"];
    }
    else if ([pickerView isEqual:_dataDeparturePicker]) {
        return [[_departureArray objectAtIndex:row] valueForKey:@"airport_city"];
    }
    else if ([pickerView isEqual:_dataDestinationPicker]) {
        return [[_destinationArray objectAtIndex:row] valueForKey:@"airport_city"];
    }
    return @"";
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([pickerView isEqual:_dataAirlinePicker]) {
        _airlineTextField.text = [[_airlinesArray objectAtIndex:row] valueForKey:@"airlines_name"];
        airlinesID = [NSString stringWithFormat:@"%@",[[_airlinesArray objectAtIndex:row] valueForKey:@"airlines_id"]];
        [self getDepartureListWithAirlineID:airlinesID];
    }
    else if ([pickerView isEqual:_dataDeparturePicker]) {
        _departureTextField.text = [[_departureArray objectAtIndex:row] valueForKey:@"airport_city"];
        departure = [NSString stringWithFormat:@"%@",[[_departureArray objectAtIndex:row] valueForKey:@"airport_code"]];
        [self getDestinationListWithAirlineID:airlinesID WithDepartureID:departure];
    }
    else if ([pickerView isEqual:_dataDestinationPicker]) {
        _destinationTextField.text = [[_destinationArray objectAtIndex:row] valueForKey:@"airport_city"];
        destination = [[_destinationArray objectAtIndex:row] valueForKey:@"airport_code"];
    }
}

#pragma mark - Fetch AERO

- (void)getAirlinesList{
    [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:AEROFLIGHT_URL parameters:@{@"akses_kode":AEROFLIGHT_ACCESS_CODE,
                                              @"app":@"info",
                                              @"action":@"get_airlines"}
         progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"%@",responseObject);
             _airlinesArray = [responseObject valueForKey:@"airlines_data"];
             [_dataAirlinePicker reloadAllComponents];
             [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
             if (_airlinesArray.count > 0) {
                 _airlineTextField.text = [[_airlinesArray firstObject] valueForKey:@"airlines_name"];
                 airlinesID = [NSString stringWithFormat:@"%@",[[_airlinesArray firstObject] valueForKey:@"airlines_id"]];
                [self getDepartureListWithAirlineID:[[_airlinesArray firstObject] valueForKey:@"airlines_id"]];
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"%@",error);
             [self disableField];
             [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
         }];
}

- (void)getDepartureListWithAirlineID:(NSString *)airlineID{
    [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager POST:AEROFLIGHT_URL parameters:@{@"akses_kode":AEROFLIGHT_ACCESS_CODE,
                                              @"app":@"info",
                                              @"action":@"get_departure_airport",
                                              @"airline":airlineID}
         progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"%@",responseObject);
             _departureArray = [responseObject valueForKey:@"departure_airport"];
             [_dataDeparturePicker reloadAllComponents];
             [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
             if (_departureArray.count > 0) {
                 _departureTextField.text = [[_departureArray firstObject] valueForKey:@"airport_city"];
                 departure = [[_departureArray firstObject] valueForKey:@"airport_code"];
                 [self getDestinationListWithAirlineID:airlineID WithDepartureID:[[_departureArray firstObject] valueForKey:@"airport_code"]];
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"%@",error);
             [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
         }];
}

- (void)getDestinationListWithAirlineID:(NSString *)airlineID WithDepartureID:(NSString *)departureID{
    [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    NSLog(@"%@",@{@"akses_kode":AEROFLIGHT_ACCESS_CODE,
                  @"app":@"info",
                  @"act":@"get_arrival_airport",
                  @"airline":airlineID,
                  @"departure_airport":departureID});
    [manager POST:AEROFLIGHT_URL parameters:@{@"akses_kode":AEROFLIGHT_ACCESS_CODE,
                                              @"app":@"info",
                                              @"action":@"get_arrival_airport",
                                              @"airline":[NSNumber numberWithInt:[airlineID intValue]],
                                              @"departure":departureID}
         progress:^(NSProgress * _Nonnull uploadProgress) {
             
         } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"%@",responseObject);
             _destinationArray = [responseObject valueForKey:@"arrival_airport"];
             [_dataDestinationPicker reloadAllComponents];
             [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
             if (_departureArray.count > 0) {
                 _destinationTextField.text = [[_destinationArray firstObject] valueForKey:@"airport_city"];
                 destination = [[_destinationArray firstObject] valueForKey:@"airport_code"];
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"%@",error);
             [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
         }];
}

- (void)createDashLineWithView:(UIView *)view{
    [view layoutIfNeeded];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:view.frame];
    [shapeLayer setPosition:view.center];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    [shapeLayer setStrokeColor:[view.backgroundColor CGColor]];
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinBevel];
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:10],
      [NSNumber numberWithInt:5],nil]];
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(self.view.frame), 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    [[view layer] addSublayer:shapeLayer];
    view.backgroundColor = [UIColor clearColor];
}

- (IBAction)searchButtonAction:(id)sender {
    if (![self isCheckSeatQuantityPass]) {
        return;
    }
    NSDateFormatter * dformatted = [[NSDateFormatter alloc] init];
    [dformatted setDateFormat:@"yyyy-MM-dd"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:airlinesID forKey:@"airline"];
    if (isOnewaySelected) {
        [params setObject:@"oneway" forKey:@"roundtrip"];
    }
    else{
        [params setObject:@"return" forKey:@"roundtrip"];
        [params setObject:[dformatted stringFromDate:returnDate] forKey:@"depart"];
    }
    [params setObject:departure forKey:@"from"];
    [params setObject:destination forKey:@"to"];
    [params setObject:[dformatted stringFromDate:departDate] forKey:@"depart"];
    if (![adultQuantity isEqualToString:@"0"] && ![adultQuantity isEqualToString:@""]) {
        [params setObject:adultQuantity forKey:@"adult"];
    }
    if (![childQuantity isEqualToString:@"0"] && ![childQuantity isEqualToString:@""]) {
        [params setObject:childQuantity forKey:@"child"];
    }
    if (![infantQuantity isEqualToString:@"0"] && ![infantQuantity isEqualToString:@""]) {
        [params setObject:infantQuantity forKey:@"infant"];
    }
    [MBProgressHUD showHUDAddedTo:[[[UIApplication sharedApplication] delegate] window] animated:YES];
    [APIManager getAPIWithParam:params
                                   andEndPoint:kPostFlightsSearch withAuthorization:NO successBlock:^(NSDictionary *response) {
                                       NSLog(@"response %@",response);
                                       [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
                                       if (![[response valueForKey:@"error_no"] isEqualToString:@"0"]) {
                                           return;
                                       }
                                       HasilPencarianViewController *hasilpencarianVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HasilPencarianVC"];
                                       hasilpencarianVC.departureAirport = _departureTextField.text;
                                       hasilpencarianVC.destinationAirport = _destinationTextField.text;
                                       hasilpencarianVC.departureList = [[response valueForKey:@"schedule"] valueForKey:@"depart"];
                                       hasilpencarianVC.airlineData = [response valueForKey:@"airlines_detail"];
                                       hasilpencarianVC.searchInfo = [response valueForKey:@"search_info"];
                                       [self.navigationController pushViewController:hasilpencarianVC animated:YES];
                                   } andFailureBlock:^(NSString *errorMessage) {
                                       NSLog(@"error %@",errorMessage);
                                       [MBProgressHUD hideHUDForView:[[[UIApplication sharedApplication] delegate] window] animated:YES];
                                   }];
}

- (BOOL)isCheckSeatQuantityPass{
    if (([_adultQuantityTextField.text isEqualToString:@"0"] || [_adultQuantityTextField.text isEqualToString:@""]) && ([_childQuantityTextField.text isEqualToString:@"0"] || [_childQuantityTextField.text isEqualToString:@""]) && ([_infantQuantityTextField.text isEqualToString:@"0"] || [_infantQuantityTextField.text isEqualToString:@""])) {
        return NO;
    }
    else{
        if (![_adultQuantityTextField.text isEqualToString:@"0"] || ![_adultQuantityTextField.text isEqualToString:@""]) {
            adultQuantity = _adultQuantityTextField.text;
        }
        if (![_childQuantityTextField.text isEqualToString:@"0"] || ![_childQuantityTextField.text isEqualToString:@""]) {
            childQuantity = _childQuantityTextField.text;
        }
        if (![_infantQuantityTextField.text isEqualToString:@"0"] || ![_infantQuantityTextField.text isEqualToString:@""]) {
            infantQuantity = _infantQuantityTextField.text;
        }
        return YES;
    }
}

@end
