//
//  TopUpPulsaTableViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 1/29/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "BaseTableViewController.h"

@protocol topUpProtocol

- (void)setProvider:(NSMutableArray *)provider;
- (void)setNominal:(NSMutableArray *)nominal;

@end

@interface TopUpPulsaTableViewController : BaseTableViewController <topUpProtocol>

@property (weak, nonatomic) IBOutlet UILabel *balanceText;
@property (weak, nonatomic) IBOutlet UITextField *selectProviderTF;
@property (weak, nonatomic) IBOutlet UITextField *nominalTF;
@property (weak, nonatomic) IBOutlet UITextField *nomerHPTF;
@property (nonatomic, weak) UITextField* pinTF;

- (IBAction)selectProviderBtn:(UIButton *)sender;
- (IBAction)beliBtn:(UIButton *)sender;
- (IBAction)selectNominalBtn:(UIButton *)sender;

@property (nonatomic) NSMutableArray *providerList;

@end
