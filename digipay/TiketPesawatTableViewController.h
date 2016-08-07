//
//  TiketPesawatTableViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 8/6/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "BaseTableViewController.h"

@interface TiketPesawatTableViewController : BaseTableViewController <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *chooseAirlineTextField;
@property (weak, nonatomic) IBOutlet UITextField *departureTextField;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;

@property (weak, nonatomic) IBOutlet UITextField *dateDepartTextField;

@property (weak, nonatomic) IBOutlet UILabel *dateReturnLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateReturnAsterisk;
@property (weak, nonatomic) IBOutlet UITextField *dateReturnTextField;

@property (weak, nonatomic) IBOutlet UIImageView *oneWayRadioButtonImage;
@property (weak, nonatomic) IBOutlet UIImageView *returnRadioButtonImage;

@property (weak, nonatomic) IBOutlet UITextField *adultTextField;
@property (weak, nonatomic) IBOutlet UITextField *childTextField;
@property (weak, nonatomic) IBOutlet UITextField *infantTextField;

- (IBAction)onewayButtonAction:(UIButton *)sender;
- (IBAction)returnButtonAction:(UIButton *)sender;
- (IBAction)searchButtonAction:(UIButton *)sender;


@end
