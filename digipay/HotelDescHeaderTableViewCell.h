//
//  HotelDescHeaderTableViewCell.h
//  digipay
//
//  Created by Lutfi Azhar on 8/10/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelDescHeaderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *hotelNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *hotelDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotelBookDateLabel;
@end
