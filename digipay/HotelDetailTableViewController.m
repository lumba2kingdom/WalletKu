//
//  HotelDetailTableViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 8/10/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "HotelDetailTableViewController.h"
#import "HotelImageHeaderTableViewCell.h"
#import "HotelDescHeaderTableViewCell.h"
#import "HotelRoomListTableViewCell.h"
#import "UIImageView+AFNetworking.h"

@interface HotelDetailTableViewController ()

@end

@implementation HotelDetailTableViewController {
    NSArray *availableRoomsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    availableRoomsArray = [NSArray arrayWithArray:[self.resultData valueForKeyPath:@"result_data.available_room"]];
    self.tableView.estimatedRowHeight = 130;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
        case 2:
            return [availableRoomsArray count];
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            HotelImageHeaderTableViewCell *imageHeaderCell = [tableView dequeueReusableCellWithIdentifier:@"hotelImageHeaderCell"];
            
            
            imageHeaderCell.hotelImageView.clipsToBounds = YES;
            NSURL *imageURL = [NSURL URLWithString:[[self.resultData valueForKeyPath:@"result_data.image_thumb.big_img"] firstObject]];
            NSURLRequest *imageRequest = [NSURLRequest requestWithURL:imageURL];
            
            imageHeaderCell.hotelImageView.image = nil;
            [imageHeaderCell.hotelImageView setImageWithURLRequest:imageRequest placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                
                imageHeaderCell.hotelImageView.image = image;
            } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                
                imageHeaderCell.hotelImageView.image = nil;
            }];
            
            return imageHeaderCell;
        }
            break;
        case 1:
        {
            HotelDescHeaderTableViewCell *hotelDescCell = [tableView dequeueReusableCellWithIdentifier:@"hotelDescHeaderCell"];
            
            hotelDescCell.hotelNameLabel.text = [self.resultData valueForKeyPath:@"result_data.name"];
            hotelDescCell.hotelDescriptionLabel.text = [NSString stringWithFormat:@"Fasilitas Hotel: %@ \nFasilitas Kamar: %@ \nInstruksi: %@", [self.resultData valueForKeyPath:@"result_data.hotel_info.hotel_facilities"], [self.resultData valueForKeyPath:@"result_data.hotel_info.room_facilities"], [self.resultData valueForKeyPath:@"result_data.hotel_info.checkInInstructions"] ];
            hotelDescCell.hotelBookDateLabel.text = [NSString stringWithFormat:@"Tanggal Booking: %@ - %@", [self.resultData valueForKeyPath:@"search_info.ci"], [self.resultData valueForKeyPath:@"search_info.co"]];
            
            return hotelDescCell;
        }
            break;
        case 2:
        {
            HotelRoomListTableViewCell *hotelRoomList = [tableView dequeueReusableCellWithIdentifier:@"hotelRoomListCell"];
            
            hotelRoomList.hotelRoomImageView.clipsToBounds = YES;
            NSURL *imageURL = [NSURL URLWithString:[[self.resultData valueForKeyPath:@"result_data.available_room.small_images"] objectAtIndex:indexPath.row]];
            NSURLRequest *imageRequest = [NSURLRequest requestWithURL:imageURL];
            
            hotelRoomList.hotelRoomImageView.image = nil;
            [hotelRoomList.hotelRoomImageView setImageWithURLRequest:imageRequest placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                
                hotelRoomList.hotelRoomImageView.image = image;
            } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                
                hotelRoomList.hotelRoomImageView.image = nil;
            }];
            
            
            hotelRoomList.hotelRoomPriceLabel.text = [NSString stringWithFormat:@"Rp.%@,-", [[self.resultData valueForKeyPath:@"result_data.available_room.total_price"] objectAtIndex:indexPath.row]];
            hotelRoomList.hotelRoomDetailLabel.text = [NSString stringWithFormat:@"Kapasitas Kamar: %@ Orang", [[self.resultData valueForKeyPath:@"result_data.available_room.room_capacity"] objectAtIndex:indexPath.row]];
            
            return hotelRoomList;
        }
            break;
            
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return self.view.bounds.size.width/1.5;
            break;
        case 1:
            return UITableViewAutomaticDimension;
        default:
            return 125;
            break;
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
