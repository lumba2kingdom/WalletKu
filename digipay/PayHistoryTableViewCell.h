//
//  PayHistoryTableViewCell.h
//  digipay
//
//  Created by Lutfi Azhar on 1/25/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *providerPlusNominalLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *nomorTujuanLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *hargaLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

@end
