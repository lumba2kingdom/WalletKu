//
//  TiketSearchResultViewController.h
//  digipay
//
//  Created by Lutfi Azhar on 8/7/16.
//  Copyright © 2016 Lutfi Azhar. All rights reserved.
//

#import "BaseViewController.h"

@interface TiketSearchResultViewController : BaseViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) NSDictionary *searchResultObject;

@property (weak, nonatomic) IBOutlet UIView *departView;
@property (weak, nonatomic) IBOutlet UIView *returnView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *departHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *returnHeightConstraint;

@property (weak, nonatomic) IBOutlet UILabel *fromToDepartLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateDepartLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromToReturnLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateReturnLabel;


@property (weak, nonatomic) IBOutlet UITableView *departTableView;
@property (weak, nonatomic) IBOutlet UITableView *returnTableView;

- (IBAction)nextButtonAction:(UIButton *)sender;
@end
