//
//  TopupListrikTableViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 3/31/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol topUpProtocol

- (void)setProvider:(NSMutableArray *)provider;
- (void)setNominal:(NSMutableArray *)nominal;

@end

@interface TopupListrikTableViewController : UITableViewController <topUpProtocol>

@property (weak, nonatomic) IBOutlet UILabel *balanceText;
@property (weak, nonatomic) IBOutlet UITextField *selectProviderTF;
@property (weak, nonatomic) IBOutlet UITextField *nominalTF;
@property (weak, nonatomic) IBOutlet UITextField *nomerMeterTF;
@property (nonatomic, weak) UITextField* pinTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedNotifikasi;
@property (nonatomic, weak) UITextField* emailAddressTextField;
@property (nonatomic, weak) UITextField* phoneTextField;

- (IBAction)selectProviderBtn:(UIButton *)sender;
- (IBAction)beliBtn:(UIButton *)sender;
- (IBAction)selectNominalBtn:(UIButton *)sender;
- (IBAction)segmentedNotifikasi:(UISegmentedControl *)sender;

@property (nonatomic) NSMutableArray *providerList;


@end
