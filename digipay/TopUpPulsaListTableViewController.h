//
//  TopUpPulsaListTableViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 3/4/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopUpPulsaTableViewController.h"

@interface TopUpPulsaListTableViewController : UITableViewController

@property (nonatomic, weak) id<topUpProtocol> delegate;

@property (nonatomic) NSMutableArray *providerList;

@property (nonatomic) BOOL isForNominal;

@end
