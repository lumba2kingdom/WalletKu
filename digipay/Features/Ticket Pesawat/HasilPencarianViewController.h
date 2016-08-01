//
//  HasilPencarianViewController.h
//  digipay
//
//  Created by cybergarage on 7/3/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HasilPencarianViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *departView;
@property (weak, nonatomic) IBOutlet UILabel *routeDepartLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateAndQuantityDepartLabel;
@property (weak, nonatomic) IBOutlet UIButton *pencarianUlangButton;
@property (weak, nonatomic) IBOutlet UITableView *departTableView;

@property (weak, nonatomic) IBOutlet UIView *returnView;
@property (weak, nonatomic) IBOutlet UILabel *routeReturnLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateAndQuantityReturnLabel;
@property (weak, nonatomic) IBOutlet UITableView *returnTableView;

@property (nonatomic) NSString *departureAirport;
@property (nonatomic) NSString *destinationAirport;
@property (nonatomic) NSDictionary *airlineData;
@property (nonatomic) NSArray *departureList;
@property (nonatomic) NSDictionary *searchInfo;
@end
