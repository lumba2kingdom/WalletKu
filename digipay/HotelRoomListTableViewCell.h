//
//  HotelRoomListTableViewCell.h
//  digipay
//
//  Created by Lutfi Azhar on 8/10/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelRoomListTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *hotelRoomImageView;
@property (weak, nonatomic) IBOutlet UILabel *hotelRoomPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotelRoomDetailLabel;
@property (weak, nonatomic) IBOutlet UIButton *hotelRoomSelectButton;

@end
