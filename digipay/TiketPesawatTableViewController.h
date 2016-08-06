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
@end
