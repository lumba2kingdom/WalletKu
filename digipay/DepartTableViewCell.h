//
//  DepartTableViewCell.h
//  digipay
//
//  Created by Lutfi Azhar on 8/7/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DepartTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *airlineNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *airlineTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *airlineTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *airlinePriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end
