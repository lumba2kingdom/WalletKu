//
//  TicketPesawatTableViewController.h
//  digipay
//
//  Created by cybergarage on 6/25/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TicketPesawatTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *airlineTextField;
@property (weak, nonatomic) IBOutlet UIView *radioOnewayView;
@property (weak, nonatomic) IBOutlet UIView *radioReturnView;
@property (weak, nonatomic) IBOutlet UIImageView *radioOnewayImageView;
@property (weak, nonatomic) IBOutlet UIImageView *radioReturnImageView;
@property (weak, nonatomic) IBOutlet UITextField *departureTextField;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateDepartTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateReturnTextField;
@property (weak, nonatomic) IBOutlet UITextField *adultQuantityTextField;
@property (weak, nonatomic) IBOutlet UITextField *childQuantityTextField;
@property (weak, nonatomic) IBOutlet UITextField *infantQuantityTextField;

@property (weak, nonatomic) IBOutlet UILabel *departureLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateDepartLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateReturnLabel;

@property (weak, nonatomic) IBOutlet UIView *dashLine1;
@property (weak, nonatomic) IBOutlet UIView *dashLine2;
@property (weak, nonatomic) IBOutlet UIView *dashLine3;
@property (weak, nonatomic) IBOutlet UIView *dashLine4;

- (IBAction)radioOnewayButtonAction:(id)sender;
- (IBAction)radioReturnButtonAction:(id)sender;
- (IBAction)searchButtonAction:(id)sender;
@end
