//
//  HotelListViewController.m
//  digipay
//
//  Created by Lutfi Azhar on 8/9/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "HotelListViewController.h"
#import "HotelTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "HotelDetailTableViewController.h"

@interface HotelListViewController ()

@end

@implementation HotelListViewController {
    BOOL apiCalled;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"hotelToHotelDetail"]) {
        HotelDetailTableViewController *hotelDetailController = (HotelDetailTableViewController *)[segue destinationViewController];
        hotelDetailController.resultData = (NSDictionary *)sender;
        
    }
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return self.hotelListData.count;
            
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            UITableViewCell *headerCell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
            return headerCell;
        }
            break;
        case 1:
        {
            HotelTableViewCell *hotelCell = [tableView dequeueReusableCellWithIdentifier:@"hotelListCell"];
            
            hotelCell.hotelNameLabel.text = [[self.hotelListData valueForKey:@"name"] objectAtIndex:indexPath.row];
            hotelCell.hotelPriceLabel.text = [NSString stringWithFormat:@"Rp.%@,-", [[self.hotelListData valueForKey:@"price"] objectAtIndex:indexPath.row]];
            hotelCell.hotelAddressLabel.text = [[self.hotelListData valueForKey:@"address"] objectAtIndex:indexPath.row];
            
            hotelCell.hotelImage.clipsToBounds = YES;
            NSURL *imageURL = [NSURL URLWithString:[[self.hotelListData valueForKey:@"thumbNailUrl"] objectAtIndex:indexPath.row]];
            NSURLRequest *imageRequest = [NSURLRequest requestWithURL:imageURL];
            
            hotelCell.hotelImage.image = nil;
            [hotelCell.hotelImage setImageWithURLRequest:imageRequest placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
                
                hotelCell.hotelImage.image = image;
            } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
                
                hotelCell.hotelImage.image = nil;
            }];
            
            
            return hotelCell;
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
            return 150;
            break;
        case 1:
            return 125;
        default:
            return 0;
            break;
    }
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        if (!apiCalled) {
            [self getHotelDetailAPIWithIndex:(int)indexPath.row];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - API method
- (void)getHotelDetailAPIWithIndex:(int)index {
    apiCalled = YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[APIManager sharedManager] getAPIWithParam:@{
                                                  @"session_id":self.sessionId,
                                                  @"hotelId":[[self.hotelListData valueForKey:@"hotelId"] objectAtIndex:index]
                                                  }andEndPoint:kGetHotelDetail withAuthorization:NO successBlock:^(NSDictionary *response) {
        
                                                      [self performSegueWithIdentifier:@"hotelToHotelDetail" sender:response];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        apiCalled = NO;
    } andFailureBlock:^(NSString *errorMessage) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        apiCalled = NO;
    }];
}
@end
