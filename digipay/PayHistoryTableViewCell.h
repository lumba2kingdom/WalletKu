//
//  PayHistoryTableViewCell.h
//  digipay
//
//  Created by Lutfi Azhar on 1/25/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayHistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *paymentIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentDescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;

@end
