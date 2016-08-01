//
//  HasilPencarianTableViewCell.h
//  digipay
//
//  Created by cybergarage on 7/3/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HasilPencarianTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *roundedBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *airlineNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *flightTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end
