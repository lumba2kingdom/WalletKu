//
//  HasilPencarianViewController.m
//  digipay
//
//  Created by cybergarage on 7/3/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "HasilPencarianViewController.h"
#import "HasilPencarianTableViewCell.h"
#import "HasilPencarianReturnTableViewCell.h"

@interface HasilPencarianViewController ()

@end

@implementation HasilPencarianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _routeDepartLabel.text = [NSString stringWithFormat:@"%@  -  %@",_departureAirport,_destinationAirport];
    
    [_departTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _departTableView) {
        return [_departureList count];
    }
    return 0;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _departTableView) {
        static NSString *MyIdentifier = @"DepartCell";
        
        HasilPencarianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
        
        return cell;
    }
    else{
        static NSString *MyIdentifier = @"ReturnCell";
        
        HasilPencarianReturnTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
